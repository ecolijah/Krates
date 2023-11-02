//
//  GridAlbumView.swift
//  Krates
//
//  Created by Eli Lopez on 11/1/23.
//

import SwiftUI

struct GridAlbumView: View {
    var albums: [Album]
    
    // Define a grid layout with flexible columns
    let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12)
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 12) {
                ForEach(albums, id: \.id) { album in
                    if let imageURL = album.images.first?.url, let url = URL(string: imageURL) {
                        NavigationLink(destination: AlbumObjectView(album: album)
                            .navigationBarBackButtonHidden(true)
) {
                            AsyncImage(url: url) { phase in
                                switch phase {
                                case .success(let image):
                                    image.resizable().aspectRatio(contentMode: .fit)
                                default:
                                    Rectangle().foregroundColor(.gray) // Placeholder for loading or failure
                                }
                            }
                            .cornerRadius(3)
                        }
                    }
                }
            }
            .padding()
        }
    }
}

//#Preview {
//    GridAlbumView()
//}
