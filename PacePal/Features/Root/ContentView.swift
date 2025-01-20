//
//  ContentView.swift
//  PacePal
//
//  Created by Cathleen Vu on 1/12/25.
//

import SwiftUI

struct ContentView: View {
    @Environment(AuthViewModel.self) private var authViewModel

    var body: some View {
        Group {
            if authViewModel.userSession != nil {
                ProfileView()
            } else {
                LoginView()
            }
        }
    }
}

#Preview {
    ContentView()
        .environment(AuthViewModel())
}
