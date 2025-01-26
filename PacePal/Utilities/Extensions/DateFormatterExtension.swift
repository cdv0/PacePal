//
//  DateFormatterExtension.swift
//  PacePal
//
//  Created by Cathleen Vu on 1/26/25.
//

import Foundation

extension DateFormatter {
    static var monthYearFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d"
        formatter.timeZone = TimeZone.current
        return formatter
    }
    
    static var monthDayYearFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, yyyy"
        formatter.timeZone = TimeZone.current
        return formatter
    }
}
