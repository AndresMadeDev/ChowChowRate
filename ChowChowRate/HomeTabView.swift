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
            Text("Home")
            Text("Favorite")
        }
    }
}

#Preview {
    HomeTabView()
}
