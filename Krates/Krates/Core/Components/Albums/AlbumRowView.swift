//
//  AlbumRowView.swift
//  Krates
//
//  Created by Eli Lopez on 11/2/23.
//

import SwiftUI
import Kingfisher

struct AlbumRowView: View {
    var album: Album
    var body: some View {
        VStack (alignment: .leading) { // parent container
            HStack { // album info
                KFImage(URL(string: album.images[0].url))
                    .resizable()
                    .frame(width: 85, height: 85)
//                Image("dummy")
//                    .resizable()
//                    .frame(width: 65, height: 65)
                
                VStack (alignment: .leading)  {
//                    Text(album.name)
//                        .font(.title3)
//                        .fontWeight(.heavy)
//                    
//                    Text(album.artists[0].name)
//                        .font(.callout)
                    
                    Text("\(album.name)")
                        .font(.title3)
                        .fontWeight(.heavy)
                        .foregroundColor(Color.white)
                    
                    Text("\(album.artists[0].name)")
                        .font(.callout)
                        .foregroundColor(Color.accentLightGray)
                }
                
                Spacer()
            }.padding(.top, 4)
            
            Divider()
                .foregroundColor(Color.accentLightGray)
        }
        .frame(height: 70)
        .padding()
        .background(Color.background)
    }
}

//#Preview {
//    AlbumRowView()
//}
