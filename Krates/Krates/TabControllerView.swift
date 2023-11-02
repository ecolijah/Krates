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
        ZStack(alignment: .bottom) { // Align the tab bar to the bottom
            // Content view that changes based on the selected index
            Group {
                switch selectedIndex {
                case 0:
                    HomeViewController()
                        .padding(.bottom, 50)
                case 1:
                    SearchView()
                case 2:
                    SocialView()
                case 3:
                    ProfileView()
                default:
                    HomeViewController()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity) // Make content view full screen
            
            // Custom Tab Bar as an overlay
            customTabBar()
        }
    }

    @ViewBuilder
    private func customTabBar() -> some View {
        HStack {
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
        }
        .background(Color.accentDarkGray) // Your custom color
        .frame(height: 50) // Adjust to your custom tab bar height
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
