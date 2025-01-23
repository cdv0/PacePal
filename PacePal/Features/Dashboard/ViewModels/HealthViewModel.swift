//
//  HealthViewModel.swift
//  PacePal
//
//  Created by Cathleen Vu on 1/22/25.
//

import Foundation
import HealthKit

class HealthViewModel: ObservableObject {
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
                    print("Health data is unavailable on the user's device.")
                return
                }
                
                try await healthStore.requestAuthorization(toShare: [], read: healthTypes)
            } catch {
                fatalError("DEBUG: Failed to fetch health data with error \(error.localizedDescription)")
            }
        }
    }
}
