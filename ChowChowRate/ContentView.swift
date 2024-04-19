//
//  ContentView.swift
//  ChowChowRate
//
//  Created by Andres Made on 4/15/24.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        Group {
            if viewModel.userSession != nil {
                ProfileScreen()
            } else {
                LoginScreen()
            }
        }
    }
}

#Preview {
    ContentView()
}
