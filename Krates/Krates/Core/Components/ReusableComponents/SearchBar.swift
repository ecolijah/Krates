//
//  SearchBar.swift
//  Krates
//
//  Created by Eli Lopez on 11/2/23.
//

import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    var body: some View {
    
        HStack {
            TextField("Search...", text: $text)
                .padding(8)
                .padding(.horizontal, 24)
                .background(Color.accentDarkGray)
                .cornerRadius(8)
                .foregroundColor(.accentLightGray)
                .overlay(
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.accentLightGray)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 4)
                    }
                )
        }
        .padding(.horizontal, 4)
    }
}


struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(text: .constant(""))
    }
}

