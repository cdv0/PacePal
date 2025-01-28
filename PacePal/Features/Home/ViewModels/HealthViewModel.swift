//
//  HealthViewModel.swift
//  PacePal
//
//  Created by Cathleen Vu on 1/22/25.
//

import Foundation
import HealthKit

class HealthViewModel: ObservableObject {
    @Published var steps: [Steps] = []
    @Published var calories: Calories = Calories(count: 0, date: Date())
    @Published var distance: Distance = Distance(count: 0, date: Date())
    @Published var activeTime: ActiveTime = ActiveTime(seconds: 0, date: Date())
    
    let healthStore = HKHealthStore()
    
    init() {
        let healthTypes: Set = [
            HKQuantityType(.stepCount),
            HKQuantityType(.activeEnergyBurned),
            HKQuantityType(.distanceWalkingRunning),

        ]
        
        Task {
            do {
                if !HKHealthStore.isHealthDataAvailable() {
                    print("DEBUG: Health data is unavailable on the user's device.")
                return
                }
                
                try await healthStore.requestAuthorization(toShare: [], read: healthTypes) // toShare specifies the types of health data your app wants to write to the health app. read specifies the type of health data your apap wants to read form the health app. Both accept a set.
            } catch {
                fatalError("DEBUG: Failed to fetch health data with error \(error.localizedDescription)")
            }
        }
    }
    
    func fetchStepsForLastNDays(numberOfDays: Int, interval: DateComponents) async throws {
        let startDate = Calendar.current.startOfDay(for: Calendar.current.date(byAdding: .day, value: -numberOfDays + 1, to: Date())!) // Add 1 to value to have the current day be value 1
        let endDate = Calendar.current.date(bySettingHour: 23, minute: 59, second: 59, of: Date())! // 11:59:59 PM
        do {
            try await fetchSteps(from: startDate, to: endDate, interval: interval)
        } catch {
            print("DEBUG: Failed to fetch steps for the last \(numberOfDays) days with error \(error.localizedDescription)")
        }
    }
    
    func fetchSteps(from startDate: Date, to endDate: Date, interval: DateComponents) async throws {
        guard let stepsType = HKQuantityType.quantityType(forIdentifier: .stepCount) else { return } // Creates an instance of HKQuantityType and gets the *type* of the data we're querying for
        let predicate = HKQuery.predicateForSamples(withStart: startDate, // Creates a predicate (filter) the health data you're querying for based on certain criteria. .strictStartDate ensures the start date is inclusive.
                                                    end: endDate,
                                                    options: .strictStartDate)
        let query = HKSamplePredicate.quantitySample(type: stepsType, // Extracts specific data from the predicate
                                                     predicate: predicate)
        let stepsQuery = HKStatisticsCollectionQueryDescriptor(predicate: query, // Describes the query to be executed. This aggregates step count data. It doesn't retrieve the data
                                                               options: .cumulativeSum,
                                                               anchorDate: startDate,
                                                               intervalComponents: interval)
        let stepsCount = try await stepsQuery.result(for: healthStore) // Fetches the steps
        
        // Clear the array once before the loop
        DispatchQueue.main.async {
            self.steps = []
        }
        
        stepsCount.enumerateStatistics(from: startDate, to: endDate) { statistics, _ in
            let count = statistics.sumQuantity()?.doubleValue(for: .count()) ?? 0
            let step = Steps(count: Int(count), date: statistics.startDate) // Use the interval's start date for each result
            
            DispatchQueue.main.async {
                self.steps.insert(step, at: 0)
            }
        }
    }
    
    // TODO: If user doesn't have an apple watch, try to estimate calories burned based on user stats
    func fetchCalories(from startDate: Date, to endDate: Date, interval: DateComponents) async throws {
        guard let calorieType = HKQuantityType.quantityType(forIdentifier: .activeEnergyBurned) else { return }
        let predicate = HKQuery.predicateForSamples(withStart: startDate,
                                                    end: endDate,
                                                    options: .strictStartDate)
        let query = HKSamplePredicate.quantitySample(type: calorieType,
                                                     predicate: predicate)
        let calorieQuery = HKStatisticsCollectionQueryDescriptor(predicate: query,
                                                                 options: .cumulativeSum,
                                                                 anchorDate: startDate,
                                                                 intervalComponents: interval)
        let calorieCount = try await calorieQuery.result(for: healthStore)
        
        calorieCount.enumerateStatistics(from: startDate, to: endDate) { statistics, _ in
            let count = statistics.sumQuantity()?.doubleValue(for: .kilocalorie()) ?? 0
            let calories = Calories(count: Int(count), date: statistics.startDate)
            
            DispatchQueue.main.async {
                self.calories = calories
            }
        }
    }
    
    func fetchDistance(from startDate: Date, to endDate: Date, interval: DateComponents) async throws {
        guard let distanceType = HKQuantityType.quantityType(forIdentifier: .distanceWalkingRunning) else { return }
        let predicate = HKQuery.predicateForSamples(withStart: startDate,
                                                    end: endDate,
                                                    options: .strictStartDate)
        let query = HKSamplePredicate.quantitySample(type: distanceType,
                                                     predicate: predicate)
        let distanceQuery = HKStatisticsCollectionQueryDescriptor(predicate: query,
                                                                 options: .cumulativeSum,
                                                                 anchorDate: startDate,
                                                                 intervalComponents: interval)
        let distanceCount = try await distanceQuery.result(for: healthStore)
        
        distanceCount.enumerateStatistics(from: startDate, to: endDate) { statistics, _ in
            let count = statistics.sumQuantity()?.doubleValue(for: .mile()) ?? 0
            let distance = Distance(count: Double(count), date: statistics.startDate)
            
            DispatchQueue.main.async {
                self.distance = distance
            }
        }
    }
    
    func fetchActiveTime(from startDate: Date, to endDate: Date, interval: DateComponents) async throws {
        guard let activeTimeType = HKQuantityType.quantityType(forIdentifier: .appleExerciseTime) else { return }
        let predicate = HKQuery.predicateForSamples(withStart: startDate,
                                                    end: endDate,
                                                    options: .strictStartDate)
        let query = HKSamplePredicate.quantitySample(type: activeTimeType,
                                                     predicate: predicate)
        let activeTimeQuery = HKStatisticsCollectionQueryDescriptor(predicate: query,
                                                                 options: .cumulativeSum,
                                                                 anchorDate: startDate,
                                                                 intervalComponents: interval)
        let activeTimeCount = try await activeTimeQuery.result(for: healthStore)
        
        activeTimeCount.enumerateStatistics(from: startDate, to: endDate) { statistics, _ in
            let count = statistics.sumQuantity()?.doubleValue(for: .second()) ?? 0
            let activeTime = ActiveTime(seconds: Int(count), date: statistics.startDate)
            
            DispatchQueue.main.async {
                self.activeTime = activeTime
            }
        }
    }
}
