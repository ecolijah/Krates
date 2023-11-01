import SwiftUI

struct KrateObjectView: View {
    var krate: Krate
    @State private var krateAlbums: [Album] = []
    var spotifyAPIManager = SpotifyAPIManager()

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
    
    //the view
    var body: some View {
        VStack {
            ZStack(alignment: .top) {
                Rectangle()
                    .frame(height: 280)
                    .foregroundColor(.blue)
                    .cornerRadius(5)
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
                        Text("\(krate.name)")
                            .foregroundColor(.white)
                            .font(.title3)
                            .fontWeight(.heavy)
                            .padding()
                        Spacer()
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
                
            }
            .frame(height: 280, alignment: .leading)
            VStack {
                Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Arcu non odio euismod lacinia at quis risus sed. Hac habitasse platea dictumst vestibulum rhoncus.")
                    .foregroundColor(.whiteFont)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 2)
                    .bold()
                    .font(.caption)
            }
            GridAlbumView(albums: krateAlbums)
            
            Spacer()
        }
        .background(Color.background)
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




//previews
struct KrateObjectView_Previews: PreviewProvider {
    static var previews: some View {
        KrateObjectView(krate: Krate(
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
                     "spotify:album:0agALBMd2a8cnpbpukTg03"]))
    }
}
