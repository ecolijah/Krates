//
//  AlbumObjectView.swift
//  Krates
//
//  Created by Eli Lopez on 10/6/23.
//

import SwiftUI

struct AlbumObjectView: View {
    var body: some View {
        VStack {
            HStack { Spacer() }
            Spacer()
            Text("Album Object View")
                .foregroundColor(.white)
            Spacer()
        }.background(Color.background)

    }
}

#Preview {
    AlbumObjectView()
}
