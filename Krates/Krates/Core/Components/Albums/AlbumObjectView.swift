//
//  AlbumObjectView.swift
//  Krates
//
//  Created by Eli Lopez on 10/6/23.
//

import SwiftUI
import Kingfisher
import Firebase

struct AlbumObjectView: View {
    var album: Album
    var spotifyAPIManager = SpotifyAPIManager()
    @State var artist: ArtistObject?
    @EnvironmentObject var viewModel: AuthViewModel
    @Environment(\.presentationMode) var presentationMode

    
    var body: some View {
        VStack {
            ZStack (alignment: .top){
                
                let imageURL = artist?.images[0].url ?? ""
                //artist image
                KFImage(URL(string: imageURL))
                    .frame(height: 280)
                    .cornerRadius(5)
                    .aspectRatio(contentMode: .fit)
                    
                
                LinearGradient(
                    gradient: Gradient(stops: [
                        .init(color: Color.background.opacity(1), location: 0.05),
                        .init(color: Color.background.opacity(0.01), location: 0.4)
                    ]),
                    startPoint: .bottom,
                    endPoint: .top
                )
                .frame(height: 280)
                
                AlbumInfoView(album: album, artist: artist)
                HStack {
                    Button(action: {
                        // Code to go back
                        self.presentationMode.wrappedValue.dismiss()
                        print("back button pressed.")
                    }) {
                        ZStack {
                            Circle()
                                .foregroundColor(.background.opacity(0.3))
                            Image(systemName: "arrowshape.backward.fill") // Replace with your custom icon
                                .foregroundColor(.accentLightGray)
                        }
                        .frame(width: 40, height: 40)
                        .padding(.top, 8)
                        .padding(.leading, 8)
                    }
                    Spacer()
                    Menu {
                        //code
                        Button("Add to favorites ♥", action: addAlbumToLikedAlbums)
                        Button("Add to 'to listen'", action: handleOption2)
                        Button("Add to krate", action: handleOption3)
                        Button("Done", action: handleOption4)
                    } label: {
                        ZStack {
                            Circle()
                                .foregroundColor(.background.opacity(0.3))
                            Image(systemName: "ellipsis") // Replace with your custom icon
                                .resizable()
                                .foregroundColor(.accentLightGray)
                                .frame(width: 30, height: 6)
                                
                        }
                        .frame(width: 40, height: 40)
                        .padding(.top, 8)
                        .padding(.trailing, 8)
                    }
                    
                }
                .frame(width: 393)
                
                
            }
            .frame(height: 340, alignment: .leading)
//            .background(.red)
            
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
    
    func addAlbumToLikedAlbums() {
        guard let currentUser = viewModel.currentUser else {
            print("DEBUG: Current user is nil.")
            return
        }
        
        let album_uri = self.album.uri
        
        // Ensure we have a valid user ID before proceeding
         guard let uid = currentUser.id else {
             print("DEBUG: User ID is nil.")
             return
         }
        
        // Fetch the current likedAlbums from the database first
        Firestore.firestore().collection("users")
            .document(uid)
            .getDocument { (document, error) in
                if let document = document, document.exists {
                    // Try to decode the user data to get the current likedAlbums and numLikedAlbums
                    let user = try? document.data(as: User.self)
                    
                    // Append the new album_uri to the existing likedAlbums
                    var updatedLikedAlbums = user?.likedAlbums ?? []
                    var numLikedAlbums = user?.numLikedAlbums ?? 0
                    
                    if !updatedLikedAlbums.contains(album_uri) {
                        updatedLikedAlbums.append(album_uri)
                        numLikedAlbums += 1  // Increment numLikedAlbums
                    }
                    
                    // Now update the database with the new list and incremented numLikedAlbums
                    Firestore.firestore().collection("users")
                        .document(uid)
                        .updateData([
                            "likedAlbums": updatedLikedAlbums,
                            "numLikedAlbums": numLikedAlbums
                        ]) { error in
                            if let error = error {
                                print("DEBUG: Failed to update liked albums and count: \(error.localizedDescription)")
                            } else {
                                print("DEBUG: Successfully updated liked albums and count.")
                                // Update the local user model
                                self.viewModel.currentUser?.likedAlbums = updatedLikedAlbums
                                self.viewModel.currentUser?.numLikedAlbums = numLikedAlbums
                            }
                        }
                } else {
                    print("Document does not exist")
                }
            }
    }



    func handleOption2() {
        print("DEBUG: Handling option 2")
    }
    func handleOption3() {
        print("DEBUG: Handling option 3")
    }
    func handleOption4() {
        print("DEBUG: Handling option 4")
    }
    
}

struct AlbumInfoView: View {
    var album: Album
    var artist: ArtistObject?
    @Environment(\.presentationMode) var presentationMode

    
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
                    NavigationLink(
                        destination: ArtistObjectView(artist: artist)
                            .navigationBarBackButtonHidden(true)
                            

                    ) {
                        Text("\(album.artists[0].name) - \(String(album.releaseDate.split(separator: "-").first ?? ""))")
                            .bold()
                            .foregroundColor(.accentLightGray)
                            .font(.system(size: 14))
                            .lineLimit(2)
                            .truncationMode(.tail)
                            .padding(.bottom, 1)
                            .padding(.leading, 10)
                    }
                    

                    Text("\(album.totalTracks) songs ")
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
