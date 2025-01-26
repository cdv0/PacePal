//
//  PacePalApp.swift
//  PacePal
//
//  Created by Cathleen Vu on 1/12/25.
//

import SwiftUI
import Firebase

@main
struct PacePalApp: App {
    @StateObject private var authViewModel = AuthViewModel()
    @StateObject private var healthViewModel = HealthViewModel()
    
    init() {
        FirebaseApp.configure()
    }
        
    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(.light)
                .environmentObject(authViewModel)
                .environmentObject(healthViewModel)
        }
    }
}
