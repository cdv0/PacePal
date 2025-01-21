//
//  LoginView.swift
//  PacePal
//
//  Created by Cathleen Vu on 1/17/25.
//

import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    
    @State private var isSecured = false
    @EnvironmentObject private var authViewModel: AuthViewModel

    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                Spacer()
                Spacer()
                
                Image("PacePalLogo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 350, height: 100)
                
                Text("Welcome to PacePal!")
                    .font(.title2.bold())
                    .padding(.bottom, 3)
                
                Text("Track your steps")
                    .font(.system(size: 14))
                    .opacity(0.5)
                
                Spacer()
                
                VStack(spacing: 15) {
                    VStack (alignment: .leading) {
                        Text("Email")
                            .opacity(0.4)
                        TextField("", text: $email)
                    }
                    .customTextFieldShape(color: .gray.opacity(0.11))
                    
                    HStack {
                        VStack (alignment: .leading) {
                            Text("Password")
                                .opacity(0.4)
                            
                            if isSecured {
                                SecureField("", text: $password)
                            } else {
                                TextField("", text: $password)
                            }
                        }
                        
                        Button(action: {
                            isSecured.toggle()
                        }) {
                            Image(systemName: isSecured ? "eye.slash" : "eye")
                                .accentColor(.gray)
                        }
                    }
                    .customTextFieldShape(color: .gray.opacity(0.11))
                }
                .padding(.horizontal, 30)
                .padding(.bottom, 25)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled(true)
                
                // TODO: Implement login in AuthViewModel and set up button functionality here
                Button {
                    Task {
                        try await authViewModel.logIn(withEmail: email, password: password)
                    }
                } label: {
                    Text("LOGIN")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)  // Button fills the cutom shape
                        .bold()
                        .foregroundStyle(.white)
                }
                .customTextFieldShape(color: Color(hex: 0x53A57D))
                .disabled(!formIsValid)
                .opacity(formIsValid ? 1.0 : 0.5)
                
                NavigationLink(destination: ForgotPasswordView()) {
                    Text("Forgot password?")
                }
                .padding(10)
                .foregroundStyle(Color(hex: 0x53A57D))
                .font(.system(size: 15))
                .bold()
                
                Spacer()
                Spacer()
                
                NavigationLink {
                    SignupView()
                        .navigationBarBackButtonHidden()
                } label: {
                    HStack (spacing: 3) {
                        Text("Don't have an account?")
                            .foregroundStyle(.black.opacity(0.7))
                        Text("Sign up")
                            .fontWeight(.bold)
                            .foregroundStyle(Color(hex: 0x53A57D))
                    }
                }
                .font(.system(size: 15))
                .fontWeight(.medium)
                
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(hex: 0xFBF7F4))
            .ignoresSafeArea()
        }
    }
}

#Preview {
    LoginView()
        .environmentObject(AuthViewModel())
}
