//
//  PacePalTabView.swift
//  PacePal
//
//  Created by Cathleen Vu on 1/22/25.
//

import SwiftUI

struct PacePalTabView: View {
    @EnvironmentObject var healthViewModel: HealthViewModel
    @State var selectedTab = "Home"
    
    var body: some View {
        TabView(selection: $selectedTab) {
            ServerView()
                .tag("Server")
                .tabItem {
                    Image(systemName: "figure.2")
                }
            
            HomeView()
                .tag("Home")
                .tabItem { // Create a tabitem to add a tab icon
                    Image(systemName: "house")
                }
            
//            ReportView()
//                .tag("Report")
//                .tabItem {
//                    Image(systemName: "chart.bar.fill")
//                }
//
            ProfileView()
                .tag("Profile")
                .tabItem {
                    Image(systemName: "person")
                }
        }
    }
}

#Preview {
    PacePalTabView()
        .environmentObject(AuthViewModel())
}
