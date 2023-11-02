//
//  ProfileVisitingView.swift
//  Krates
//
//  Created by Eli Lopez on 10/9/23.
//

import SwiftUI
import Kingfisher

struct ProfileVisitingView: View {
    
    @State private var selectedFilter: KrateFilterViewModel = .krates
    @State private var likedAlbums: [Album] = []
    let user: User
    var spotifyAPIManager = SpotifyAPIManager()


    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        
        VStack(alignment: .leading) { //parent container

            ProfileVisitingHeader(user: user)
            
            KrateFilterView(selectedFilter: $selectedFilter).offset(y: 8)
            
            if selectedFilter == .krates {
                ScrollView {
                    LazyVStack {
                        ForEach(0...9, id: \.self) {_ in
                            KrateRowCell(menuShowing: .constant(false), krate: krate1)
                                .ignoresSafeArea()
                        }
                    }
                }
                .padding(.bottom, 50)
            }
            if selectedFilter == .likes {
                GridAlbumView(albums: likedAlbums)
                    .padding(.bottom, 50)
                    .ignoresSafeArea()
            }
//            if selectedFilter == .reviews {
//
//            }
            
            
        }
        .background(Color.background)
        .onAppear {
            guard let x = user.likedAlbums else { return }
            spotifyAPIManager.fetchAlbumsInKrate(krateAlbums: x) { albums, error in
                if let albums = albums {
                    self.likedAlbums = albums
                } else {
                    print("Error fetching recommended albums:", error?.localizedDescription ?? "Unknown error")
                }
            }
        }
    }
}

struct ProfileVisitingInfo: View {
    let user: User
    
    var body: some View {
        
        HStack(alignment: .bottom) {//picture and user info
            KFImage(URL(string: user.profileImageUrl))
                .resizable()
                .scaledToFill()
                .clipShape(.circle)
                .shadow(color: Color.black.opacity(0.8), radius: 10, x: 0, y: 0)
                .frame(width: 112, height: 112)
//                Circle()
//                    .frame(width: 112, height: 112)
//                    .shadow(color: Color.black.opacity(0.8), radius: 10, x: 0, y: 0)
//                    .foregroundColor(.accentLightGray)
            VStack(alignment: .leading, spacing: 2)  { //user info
                //user name
                Text(user.username)
                    .font(.title3)
                    .fontWeight(.heavy)
                    .foregroundColor(.whiteFont)
                    .padding(2)
                
                HStack { //stats
                    Text("\(user.numLists) Lists    • ")
                        .font(.caption)
                        .fontWeight(.heavy)
                        .foregroundColor(.accentLightGray)
                        .padding(.vertical, 2)


                    Text(" \(user.numLikedAlbums) Albums")
                        .fontWeight(.heavy)
                        .font(.caption)
                        .foregroundColor(.accentLightGray)
                        .padding(.vertical, 2)

                }
                
                HStack { //following row
                    Text("\(user.followersCount) Followers    • ")
                        .font(.caption)
                        .fontWeight(.heavy)
                        .foregroundColor(.accentLightGray)
                        .padding(.vertical, 2)

                    Text(" \(user.followingCount) Following")
                        .font(.caption)
                        .fontWeight(.heavy)
                        .foregroundColor(.accentLightGray)
                        .padding(.vertical, 2)
                }
                
            }.padding(.leading).shadow(radius: 4)

            
        }.offset(x: 16, y: 80)
        
    }
}

struct ProfileVisitingHeader: View {
    let user: User
    var body: some View {
        VStack {
            ZStack( alignment: .leading) {
                
                Color(.systemBrown)
                    .ignoresSafeArea()
                
                Image("profilebackgroundtusks")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .ignoresSafeArea()
                    .frame(height: 240)
                    .offset(y: -30)
                
                LinearGradient(
                    gradient: Gradient(stops: [
                        .init(color: Color.background.opacity(1), location: 0.2),
                        .init(color: Color.background.opacity(0.0001), location: 0.8)
                    ]),
                    startPoint: .bottom,
                    endPoint: .top
                ).offset(y: 16)
                
                ProfileVisitingInfo(user: user)

                ProfileVisitingTopBar().offset(y: -130)
                
            }
            .frame(height: 280).background(.red)
            
            
        }
    }
}

struct ProfileVisitingTopBar: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        VStack {
            
            HStack (alignment:.center) {
                
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
//                Rectangle()
//                    .frame(width: 30, height: 30)
//                    .foregroundColor(.clear).padding(.horizontal, 16)
                
                Spacer()
                
                Text("Profile")
                    .font(.title3)
                    .fontWeight(.heavy)
                    .foregroundColor(.whiteFont) // Modify as per your color scheme
                    .shadow(color: Color.black.opacity(0.9), radius: 10, x: 0, y: 0)
//                    .offset(x: -10, y: -40)
                
                Spacer()
                

                
                Menu {
                    Button("option1", action: handleOption1)
                    Button("Done", action: dismissMenu)
                } label: {
                    Image("icons8-three-dots-50")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(.accentLightGray) // Modify as per your color scheme
                        .shadow(color: Color.black.opacity(0.9), radius: 10, x: 0, y: 0)
                        .padding(.trailing, 16)
//                        .offset(y: -20)
                }
                
            }
            
        }
        .background(Color.clear)
    }
    
    func handleOption1() {
//        viewModel.signOut()
        print("DEBUG: profile visiting handle option 1")
        
    }
    
    func dismissMenu() {
        print("DEBUG: dismissing menu.")
    }
}
//
//#Preview {
//    ProfileVisitingView()
//}
