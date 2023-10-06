//
//  HomeView.swift
//  Krates
//
//  Created by Eli Lopez on 10/4/23.
//

import SwiftUI

struct HomeAlbumsView: View {
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            
            VStack(alignment: .leading) {
                HStack {
                    
                    MenuPicker()
                        .padding(.horizontal, 12)
                    Spacer()
//                    Image(systemName: "figure.walk.circle.fill")
//                        .resizable()
//                        .foregroundColor(Color.brightOrange)
//                        .padding(16)
//                        .frame(width: 70, height: 70)
                    
                }
 
                VStack(spacing: 16) {
                    ForEach(0..<6) { _ in  // Vertical rows
                        HorizontalScrollView()
                            .padding(.horizontal, -16)
                    }
                }
                .padding()
            }

        }
        .background(Color.background)
    }
}

struct HorizontalScrollView: View {
    var body: some View {
        VStack(alignment: .leading) {
            
            Text("Album Category")
                .padding(.horizontal, 16)
                .font(.title)
                .padding(.top, 0)
                .padding(.bottom, -4)
                .foregroundColor(Color.whiteFont)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(0..<6) { _ in  // Horizontal items
                        ScrollViewCell()
                    }
                    SeeMoreCell()
                }
                .padding(.horizontal)
            }
            
        }
    }
}

struct ScrollViewCell: View {
    var body: some View {
        
        Button(action: {
            
        }) {
            VStack(alignment: .leading) {
                Image("dummy")
                    .frame(width: 143, height: 143)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(2)
                    .padding(1)
                Text("Album - Artist")
                    .font(.caption)
                    .bold()
                    .foregroundColor(.whiteFont)
            }
        }
        .background(Color.background)
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
    HomeAlbumsView()
    
}
