//
//  ResetPasswordScreen.swift
//  ChowChowRate
//
//  Created by Andres Made on 4/16/24.
//

import SwiftUI

struct ResetPasswordScreen: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: AuthViewModel
    @State private var email: String = ""
    @State private var showAlert: Bool = false
    
    var body: some View {
        VStack(spacing: 50) {
            Text("Reset Password")
                .font(.title)
                .bold()
            
            Text("Enter your email to receive an email to reset your password")
            
            InputView(text: $email,
                      title: "Email Address",
                      placeholder: "example@emaple.com")
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()
            
            
            Button(action: {
                Task {
                    try await viewModel.resetPassword(email: email)
                    viewModel.showSuccess.toggle()
                }
            }, label: {
                HStack(spacing: 2) {
                    Text("Reset Password")
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
            Spacer()
        }
        .padding()
        .alert(viewModel.successMessage, isPresented: $viewModel.showSuccess) {
            Button("OK", role: .cancel) { dismiss() }
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
