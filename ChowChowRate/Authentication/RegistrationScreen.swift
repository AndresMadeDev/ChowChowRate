//
//  RegistrationScreen.swift
//  GrubRate
//
//  Created by Andres Made on 4/14/24.
//

import SwiftUI

struct RegistrationScreen: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @Environment(\.dismiss) private var dismiss
    @State private var email: String = ""
    @State private var userName: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    
    
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
                        .autocorrectionDisabled()
                    
                    InputView(text: $userName, 
                              title: "User Name",
                              placeholder: "username")
                        .textInputAutocapitalization(.sentences)
                        .autocorrectionDisabled()
                    
                    InputView(text: $password, 
                              title: "Password",
                              placeholder: "Enter your passsword", 
                              isSecure: true)
                    
                    ZStack(alignment: .trailing, content: {
                        InputView(text: $confirmPassword,
                                  title: "Confirm Password",
                                  placeholder: "Confirm your passsword",
                                  isSecure: true)
                        
                        if !password.isEmpty && !confirmPassword.isEmpty {
                            if password == confirmPassword {
                                Image(systemName: "checkmark.circle.fill")
                                    .imageScale(.large)
                                    .bold()
                                    .foregroundStyle(Color(.systemGreen))
                            } else {
                                Image(systemName: "xmark.circle.fill")
                                    .imageScale(.large)
                                    .bold()
                                    .foregroundStyle(Color(.systemRed))
                            }
                        }
                    })
                    
                }
                .padding(.vertical, 50)
                
                Button(action: {
                    Task {
                       try await viewModel.creatUser(email: email, userName: userName, password: password)
                    }
                }, label: {
                    HStack(spacing: 2) {
                        Text("SIGN UP")
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
                
                Button {
                    dismiss()
                } label: {
                    HStack(spacing: 2) {
                        Text("Already have an account.")
                        Text("Sign In")
                            .bold()
                    }
                    .font(.system(size: 14))
                    .foregroundStyle(.cyan)
                }

                
            }
            .padding()
            .navigationBarBackButtonHidden()
        }
    }
}

#Preview {
    RegistrationScreen()
}

extension RegistrationScreen: AuthenticationFormProtocal {
    var formIsValid: Bool {
        return !email.isEmpty
        && email.contains("@")
        && !password.isEmpty
        && password.count > 5
        && confirmPassword == password
        && !userName.isEmpty
    }
}
