//
//  ProfileScreen.swift
//  GrubRate
//
//  Created by Andres Made on 4/14/24.
//

import SwiftUI

struct ProfileScreen: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @State private var showDeleteAccountAlert: Bool = false
    @State private var showSignOutAlert: Bool = false
    
    var body: some View {
        if let user = viewModel.currentUser {
            List {
                Section {
                    HStack(spacing: 10) {
                        Text(user.username.prefix(1))
                            .padding()
                            .font(.system(.largeTitle, design: .rounded, weight: .bold))
                            .background(.accent.opacity(0.7))
                            .foregroundStyle(.white)
                            .clipShape(.circle)
                        
                        
                        VStack(alignment: .leading) {
                            Text(user.username)
                            
                            Text(user.email)
                                .tint(.secondary)
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
                    }
                }
                
                Section("General") {
                    LabeledContent {
                        Text("1.0")
                    } label: {
                        Label(
                            title: { Text("Version") },
                            icon: { Image(systemName: "gear").foregroundStyle(.gray) }
                        )
                    }
                    
                }
                
                Section("Account") {
                    Button(action: {
                        showSignOutAlert.toggle()
                    }, label: {
                        Label(
                            title: { Text("Sign Out") },
                            icon: { Image(systemName: "arrow.left.circle.fill").foregroundStyle(.red) }
                        )
                    })
                    
                    Button(action: {
                        showDeleteAccountAlert.toggle()
                    }, label: {
                        Label(
                            title: { Text("Delete Account") },
                            icon: { Image(systemName: "xmark.circle.fill").foregroundStyle(.red) }
                        )
                    })
                    .alert(isPresented:$showDeleteAccountAlert) {
                                Alert(
                                    title: Text("Are you sure you want to delete this account?"),
                                    message: Text("There is no undo and you will loose all your data"),
                                    primaryButton: .destructive(Text("Delete")) {
                                        viewModel.deleteAccount()
                                    },
                                    secondaryButton: .cancel()
                                )
                            }
                    
                }
                .buttonStyle(.plain)
            }
            .alert(isPresented:$showSignOutAlert) {
                        Alert(
                            title: Text("Are you sure you want to sign out of your account?"),
                            primaryButton: .destructive(Text("Sign Out")) {
                                viewModel.signOut()
                            },
                            secondaryButton: .cancel()
                        )
                    }
        }
    }
}

#Preview {
    ProfileScreen()
}
