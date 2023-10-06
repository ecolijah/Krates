//
//  TabControllerView.swift
//  Krates
//
//  Created by Eli Lopez on 10/4/23.
//

import SwiftUI

struct TabControllerView: View {
    @State private var selectedIndex = 0
    var body: some View {
        
        TabView {
            
            HomeAlbumsView()
                .onTapGesture {
                    self.selectedIndex = 0
                }
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
                .toolbarBackground(Color.accentDarkGray, for: .tabBar)

            
            SearchView()
                .onTapGesture {
                    self.selectedIndex = 0
                }
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                }

            
            SocialView()
                .onTapGesture {
                    self.selectedIndex = 2
                }
                .tabItem {
                    Image(systemName: "heart")
                    Text("Social")
                }

            
            ProfileView()
                .onTapGesture {
                    self.selectedIndex = 3
                }
                .tabItem {
                    Image(systemName: "house")
                    Text("Profile ")
                }
                

        }

    
    }

        
}

#Preview {
    TabControllerView()
}
