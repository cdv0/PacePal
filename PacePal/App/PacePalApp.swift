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
    @State private var authViewModel = AuthViewModel()
    
    init() {
        FirebaseApp.configure()
    }
        
    var body: some Scene {
        WindowGroup {
            ContentView()
            .environment(authViewModel)
        }
    }
}
