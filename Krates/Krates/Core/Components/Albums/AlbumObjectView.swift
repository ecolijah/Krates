//
//  AlbumObjectView.swift
//  Krates
//
//  Created by Eli Lopez on 10/6/23.
//

import SwiftUI

struct AlbumObjectView: View {
    var album: Album
    var spotifyAPIManager = SpotifyAPIManager()
    @State var artist: ArtistObject?

    

    
    
    
    var body: some View {
        VStack {
            ZStack (alignment: .top){
                let imageURL = artist?.images[0].url ?? ""
                let url = URL(string: imageURL)
                //artist image
                AsyncImage(url: url)
                    .frame(height: 280)
                    .cornerRadius(5)
                    .aspectRatio(contentMode: .fit)
                    .edgesIgnoringSafeArea(.all)
                    
                
                LinearGradient(
                    gradient: Gradient(stops: [
                        .init(color: Color.background.opacity(1), location: 0.05),
                        .init(color: Color.background.opacity(0.01), location: 0.4)
                    ]),
                    startPoint: .bottom,
                    endPoint: .top
                )
                .frame(height: 280)
                .edgesIgnoringSafeArea(.all)
                
                AlbumInfoView(album: album)
                
            }
            .frame(height: 340)
            
            Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Arcu non odio euismod lacinia at quis risus sed. Hac habitasse platea dictumst vestibulum rhoncus. Pellentesque diam volutpat commodo sed egestas. Urna porttitor rhoncus dolor purus non enim praesent elementum. Proin fermentum leo vel orci. Ultrices sagittis orci a scelerisque. Viverra nam libero justo laoreet sit amet cursus sit. Amet nulla facilisi morbi tempus.")
                .foregroundColor(.whiteFont)
                .padding(.horizontal, 10)
                .padding(.vertical, 6)
                .bold()
                .font(.caption)
            
            
            Spacer()
        }
        .background(Color.background)
        .onAppear {
            let artistIdToFetch = album.artists[0].id  // replace with your actual artist ID
            spotifyAPIManager.fetchArtistInfo(for: artistIdToFetch) { artist, error in
                if let artist = artist {
                    // Use the fetched artist data here
                    print(artist.name)
                    self.artist = artist
                } else if let error = error {
                    // Handle error here
                    print("Failed to fetch artist:", error.localizedDescription)
                }
            }

        }

    }
    
}

struct AlbumInfoView: View {
    var album: Album
    
    var body: some View {
        VStack {
            Spacer()
            HStack (alignment: .bottom) {
                VStack(alignment: .leading) {
                    //album info
                    Text("\(album.name)")
                        .bold()
                        .foregroundColor(.white)
                        .font(.title3)
                        .fontWeight(.heavy)
                        .lineLimit(2) // Limit to 1 line
                        .truncationMode(.tail)
                        .lineSpacing(-12)
                        .padding(.leading, 10)
                        .padding(.bottom, 1)

                    Text("\(album.artists[0].name) - \(String(album.releaseDate.split(separator: "-").first ?? ""))")
                        .bold()
                        .foregroundColor(.accentLightGray)
                        .font(.system(size: 14))
                        .lineLimit(2)
                        .truncationMode(.tail)
                        .padding(.bottom, 1)
                        .padding(.leading, 10)



                    Text("\(album.totalTracks) songs - ")
                        .bold()
                        .foregroundColor(.accentLightGray)
                        .font(.caption2)
                        .bold()
                        .padding(.vertical, 1)
                        .padding(.leading, 10)


                    HStack {
                        Button (action: {
                            //actionn here
                        }) {
                            //views here
                            HStack{
                                Image(systemName: "heart.fill")
                                    .resizable()
                                    .frame(width: 23, height: 23)
                                    .foregroundColor(.brightOrange)
                                Text("97.2k")
                                    .font(.caption)
                                    .foregroundColor(.brightOrange)
                                    .bold()
                            }
                        }
                        .padding(.trailing, 12)
                        
                        Button (action: {
                            //actionn here
                        }) {
                            //views here
                            HStack{
                                Image(systemName: "star.fill")
                                    .resizable()
                                    .frame(width: 23, height: 23)
                                    .foregroundColor(.whiteFont)
                                Text("4.3/5")
                                    .font(.caption)
                                    .foregroundColor(.whiteFont)
                                    .bold()
                            }
                        }
                        
                    }
                    .padding(.vertical, 1)
                    .padding(.leading, 10)


                }
                .frame(width: 200, alignment: .leading)
//                .background(.red)
                .padding(.leading, 50)
                 Spacer()
                //album image
                VStack {
                    if let imageURL = album.images.first?.url, let url = URL(string: imageURL) {
                        AsyncImage(url: url) { phase in
                            switch phase {
                            case .success(let image):
                                image
                                    .resizable()
                                    .scaledToFit()
                            default:
                                EmptyView()
                            }
                        }
                        .frame(width: 170, height: 170)
                        .cornerRadius(2)
                        .padding(.trailing, 12)
                        .shadow(color: .black, radius: 15)
                    } else {
                        EmptyView()
                    }
                }
                .padding(.trailing, 50)

            }
            .frame(width: 393)
//            .background(.blue)
        }
    }
}

//#Preview {
//    AlbumObjectView()
//}
