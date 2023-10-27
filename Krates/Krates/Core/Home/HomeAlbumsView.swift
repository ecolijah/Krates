//
//  HomeView.swift
//  Krates
//
//  Created by Eli Lopez on 10/4/23.
//

import SwiftUI

struct HomeAlbumsView: View {
    @Binding var menuShowing: Bool
    @State private var newReleaseAlbums: [Album] = []

    var categories = ["New releases","Popular this week"]
    
    var body: some View {
        
        NavigationView {
            VStack {
               
                ScrollView(.vertical, showsIndicators: false) {
                    
                    VStack(alignment: .leading) {
    //                    MenuPicker()
    //                        .padding(.horizontal, 12)
         
                        VStack(spacing: 16) {
                            ForEach(categories.indices, id: \.self) { index in  // Use indices to get the index
                                HorizontalScrollView(menuShowing: $menuShowing, category: categories[index], albums: index == 0 ? newReleaseAlbums : [])
                                    .padding(.horizontal, -16)
                            }
                        }
                        .padding()
                    }
                }
                .background(Color.background)
            }.background(Color.background)
        }
        .onAppear {
            SpotifyAPIManager().fetchNewReleases { albums, error in
                if let albums = albums {
                    self.newReleaseAlbums = albums
                } else {
                    // Handle the error, maybe show an error message to the user
                    print("Error fetching new releases:", error?.localizedDescription ?? "Unknown error")
                }
            }
        }

        
        
    }
}

struct HorizontalScrollView: View {
    @Binding var menuShowing: Bool
    var category: String
    var albums: [Album] = []  // New property to accept albums

    
    var body: some View {
        VStack(alignment: .leading) {
            
            Text(category)
                .padding(.horizontal, 16)
                .font(.title2)
                .padding(.top, 0)
                .padding(.bottom, -4)
                .foregroundColor(Color.whiteFont)
                .fontWeight(.heavy)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(albums) { album in  // Horizontal items
                        ScrollViewCell(menuShowing: $menuShowing, album: album)
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
    var album: Album

    
    var body: some View {
        
        NavigationLink(
            destination: AlbumObjectView()
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
                Text("\(album.name) - \(album.primaryArtistName ?? "Unknown Artist")")
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
