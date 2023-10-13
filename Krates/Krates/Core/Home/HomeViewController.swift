//
//  HomeViewController.swift
//  Krates
//
//  Created by Eli Lopez on 10/9/23.
//

import SwiftUI

struct HomeViewController: View {
    @State private var selectedIndex = 0
    @State private var menuShowing = true
    var body: some View {
        VStack(spacing: 0){
            //binding uodates in menu picker
            ZStack { //header
                
                LinearGradient(gradient: Gradient(colors: [Color.black.opacity(0.4), Color.background]), startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea(.all, edges: .top)
                
                HStack(alignment: .center) {
                    if menuShowing {
                        MenuPicker(selectedHomeIndex: $selectedIndex)
                            .padding(.horizontal, 12)
                            .shadow(radius: 4, x: 0, y: 4)
                    }
                    
                    Spacer()
                }
                .padding(.bottom, 10)
                
            }
            .frame(height: 50)
            .background(Color.background)
            
            //menu logic
            if selectedIndex == 0 {
                HomeAlbumsView(menuShowing: $menuShowing)
            } 
            if selectedIndex == 1 {
                HomeKratesView(menuShowing: $menuShowing)
            } 
            if selectedIndex == 2 {
                HomeReviewsView()
            }
        }

    }
}

#Preview {
    HomeViewController()
}
