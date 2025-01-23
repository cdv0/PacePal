//
//  DateExtension.swift
//  PacePal
//
//  Created by Cathleen Vu on 1/22/25.
//

import Foundation

extension Date {
    static var startOfDay: Date { // Access the type itself rather than making a Date() instance. We do this because the property is not specific to any single Date instance
        Calendar.current.startOfDay(for: Date()) // Returns 00:00:00 of that day
    }
    
    static var endOfDay: Date {
        // ! operator is specifically used to unwrap optionals and extract their underlying value
        let startOfNextDay = Calendar.current.date(byAdding: .day, value: 1, to: Calendar.current.startOfDay(for: Date()))! // Gives 00:00:00 of the next day from adding 1
        return Calendar.current.date(byAdding: .second, value: -1, to: startOfNextDay)! // Gives 23:59:59
    }
}
