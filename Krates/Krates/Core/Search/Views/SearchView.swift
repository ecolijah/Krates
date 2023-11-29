//
//  SearchView.swift
//  Krates
//
//  Created by Eli Lopez on 10/4/23.
//

import SwiftUI

struct SearchView: View {
    
    @State private var albumsInSearch: [Album] = []
    @ObservedObject var searchViewModel = SearchViewModel()
    @State private var selectedFilter: SearchFilterViewModel = .users
    var spotifyAPIManager = SpotifyAPIManager()

    var body: some View {
        
        VStack (spacing: 0) { // parent container
            
            SearchFilterView(selectedFilter: $selectedFilter)
            SearchBar(text: $searchViewModel.searchText)
                .padding(.vertical)
                .onSubmit { // This closure is called when the user presses Enter
                    searchAlbums()
                }
            ScrollView {
                LazyVStack (spacing: 0) {
                    if selectedFilter == .users {
                        ForEach(searchViewModel.searchableUsers, id: \.self) { user in
                            NavigationLink {
    //                            AlbumObjectView()
                                ProfileVisitingView(user: user)
                                    .navigationBarBackButtonHidden(true)
//                                Text("Album object view but test")
                            } label: {
                                ProfileRowView(user: user)
                            }
                        }
                    }
                    
                    if selectedFilter == .albums {
                        ForEach(albumsInSearch, id: \.id) { album in
                            NavigationLink(destination: AlbumObjectView(album: album)) {
                                AlbumRowView(album: album)
                            }
                        }
                    }

                    
                    if selectedFilter == .krates {
                        ForEach(0...10, id: \.self) { krate in
                            NavigationLink {
    //                            AlbumObjectView()
                                Text("krate object view but test")
                            } label: {
                                KrateRowCell(menuShowing: .constant(false),krate: krate1 )
                                
                            }
                        }
                    }
                    
                }
            }
        }
        .onChange(of: selectedFilter) { newFilter in
                    if newFilter == .albums {
                        // Call the search function to fetch albums
                        print("DEBUG: searching albums on change of search tab.")
                        searchAlbums()
                    }
                }
                .background(Color.background)
        .background(Color.background)
    }
    // Function to fetch albums and update the albumsInSearch array
        func searchAlbums() {
            // Call your search function here and populate albumsInSearch
            // Example:
            spotifyAPIManager.searchAlbums(query: searchViewModel.searchText) { albums, error in
                if let albums = albums {
                    self.albumsInSearch = albums
                } else if let error = error {
                    // Handle the error
                    print("Error searching for albums: \(error.localizedDescription)")
                }
            }
        }
}

struct SearchFilterView: View {
    @Namespace var animation
    @Binding var selectedFilter: SearchFilterViewModel
    var body: some View {
        HStack {
            ForEach(SearchFilterViewModel.allCases, id: \.rawValue) { item in
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

#Preview {
    SearchView()
}
