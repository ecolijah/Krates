//
//  TabControllerView.swift
//  Krates
//
//  Created by Eli Lopez on 10/4/23.
//

import SwiftUI

struct TabControllerView: View {
    @State private var selectedIndex = 0
    let tabBarImageNames = ["icons8-home-48", "icons8-search-48", "icons8-heart-48", "icons8-profile-48"]
    let selectedTabBarImageNames = ["icons8-home-48-orange", "icons8-search-48-orange", "icons8-heart-48-orange", "icons8-profile-48-orange"]
    let tabBarText = ["Home", "Search", "Social", "Profile"]
    
    var body: some View {
        
        VStack(spacing: 0) {

            ZStack {
                
                HomeViewController().opacity(selectedIndex == 0 ? 1 : 0)
                SearchView().opacity(selectedIndex == 1 ? 1 : 0)
                SocialView().opacity(selectedIndex == 2 ? 1 : 0)
                ProfileView().opacity(selectedIndex == 3 ? 1 : 0)
            }
            
            // Custom Tab Bar
            ZStack() {
//                LinearGradient(gradient: Gradient(colors: [Color.accentDarkGray.opacity(1), Color.black.opacity(1)]), startPoint: .top, endPoint: .bottom)
//                    .ignoresSafeArea(.all, edges: .bottom)
                
                HStack() {
                    
                    ForEach(0..<4) { index in
                        Button(action: {
                            selectedIndex = index
                        }) {
                            CustomTabButton(imageName: tabBarImageNames[index],
                                            selectedImageName: selectedTabBarImageNames[index],
                                            text: tabBarText[index],
                                            isSelected: selectedIndex == index)
                        }
                        .frame(maxWidth: .infinity)
                    }
                }.background(Color.accentDarkGray)
                
            }
            .frame(height: 30)
            
            
        }
    }
}


struct CustomTabButton: View {
    var imageName: String
    var selectedImageName: String
    var text: String
    var isSelected: Bool
    
    var body: some View {
        VStack {
            Image(isSelected ? selectedImageName : imageName)
                .resizable()
                .frame(width: 30, height: 30)
                .foregroundColor(isSelected ? Color.orange : Color.gray)
            Text(text)
                .font(.caption2)
                .foregroundColor(isSelected ? Color.brightOrange : Color.accentLightGray)
                .bold()
        }
        .padding(.vertical, 8)
    }
}



#Preview {
    TabControllerView()
}
