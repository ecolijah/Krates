//
//  HomeKratesView.swift
//  Krates
//
//  Created by Eli Lopez on 10/6/23.
//

import SwiftUI

struct HomeKratesView: View {

    var body: some View {
        VStack(alignment: .leading) {
            
            ScrollView() {
                LazyVStack(spacing: 0) {
                    ForEach(0..<5) { _ in
                        KrateRowCell()
                    }
                }
            }
        }
        .background(Color.background)

    }
}

#Preview {
    HomeKratesView()
}
