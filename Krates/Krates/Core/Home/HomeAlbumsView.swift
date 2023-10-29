import SwiftUI

struct HomeAlbumsView: View {
    @Binding var menuShowing: Bool
    @State private var recommendedAlbums: [Album] = []

    var categories = ["Recommended"]
    
    var spotifyAPIManager = SpotifyAPIManager()
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(alignment: .leading) {
                        VStack(spacing: 16) {
                            ForEach(categories.indices, id: \.self) { index in
                                HorizontalScrollView(menuShowing: $menuShowing, category: categories[index], albums: index == 0 ? recommendedAlbums : [])
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
            spotifyAPIManager.fetchRecommended { albums, error in
                if let albums = albums {
                    self.recommendedAlbums = albums
                } else {
                    print("Error fetching recommended albums:", error?.localizedDescription ?? "Unknown error")
                }
            }
        }
    }
}

struct HorizontalScrollView: View {
    @Binding var menuShowing: Bool
    var category: String
    var albums: [Album] = []

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
                    ForEach(albums, id: \.id) { album in
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
                .onAppear {
                    menuShowing.toggle()
                }
                .onDisappear() {
                    menuShowing.toggle()
                }
        ) {
            VStack(alignment: .leading) {
                // Display album image
                if let imageURL = album.images.first?.url, let url = URL(string: imageURL) {
                    AsyncImage(url: url) { phase in
                        switch phase {
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFit()
                        default:
//                            Image("dummy")
//                                .resizable()
//                                .scaledToFit()
                            EmptyView()
                        }
                    }
                    .frame(width: 143, height: 143)
                    .cornerRadius(5)
                    .padding(1)
                } else {
//                    Image("dummy")
//                        .frame(width: 143, height: 143)
//                        .background(Color.blue)
//                        .foregroundColor(.white)
//                        .cornerRadius(5)
//                        .padding(1)
                    EmptyView()
                }

                // Display album name and artist name
                Text("\(album.name) - \(album.artists[0].name )")
                    .font(.caption)
                    .bold()
                    .foregroundColor(.whiteFont)
            }
        }
    }
}




struct SeeMoreCell: View {
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

// For Preview purposes
struct HomeAlbumsView_Previews: PreviewProvider {
    static var previews: some View {
        HomeAlbumsView(menuShowing: .constant(false))
    }
}

