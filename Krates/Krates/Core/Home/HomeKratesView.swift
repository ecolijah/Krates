//
//  HomeKratesView.swift
//  Krates
//
//  Created by Eli Lopez on 10/6/23.
//

import SwiftUI

struct HomeKratesView: View {
    @Binding var menuShowing: Bool
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                
                ScrollView() {
                    LazyVStack(spacing: 0) {
                        ForEach(0..<5) { _ in
                            KrateRowCell(menuShowing: $menuShowing)
                        }
                    }
                }
            }
            .background(Color.background)
        }
        

    }
}

//#Preview {
//    HomeKratesView()
//}
