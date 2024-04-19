//
//  ResetPasswordScreen.swift
//  ChowChowRate
//
//  Created by Andres Made on 4/16/24.
//

import SwiftUI

struct ResetPasswordScreen: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @State private var email: String = ""
    
    var body: some View {
        VStack {
            Text("Reset Password")
            TextField("Email", text: $email)
            
            Button(action: {
                Task {
                    try await viewModel.resetPassword(email: email)
                }
            }, label: {
                HStack(spacing: 2) {
                    Text("SIGN IN")
                    Image(systemName: "arrow.right")
                }
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 50)
                .disabled(formIsValid)
                .opacity(formIsValid ? 1.0 : 0.5)
                .background(Color(.systemCyan))
                .clipShape(RoundedRectangle(cornerRadius: 10))
            })
        }
    }
}

#Preview {
    ResetPasswordScreen()
}

extension ResetPasswordScreen: AuthenticationFormProtocal {
    var formIsValid: Bool {
        return !email.isEmpty
        && email.contains("@")
    }
}
