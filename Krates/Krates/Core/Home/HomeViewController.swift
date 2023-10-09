//
//  HomeViewController.swift
//  Krates
//
//  Created by Eli Lopez on 10/9/23.
//

import SwiftUI

struct HomeViewController: View {
    @State private var selectedIndex = 0
    var body: some View {
        VStack(spacing: 0){
            //binding uodates in menu picker
            ZStack {
                
                LinearGradient(gradient: Gradient(colors: [Color.black.opacity(1), Color.background]), startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea(.all, edges: .top)
                    .frame(height: 80)
                    
                
                HStack(alignment: .center) {
                    
                    MenuPicker(selectedHomeIndex: $selectedIndex)
                        .padding(.horizontal, 12)
                    Spacer()
                        
                }
                
                
            }
            .frame(height: 50)
            .padding(.vertical, 0)
            
            if selectedIndex == 0 {
                HomeAlbumsView()
            } 
            if selectedIndex == 1 {
                HomeKratesView()
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
