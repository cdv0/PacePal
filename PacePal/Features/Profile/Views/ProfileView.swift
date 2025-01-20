//
//  ProfileView.swift
//  PacePal
//
//  Created by Cathleen Vu on 1/19/25.
//

import SwiftUI

struct ProfileView: View {
    // TODO: Modify UI to complement app theme
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        if let user = authViewModel.currentUser {
            List {
                
                Section {
                    HStack {
                        Text(user.initials)
                            .font(.title)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .frame(width: 72, height: 72)
                            .background(Color(.systemGray3))
                            .clipShape(Circle())
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text(user.fullName)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .padding(.top, 4)
                            
                            Text(user.email)
                                .font(.footnote)
                                .foregroundStyle(.gray)
                        }
                    }
                    
                }
                
                Section("General") {
                    HStack {
                        SettingsRowView(imageName: "gear", title: "Version", tintColor: Color(.systemGray))
                        
                        Spacer()
                        
                        Text("1.0.0") // TODO: Don't hardcode
                            .font(.subheadline)
                            .foregroundStyle(.gray)
                    }
                }
                
                Section("Account") {
                    Button {
                        // TODO: Implement logic
                        print("Sign out")
                    } label: {
                        SettingsRowView(imageName: "arrow.left.circle.fill", title: "Sign Out", tintColor: Color.red)
                    }
                    
                    Button {
                        // TODO: Implement logic
                        print("Delete Account")
                    } label: {
                        SettingsRowView(imageName: "xmark.circle.fill", title: "Delete Account", tintColor: Color.red)
                    }
                    
                }
            }
        }
    }
}

#Preview {
    ProfileView()
        .environmentObject(AuthViewModel())
}
