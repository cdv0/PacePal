//
//  ColorExtension.swift
//  PacePal
//
//  Created by Cathleen Vu on 1/17/25.
//
//  Hex color extension inspired by Jakir Mollah
//  Source: https://medium.com/@jakir/use-hex-color-in-swiftui-c19e6ab79220
//

import SwiftUI

extension Color {
    init(hex: Int, opacity: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 08) & 0xff) / 255,
            blue: Double((hex >> 00) & 0xff) / 255,
            opacity: opacity
        )
    }
}
