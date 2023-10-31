//
//  AuthHeaderView.swift
//  Krates
//
//  Created by Eli Lopez on 10/31/23.
//

import SwiftUI

struct AuthHeaderView: View {
    let title1: String
    let title2: String
    var body: some View {
        VStack (alignment: .leading) { //header view
            HStack { Spacer ()}
            Text(title1)
                .font(.largeTitle)
                .fontWeight(.semibold)
            Text(title2)
                .font(.largeTitle)
                .fontWeight(.semibold)
            
            
        }
        .frame(height: 280)
        .padding(.leading)
        .background(Color.background)
        .foregroundColor(Color.accentLightGray)
        .clipShape(RoundedShape(corners: [.bottomRight]))
    }
}

#Preview {
    AuthHeaderView(title1: "Hello", title2: "Welcome back.")
}
