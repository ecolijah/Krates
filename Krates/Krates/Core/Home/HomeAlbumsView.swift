//
//  HomeView.swift
//  Krates
//
//  Created by Eli Lopez on 10/4/23.
//

import SwiftUI

struct HomeAlbumsView: View {
    @Binding var menuShowing: Bool
    var body: some View {
        
        NavigationView {
            VStack {
               
                ScrollView(.vertical, showsIndicators: false) {
                    
                    VStack(alignment: .leading) {
    //                    MenuPicker()
    //                        .padding(.horizontal, 12)
         
                        VStack(spacing: 16) {
                            ForEach(0..<6) { _ in  // Vertical rows
                                HorizontalScrollView(menuShowing: $menuShowing)
                                    .padding(.horizontal, -16)
                            }
                        }
                        .padding()
                    }
                }
                .background(Color.background)
            }.background(Color.background)
        }
        
        
    }
}

struct HorizontalScrollView: View {
    @Binding var menuShowing: Bool

    var body: some View {
        VStack(alignment: .leading) {
            
            Text("Album Category")
                .padding(.horizontal, 16)
                .font(.title2)
                .padding(.top, 0)
                .padding(.bottom, -4)
                .foregroundColor(Color.whiteFont)
                .fontWeight(.heavy)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(0..<6) { _ in  // Horizontal items
                        ScrollViewCell(menuShowing: $menuShowing)
                    }
                    SeeMoreCell()
                }
                .padding(.horizontal)
            }
            
        }
    }
}

struct ScrollViewCell: View {
    @Binding var menuShowing: Bool

    
    var body: some View {
        
//        Button(action: {
//            
//        }) {
//            VStack(alignment: .leading) {
//                Image("dummy")
//                    .frame(width: 143, height: 143)
//                    .background(Color.blue)
//                    .foregroundColor(.white)
//                    .cornerRadius(5)
//                    .padding(1)
//                Text("Album - Artist")
//                    .font(.caption)
//                    .bold()
//                    .foregroundColor(.whiteFont)
//            }
//        }
//        .background(Color.background)
        
        
        NavigationLink(
            destination: KrateObjectView()
                .navigationBarBackButtonHidden(false)
                .onAppear { // This will toggle menuShowing when KrateObjectView appears
                    menuShowing.toggle()
                }
                .onDisappear(){
                    menuShowing.toggle()
                }
        ) {
            VStack(alignment: .leading) {
                Image("dummy")
                    .frame(width: 143, height: 143)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(5)
                    .padding(1)
                Text("Album - Artist")
                    .font(.caption)
                    .bold()
                    .foregroundColor(.whiteFont)
            }
        }
    }
}

struct SeeMoreCell:  View {
    var body: some View {
        
        Button(action: {
            //something
        }) {
            Text("See More")
                .foregroundColor(Color.whiteFont)
                .bold()
        }
        .frame(width: 143, height: 166)
        .background(Color.accentLightGray)
        
    }
}

#Preview {
    HomeAlbumsView(menuShowing: .constant(false))
    
}
