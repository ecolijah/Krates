//
//  ArtistObjectView.swift
//  Krates
//
//  Created by Eli Lopez on 10/30/23.
//

import SwiftUI

struct ArtistObjectView: View {
    var artist: ArtistObject?
    var spotifyAPIManager = SpotifyAPIManager()

    @Environment(\.presentationMode) var presentationMode

    private var backButton: some View {
        Button(action: {
            presentationMode.wrappedValue.dismiss()
            print("back button pressed.")
        }) {
            ZStack {
                Circle().foregroundColor(.background.opacity(0.5))
                    .frame(width: 35)
                Image(systemName: "arrowshape.backward.fill").foregroundColor(.accentLightGray)
            }
        }
    }

    private var menuButton: some View {
        Button(action: {}) {
            ZStack {
                Circle()
                    .foregroundColor(.background.opacity(0.5))
                    .frame(width: 35)

                Image(systemName: "ellipsis")
                    .resizable()
                    .foregroundColor(.accentLightGray)
                    .frame(width: 30, height: 6)
            }
        }
    }
    var body: some View {
        VStack {
            ZStack(alignment: .top) {
//                Rectangle()
//                    .frame(height: 280)
//                    .foregroundColor(.blue)
//                    .cornerRadius(5)
                let imageURL = artist?.images[0].url
                let url = URL(string: imageURL!)
                //artist image
                AsyncImage(url: url)
                    .frame(height: 280)
                    .cornerRadius(5)
                    .aspectRatio(contentMode: .fit)
                LinearGradient(
                    gradient: Gradient(stops: [
                        .init(color: Color.background.opacity(1), location: 0.05),
                        .init(color: Color.background.opacity(0.0001), location: 0.4)
                    ]),
                    startPoint: .bottom,
                    endPoint: .top
                )
                .frame(height: 280)
                
                VStack (alignment: .leading) {
                    HStack {
                        backButton.padding([.top, .leading], 8)
                        Spacer()
                        menuButton.padding([.top, .trailing], 8)
                    }
                    .frame(width: 393)
                    
                    Spacer()
                    
                    HStack {
                        Text("\(artist!.name)")
                            .foregroundColor(.white)
                            .font(.title3)
                            .fontWeight(.heavy)
                            .padding()
                        Spacer()
                        
                    }
                }
                
            }
            .frame(width: 393, height: 280, alignment: .leading)
            VStack {
                Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Arcu non odio euismod lacinia at quis risus sed. Hac habitasse platea dictumst vestibulum rhoncus.")
                    .foregroundColor(.whiteFont)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 2)
                    .bold()
                    .font(.caption)
            }
            
            Spacer()
            VStack {
                Text("hello")
            }
        }
        .background(Color.background)
        
    }
    
}
let sampleArtistObject = ArtistObject(
    externalUrls: .init(spotify: "https://open.spotify.com/artist/3TVXtAsR1Inumwj472S9r4"),
    followers: .init(href: nil, total: 81149681),
    genres: ["canadian hip hop", "canadian pop", "hip hop", "pop rap", "rap"],
    href: "https://api.spotify.com/v1/artists/3TVXtAsR1Inumwj472S9r4",
    id: "3TVXtAsR1Inumwj472S9r4",
    images: [
        .init(url: "https://i.scdn.co/image/ab6761610000e5eb4293385d324db8558179afd9", height: 640, width: 640),
        .init(url: "https://i.scdn.co/image/ab676161000051744293385d324db8558179afd9", height: 320, width: 320),
        .init(url: "https://i.scdn.co/image/ab6761610000f1784293385d324db8558179afd9", height: 160, width: 160)
    ],
    name: "Drake",
    popularity: 96,
    type: "artist",
    uri: "spotify:artist:3TVXtAsR1Inumwj472S9r4"
)



#Preview {
    ArtistObjectView(artist: sampleArtistObject)
}
