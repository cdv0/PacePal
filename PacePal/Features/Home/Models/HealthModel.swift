//
//  HealthModel.swift
//  PacePal
//
//  Created by Cathleen Vu on 1/22/25.
//

import Foundation

struct Steps: Identifiable {
    let id = UUID()
    let count: Int
    let date: Date
}

struct Calories: Identifiable {
    let id = UUID()
    let count: Int
    let date: Date
}

struct Distance: Identifiable {
    let id = UUID()
    let count: Double
    let date: Date
}

struct ActiveTime: Identifiable {
    let id = UUID()
    let seconds: Int
    let date: Date
    
    var formatted: String {
        let hours = seconds / 3600
        let minutes = (seconds % 3600) / 60
        return String(format: "%02d:%02d", hours, minutes)
    }
}
