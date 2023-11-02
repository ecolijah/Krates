//
//  ProfileView.swift
//  Krates
//
//  Created by Eli Lopez on 10/4/23.
//

import SwiftUI
import Kingfisher

//testing krate
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

struct ProfileView: View {
    @State private var selectedFilter: KrateFilterViewModel = .krates
    @State private var likedAlbums: [Album] = []
    var spotifyAPIManager = SpotifyAPIManager()


    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        
        VStack(alignment: .leading) { //parent container

            ProfileHeaderTwo()
            
            KrateFilterView(selectedFilter: $selectedFilter).offset(y: 8)
            
            if selectedFilter == .krates {
                ScrollView {
                    LazyVStack {
                        ForEach(0...9, id: \.self) {_ in
                            KrateRowCell(menuShowing: .constant(false), krate: krate1)
                        }
                    }
                }
                .padding(.bottom, 50)
            }
            if selectedFilter == .likes {
                GridAlbumView(albums: likedAlbums)
                    .padding(.bottom, 50)
            }
//            if selectedFilter == .reviews {
//                
//            }
            
            
        }
        .background(Color.background)
        .onAppear {
            guard let x = viewModel.currentUser?.likedAlbums else { return }
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

struct KrateFilterView: View {
    @Namespace var animation
    @Binding var selectedFilter: KrateFilterViewModel
    var body: some View {
        HStack {
            ForEach(KrateFilterViewModel.allCases, id: \.rawValue) { item in
                VStack {
                    Text(item.title)
                        .fontWeight(selectedFilter == item ? .semibold : .regular)
                        .font(.subheadline)
                        .foregroundColor(selectedFilter == item ? .whiteFont : .accentLightGray)
                    if selectedFilter == item {
                        Capsule()
                            .foregroundColor(.brightOrange)
                            .frame(height: 3)
                            .matchedGeometryEffect(id: "filter", in: animation)
                    } else {
                        Capsule()
                            .foregroundColor(.clear)
                            .frame(height: 3)
                    }
                }
                .onTapGesture {
                    withAnimation(.easeInOut) {
                        self.selectedFilter = item
                    }
                }
            }
        }
        .padding(.top, 15)
        .overlay(Divider().offset(x: 0, y: 29))
        .background(Color.background)
    }
}

struct ProfileInfoTwo: View {
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        if let user = viewModel.currentUser {
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
}

struct ProfileHeaderTwo: View {
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
                
                ProfileInfoTwo()

                ProfileHeader().offset(y: -130)
                
            }
            .frame(height: 280).background(.red)
            
            
        }
    }
}


struct ProfileHeader: View {
    @EnvironmentObject var viewModel: AuthViewModel
    var body: some View {
        VStack {
            
            HStack (alignment:.center) {
                
//                Button { //temporary logout button
//                    viewModel.signOut()
//                } label: {
//                    Rectangle()
//                        .frame(width: 30, height: 30)
//                        .foregroundColor(.red)
//                        .shadow(color: Color.black.opacity(0.8), radius: 20, x: 0, y: 0)
//                        .cornerRadius(10)
//                }
                Rectangle()
                    .frame(width: 30, height: 30)
                    .foregroundColor(.clear).padding(.horizontal, 16)
                
                Spacer()
                
                Text("Profile")
                    .font(.title3)
                    .fontWeight(.heavy)
                    .foregroundColor(.whiteFont) // Modify as per your color scheme
                    .shadow(color: Color.black.opacity(0.9), radius: 10, x: 0, y: 0)
                    .offset(x: 16)
                
                Spacer()
                
                NavigationLink {
                    //code
                    createKrateView()
                        .navigationBarBackButtonHidden(true)
                } label: {
                    Image(systemName: "plus")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .foregroundColor(Color.accentLightGray)
                        .padding(.trailing)
                        .shadow(color: Color.black.opacity(0.9), radius: 10, x: 0, y: 0)

                }
                
                Menu {
                    Button("LogOut", action: logOut)
                    Button("Done", action: dismissMenu)
                } label: {
                    Image("icons8-three-dots-50")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(.accentLightGray) // Modify as per your color scheme
                        .shadow(color: Color.black.opacity(0.9), radius: 10, x: 0, y: 0)
                        .padding(.trailing, 16)
                        .offset(y: -5)
                }
                
            }
            
        }
        .background(Color.clear)
    }
    
    func logOut() {
        viewModel.signOut()
        print("DEBUG: logging out from profile view.")
        
    }
    
    func dismissMenu() {
        print("DEBUG: dismissing menu.")
    }
}

#Preview {
    ProfileView()
}
