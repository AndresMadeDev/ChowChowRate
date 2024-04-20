//
//  HomeTabView.swift
//  ChowChowRate
//
//  Created by Andres Made on 4/19/24.
//

import SwiftUI

struct HomeTabView: View {
    var body: some View {
        TabView {
            HomeListScreen()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            FavoriteScreen()
                .tabItem {
                    Label("Favorite", systemImage: "star")
                }
            ProfileScreen()
                .tabItem {
                    Label("Profile", systemImage: "person")
                }
        }
    }
}

#Preview {
    HomeTabView()
}
