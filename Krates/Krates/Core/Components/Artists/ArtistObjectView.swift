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
    @State private var artistAlbums: [Album] = []
    @State private var album_uris: [String] = []
    @Environment(\.presentationMode) var presentationMode

    private var backButton: some View {
        Button(action: {
            presentationMode.wrappedValue.dismiss()
            print("back button pressed.")
        }) {
            ZStack {
                Circle().foregroundColor(.background.opacity(0.3))
                    .frame(width: 35)
                Image(systemName: "arrowshape.backward.fill").foregroundColor(.accentLightGray)
            }
        }
    }

    private var menuButton: some View {
        Button(action: {}) {
            ZStack {
                Circle()
                    .foregroundColor(.background.opacity(0.3))
                    .frame(width: 35)

                Image(systemName: "ellipsis")
                    .resizable()
                    .foregroundColor(.accentLightGray)
                    .frame(width: 30, height: 6)
            }
        }
    }
    var body: some View {
        VStack { //parent container
            
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
                Text("Jorge Mário da Silva, more commonly known by his stage name Seu Jorge; born June 8, 1970; Portuguese pronunciation: [ˈsew ˈʒɔʁʒi]), is a Brazilian musical artist, songwriter, and actor. He is considered by many a renewer of Brazilian pop samba. Seu Jorge cites samba schools and American soul singer Stevie Wonder as major musical influences.[2] Jorge is also known for his film roles as Mané Galinha in the 2002 film City of God and as Pelé dos Santos in the 2004 film The Life Aquatic with Steve Zissou. His musical work has received praise from many of his fellow musicians including Beck and David Bowie.")
                    .foregroundColor(.whiteFont)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 2)
                    .bold()
                    .font(.caption)
            }
            
            GridAlbumView(albums: artistAlbums)
            
            Spacer()
            
        }
        .background(Color.background)
        .onAppear {
            guard let artistId = artist?.id else {
                print("Artist is nil. Can't fetch albums.")
                return
            }
            spotifyAPIManager.fetchAlbumsForArtist(withId: artistId) { uris, error in
                if let uris = uris {
                    // Handle the list of album URIs
                    self.album_uris = uris
                    print(uris)
                    
                    // Now that we have the URIs, fetch the albums
                    spotifyAPIManager.fetchAlbumsInKrate(krateAlbums: self.album_uris) { albums, error in
                        if let albums = albums {
                            self.artistAlbums = albums
                            print("DEBUG: number of albums we got: \(albums.count)")
                        } else {
                            print("Error fetching albums:", error?.localizedDescription ?? "Unknown error")
                        }
                    }

                } else if let error = error {
                    // Handle the error
                    print("Error:", error.localizedDescription)
                }
            }
        }


        
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
