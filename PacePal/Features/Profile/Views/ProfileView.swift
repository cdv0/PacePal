
//
//  ProfileView.swift
//  PacePal
//
//  Created by Cathleen Vu on 1/19/25.
//


import SwiftUI

struct ProfileView: View {
    @State private var password = ""
    @State private var showPasswordAlert = false
    @EnvironmentObject var authViewModel: AuthViewModel
    @State var editProfileButtonPressed = false
    
    var body: some View {
        if let user = authViewModel.currentUser {
            NavigationStack {
                ZStack {
                    Color(.white)
                        .ignoresSafeArea()
                    
                    List {
                        // MARK: Profile overview
                        Section{
                            VStack {
                                VStack(alignment: .center) {
                                    // TODO: Implement profile picture
                                    Text(user.initials)
                                        .font(.title)
                                        .fontWeight(.semibold)
                                        .foregroundColor(.white)
                                        .frame(width: 90, height: 90)
                                        .background(Color(.systemGray3))
                                        .clipShape(Circle())
                                        .overlay(
                                            Circle()
                                                .stroke(Color(hex: 0x53A57D),lineWidth: 2)
                                        )
                                    
                                    VStack(alignment: .center, spacing: 4) {
                                        Text(user.fullName)
                                            .font(.subheadline)
                                            .fontWeight(.semibold)
                                            .padding(.top, 4)
                                        
                                        Text(user.email)
                                            .font(.footnote)
                                            .foregroundStyle(.gray)
                                    }
                                    .padding(.bottom, 10)
                                    
                                    Button(action: {
                                        editProfileButtonPressed = true
                                    }, label: {
                                        Text("EDIT PROFILE")
                                            .font(.system(size: 14, weight: .bold))
                                            .foregroundStyle(.white)
                                            .frame(width: 170)
                                            .contentShape(Rectangle())
                                    })
                                    .frame(width: 170)
                                    .padding(.vertical, 10)
                                    .background(Color(hex: 0x53A57D))
                                    .clipShape(.capsule)
                                    .shadow(color: Color.black.opacity(0.2), radius: 3)
                                    .buttonStyle(BorderlessButtonStyle())
                                    .navigationDestination(isPresented: $editProfileButtonPressed) {
                                        EditProfileView()
                                    }
                                }
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 20)
                                .multilineTextAlignment(.center)
                                .onTapGesture { return }
                            }
                        }
                        
                        // MARK: Settings
                        Section("General") {
                            // TODO: Implement Settings
                            NavigationLink(destination: Text("Settings Details")) {
                                SettingsRowView(imageName: "gear", title: "Settings", tintColor: Color(hex: 0x53A57D))
                            }
                        }
                        
                        // MARK: Sign out, Delete account
                        Section("Account") {
                            Button {
                                authViewModel.signOut()
                            } label: {
                                SettingsRowView(imageName: "arrow.right.circle.fill", title: "Sign Out", tintColor: Color(hex: 0x53A57D))
                            }
                            
                            Button {
                                showPasswordAlert = true
                            } label: {
                                SettingsRowView(imageName: "xmark.circle.fill", title: "Delete Account", tintColor: Color.red)
                            }
                            .alert("Enter your password", isPresented: $showPasswordAlert) {
                                SecureField("Password", text: $password)
                                Button("Cancel", role: .cancel) {}
                                Button("Delete Account", role: .destructive) {
                                    Task {
                                        await authViewModel.deleteAccount(withEmail: user.email, password: password)
                                    }
                                }
                            } message: {
                                Text("Please confirm your password to delete your account.")
                            }
                        }
                    }
                }
                .scrollContentBackground(.hidden)
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Profile")
                        .font(.headline)
                        .fontWeight(.semibold)
                }
            }
        }
    }
}

#Preview {
    ProfileView()
        .environmentObject(AuthViewModel())
}
