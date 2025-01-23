//
//  DateExtension.swift
//  PacePal
//
//  Created by Cathleen Vu on 1/22/25.
//

import Foundation

extension Date {
    static var startOfDay: Date { // Access the type itself rather than making a Date() instance. We do this because the property is not specific to any single Date instance
        Calendar.current.startOfDay(for: Date())
    }
}
