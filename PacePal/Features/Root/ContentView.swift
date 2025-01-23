//
//  ContentView.swift
//  PacePal
//
//  Created by Cathleen Vu on 1/12/25.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var authViewModel: AuthViewModel

    var body: some View {
        Group {
            if authViewModel.userSession != nil {
                PacePalTabView()
            } else {
                LoginView()
            }
        }
        .preferredColorScheme(.light)
    }
}

#Preview {
    ContentView()
        .environmentObject(AuthViewModel())
}
