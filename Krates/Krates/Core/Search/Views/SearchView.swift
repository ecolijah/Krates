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
    var body: some View {
        
        VStack (spacing: 0) { // parent container
            
            SearchFilterView(selectedFilter: $selectedFilter)
            SearchBar(text: $searchViewModel.searchText)
                .padding(.vertical)
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
                        ForEach(0...10, id: \.self) { album in
                            NavigationLink {
    //                            AlbumObjectView()
                                Text("Album object view but test")
                            } label: {
                                AlbumRowView()
                            }
                        }
                    }
                    
                }
            }
        }
        .background(Color.background)
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
