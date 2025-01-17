//
//  LoginView.swift
//  PacePal
//
//  Created by Cathleen Vu on 1/17/25.
//

import SwiftUI

struct LoginView: View {
    @State private var viewModel = LoginViewModel()
    
    var body: some View {
        VStack {
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
                    TextField("", text: $viewModel.user.email)
                }
                .customTextFieldShape(color: .gray.opacity(0.11))
                
                HStack {
                    VStack (alignment: .leading) {
                        Text("Password")
                            .opacity(0.4)
                        
                        if viewModel.isSecured {
                            SecureField("", text: $viewModel.user.password)
                        } else {
                            TextField("", text: $viewModel.user.password)
                        }
                    }
                    
                    Button(action: {
                        viewModel.isSecured.toggle()
                    }) {
                        Image(systemName: viewModel.isSecured ? "eye.slash" : "eye")
                            .accentColor(.gray)
                    }
                }
                .customTextFieldShape(color: .gray.opacity(0.11))
            }
            .padding(.horizontal, 30)
            .padding(.bottom, 25)
            .textInputAutocapitalization(.never)
            .autocorrectionDisabled(true)
            
            Text("LOGIN")
                .customTextFieldShape(color: Color(hex: 0x53A57D))
                .bold()
                .foregroundStyle(.white)
            
            NavigationLink(destination: ForgotPasswordView()) {
                Text("Forgot password?")
            }
            .padding(10)
            .foregroundStyle(Color(hex: 0x53A57D))
            .font(.system(size: 15))
            .bold()
            
            Spacer()
            Spacer()
            
            Group {
                Text("Don't have an account? ")
                + Text("Register!")
            }
            .font(.system(size: 15))
            .fontWeight(.medium)
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(hex: 0xFBF7F4))
        .ignoresSafeArea()
        .preferredColorScheme(.light)
    }
}

#Preview {
    LoginView()
}
