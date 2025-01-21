//
//  ForgotPasswordView.swift
//  PacePal
//
//  Created by Cathleen Vu on 1/17/25.
//

import SwiftUI

struct ForgotPasswordView: View {
    @State var email = ""
    @FocusState private var isFocused: Bool
    @EnvironmentObject private var authViewModel: AuthViewModel

    var body: some View {
        VStack {
            
            Spacer()
            
            // LOGO
            
            Image("PacePalLogo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 350, height: 100)
            
            // EMAIL ADDRESS TEXT FIELD
            
            VStack(spacing: 15) {
                VStack (alignment: .leading) {
                    Text("Email Address")
                        .opacity(0.4)
                    TextField("", text: $email)
                        .focused($isFocused)
                }
                .customTextFieldShape(color: .gray.opacity(0.11))
            }
            .padding(.horizontal, 30)
            .padding(.bottom, 25)
            .textInputAutocapitalization(.never)
            .autocorrectionDisabled(true)
            
            // SEND RESET LINK BUTTON
            
            Button {
                isFocused = false
                Task {
                    try await authViewModel.sendPasswordReset(withEmail: email)
                }
            } label: {
                Text("SEND RESET LINK")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)  // Button fills the cutom shape
                    .bold()
                    .foregroundStyle(.white)
            }
            .customTextFieldShape(color: Color(hex: 0x53A57D))
            .disabled(!formIsValid)
            .opacity(formIsValid ? 1.0 : 0.5)
            
            Spacer()
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(hex: 0xFBF7F4))
        .ignoresSafeArea()
    }
}

#Preview {
    ForgotPasswordView()
}
