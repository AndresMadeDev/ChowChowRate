//
//  LoginView.swift
//  GrubRate
//
//  Created by Andres Made on 4/14/24.
//

import SwiftUI

struct LoginScreen: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var resetPassword: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Grub Rate")
                    .font(.system(size: 40, weight: .bold, design: .rounded))
                    .padding(25)
                    .background(.cyan)
                    .foregroundStyle(.white)
                    .clipShape(.capsule)
                    .padding(.top, 50)
                
                VStack(spacing: 24) {
                    InputView(text: $email, 
                              title: "Email Address",
                              placeholder: "example@emaple.com")
                        .textInputAutocapitalization(.never)
                    
                   InputView(text: $password, 
                             title: "Password",
                             placeholder: "Enter your passsword",
                             isSecure: true)
                    HStack {
                        Spacer()
                        Button("Forgot Password") {
                            resetPassword.toggle()
                        }
                        .font(.footnote)
                        .tint(.cyan)
                    }
                }
                .padding(.vertical, 75)
                
                
                
                Button(action: {
                    Task {
                       try await viewModel.signIn(email: email, password: password)
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
                
            
                Spacer()
                
                NavigationLink {
                    RegistrationScreen()
                } label: {
                    HStack {
                        Text("Don't have ana account")
                        Text("Sign Up")
                            .bold()
                    }
                    .font(.system(size: 14))
                    .foregroundStyle(.cyan)
                }
            }
            .padding()
            .navigationBarTitleDisplayMode(.inline)
            .alert(viewModel.errorMessage, isPresented: $viewModel.showError) {
                Button("OK", role: .cancel) {}
            }
            .sheet(isPresented: $resetPassword) {
                ResetPasswordScreen()
            }
        }
    }
}

#Preview {
    LoginScreen()
}

extension LoginScreen: AuthenticationFormProtocal {
    var formIsValid: Bool {
        return !email.isEmpty
        && email.contains("@")
        && !password.isEmpty
        && password.count > 5
    } 
}
