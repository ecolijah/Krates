import SwiftUI

struct KrateRowCell: View {
    @Binding var menuShowing: Bool
    var krate: Krate
    @State private var krateAlbums: [Album] = []
    var spotifyAPIManager = SpotifyAPIManager()
    

    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .center) {
                NavigationLink(
                    destination: KrateObjectView(krate: krate)
                        .navigationBarBackButtonHidden(true)
                        .onAppear { // This will toggle menuShowing when KrateObjectView appears
                            if menuShowing {
                                menuShowing.toggle()
                            }
                            
                        }

                ) {
                    Text("\(krate.name)")
                        .foregroundColor(.whiteFont)
                        .font(.title3)
                        .fontWeight(.heavy)
                        .padding(.horizontal, 16)
                        .multilineTextAlignment(.leading)
                }
                Spacer()
                
                NavigationLink(
                    destination: /*ProfileVisitingView()*/ EmptyView()
                        .navigationBarBackButtonHidden(false)
                        .onAppear { // This will toggle menuShowing when KrateObjectView appears
                            if menuShowing {
                                menuShowing.toggle()
                            }
                            
                        }
                    
                ) {
                    HStack {
                        Text("\(krate.author)")
                            .foregroundColor(.accentLightGray) // Replace with your custom color
                            .fontWeight(.heavy)
                            .font(.callout)
                        
                        Circle()
                            .frame(width: 40, height: 40)
                            .foregroundColor(.blue)
                            .padding(.trailing, 10)
                    }
                }
                
                
            }
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    
                    ForEach(krateAlbums) { album in
                        smallImageAbstraction(album: album)
                    }
                    
                }
            }
            .padding(.leading, 16)
            .edgesIgnoringSafeArea(.all)
            
            NavigationLink(destination: KrateObjectView(krate: krate)
                .navigationBarBackButtonHidden(true)
                .onAppear { // This will toggle menuShowing when KrateObjectView appears
                    if menuShowing {
                        menuShowing.toggle()
                    }
                    
                }
) {
                Text("\(krate.description)")
                    .foregroundColor(.accentLightGray) // Replace with your custom color
                    .padding(.vertical, 8)
                    .padding(.horizontal, 16)
                    .font(.caption)
                    .fontWeight(.heavy)
                    .multilineTextAlignment(.leading)
            }
            
            Rectangle()
                .frame(height: 2)
                .foregroundColor(.divider) // Replace with your custom color
                .padding(.horizontal, 16)
                .cornerRadius(2)
        }
        .padding(.vertical, 2)
        .background(Color.background) // Replace with your custom color
        .edgesIgnoringSafeArea(.all)
        .onAppear {
            spotifyAPIManager.fetchAlbumsInKrate(krateAlbums: krate.albums) { albums, error in
                if let albums = albums {
                    self.krateAlbums = albums
                } else {
                    print("Error fetching recommended albums:", error?.localizedDescription ?? "Unknown error")
                }
            }
        }
    }
}

struct smallImageAbstraction: View {
    var album: Album
    var body: some View {
        let imageURL = album.images[0].url
        let url = URL(string: imageURL)
        AsyncImage(url: url) { image in
            image
                .resizable()
                .scaledToFill()
                .frame(width: 60, height: 60)
                .clipped()
        }
        placeholder: {
            Rectangle().foregroundColor(.red).frame(width: 60, height: 60)
        }
        .background(Color.red)

            
    }
}

struct KrateRowCell_Previews: PreviewProvider {

    static var previews: some View {
        
        var krate1 = Krate(
            id: UUID(),
            name: "shoegazer",
            author: "ecolijah",
            dateCreated: Date(),
            likes: 3,
            description: "collection of my favorite shoegaze albums.",
            albums: ["spotify:album:4CIaS88EQ6j26qOigblqSH",
                     "spotify:album:4p73PcjJvWer7WDYXcGetn",
                      "spotify:album:5YrOTxB5pmtK6uD4qcpAw5",
                      "spotify:album:7EV6GsiM2nvt38n2FnnpEj",
                      "spotify:album:2tAFOhqz3DxxVI2s5YNsrD",
                      "spotify:album:0agALBMd2a8cnpbpukTg03"])
        
        KrateRowCell(menuShowing: .constant(false), krate: krate1)
    }
}

