//
//  StepsChartView.swift
//  PacePal
//
//  Created by Cathleen Vu on 1/23/25.
//

import SwiftUI
import Charts

struct StepsChartView: View {
    @EnvironmentObject var healthViewModel: HealthViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Steps")
                .bold()
            
            Text("Total: \(healthViewModel.steps.reduce(0) { $0 + $1.count })")
                .fontWeight(.semibold)
                .font(.footnote)
                .foregroundStyle(.secondary)
                .padding(.bottom, 12)
            
            Chart {
                ForEach(healthViewModel.steps.prefix(7).reversed()) { step in
                    BarMark(
                        x: .value("Date", DateFormatter.monthYearFormatter.string(from: step.date)),
                        y: .value("Total Steps", step.count)
                    )
                    .foregroundStyle(Color(hex: 0x53A57D))
                }
            }
            .frame(height: 220)
        }
        .padding(30)
        .task {
            do {
                try await healthViewModel.fetchStepsForLastNDays(numberOfDays: 7, interval: DateComponents(day: 1))
            } catch {
                print("DEBUG: Failed to fetch steps for last 30 days with error \(error.localizedDescription)")
            }
        }
    }
}

#Preview {
    StepsChartView()
}
