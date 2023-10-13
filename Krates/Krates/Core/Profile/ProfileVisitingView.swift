//
//  ProfileVisitingView.swift
//  Krates
//
//  Created by Eli Lopez on 10/9/23.
//

import SwiftUI

struct ProfileVisitingView: View {
    var body: some View {
        VStack {
            HStack { Spacer() }
            Spacer()
            Text("Visiting profile View")
                .foregroundColor(.white)
            Spacer()
        }.background(Color.background)
    }
}

#Preview {
    ProfileVisitingView()
}
