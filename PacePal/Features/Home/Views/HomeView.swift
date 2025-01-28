//
//  HomeView.swift
//  PacePal
//
//  Created by Cathleen Vu on 1/20/25.
//

import SwiftUI

struct HomeView: View {    
    @EnvironmentObject var healthViewModel: HealthViewModel
    @State private var displayType = "chart.bar"

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    var body: some View {
        NavigationStack {
            VStack {
                Text("Goal: 10,000") // TODO: Allow user to set their own goal
                    .font(.headline)
                    .padding()
                
                Spacer()
                
                // MARK: STEP COUNT
                Text("\(healthViewModel.steps.first?.count ?? 0)")
                    .font(.system(size: 53))
                    .fontWeight(.bold)

                Text("Steps")
                    .foregroundStyle(.gray)
                    .font(.system(size: 15))

                VStack {
                    LazyVGrid(columns: columns) {
                        
                        // MARK: MILES WALKED CARD
                        ZStack {
                            Rectangle()
                                .fill(.white)
                                .customCardView(width: .infinity,
                                                height: UIScreen.main.bounds.height * 0.1)
                                
                            VStack(spacing: 5) {
                                Text(String(format: "%.2f", healthViewModel.distance.count))
                                Text("Miles")
                                    .foregroundStyle(.secondary)
                                    .font(.system(size: 16))
                            }
                        }
                        .padding(4)
                        
                        // MARK: CALORIES BURNED CARD
                        ZStack {
                            Rectangle()
                                .fill(.white)
                                .customCardView(width: .infinity,
                                                height: UIScreen.main.bounds.height * 0.1)
                            
                            VStack(spacing: 5) {
                                Text("\(healthViewModel.calories.count)")
                                Text("Calories")
                                    .foregroundStyle(.secondary)
                                    .font(.system(size: 16))
                            }
                        }
                        .padding(4)

                        // MARK: ACTIVE TIME CARD
                        ZStack {
                            Rectangle()
                                .fill(.white)
                                .customCardView(width: .infinity,
                                                height: UIScreen.main.bounds.height * 0.1)
                            
                            VStack(spacing: 5) {
                                Text(healthViewModel.activeTime.formatted)
                                Text("Exercise Time")
                                    .foregroundStyle(.secondary)
                                    .font(.system(size: 16))
                            }
                        }
                        .padding(4)

                    }
                    .font(.system(size: 13))
                    .padding()
                }
                .padding([.top, .bottom], 15)
                
                // MARK: LIST AND CHART VIEW PICKER
                Picker("Selection", selection: $displayType) {
                    Text("Chart")
                        .tag("chart")
                    Text("List")
                        .tag("list")
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                
                // MARK: STEPS WALKED GRAPH VIEW
                ZStack {
                    Rectangle()
                        .fill(.white)
                        .customCardView(width: UIScreen.main.bounds.width * 0.9,
                                        height: UIScreen.main.bounds.height * 0.35)
                    
                    if displayType == "chart" {
                        // TODO: Implement steps graph
                        StepsChartView()
                            .frame(height: 290)
                    } else if displayType == "list" {
                        StepsListView()
                            .padding(4)
                            .frame(height: 290)
                            .scrollContentBackground(.hidden)
                            .listStyle(PlainListStyle())
                    }
                }
                .padding()
                
                Spacer()
            }
            .background(Color(hex: 0xFBF7F4))
            .task {
                do {
                    // TODO: change parameter to days only
                    try await healthViewModel.fetchStepsForLastNDays(numberOfDays: 1, interval: DateComponents(day: 1))
                    try await healthViewModel.fetchCalories(from: .startOfDay, to: .endOfDay, interval: DateComponents(day: 1))
                    try await healthViewModel.fetchDistance(from: .startOfDay, to: .endOfDay, interval: DateComponents(day: 1))
                    try await healthViewModel.fetchActiveTime(from: .startOfDay, to: .endOfDay, interval: DateComponents(day: 1))
                } catch {
                    print("DEBUG: Failed to fetch today's health data with error \(error.localizedDescription)")
                }
            }
        }
    }
}

#Preview {
    HomeView()
        .environmentObject(HealthViewModel())
}
