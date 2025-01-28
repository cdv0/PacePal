//
//  StepsListView.swift
//  PacePal
//
//  Created by Cathleen Vu on 1/23/25.
//

import Foundation
import SwiftUI

struct StepsListView: View {
    @EnvironmentObject var healthViewModel: HealthViewModel
        
    var body: some View {
        List(healthViewModel.steps) { step in
            HStack {
                Text(DateFormatter.monthDayYearFormatter.string(from: step.date))
                
                Spacer()
                
                Text("\(step.count)")
            }
        }
        .task {
            do {
                try await healthViewModel.fetchStepsForLastNDays(numberOfDays: 7, interval: DateComponents(day: 1))
            } catch {
                print("DEBUG: Failed to fetch steps with error \(error.localizedDescription)")
            }

        }
    }
}

#Preview {
    StepsListView()
        .environmentObject(HealthViewModel())
}
