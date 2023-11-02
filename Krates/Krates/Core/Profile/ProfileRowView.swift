//
//  ProfileRowView.swift
//  Krates
//
//  Created by Eli Lopez on 11/2/23.
//

import SwiftUI

struct ProfileRowView: View {
    var body: some View {
        
        VStack (alignment: .leading) { // parent container
            HStack { // profile info
//                KFImage(URL(string: album.images[0].url))
//                    .resizable()
//                    .frame(width: 85, height: 85)
                Image("dummy")
                    .resizable()
                    .frame(width: 65, height: 65)
                    .clipShape(Circle())
                
                VStack (alignment: .leading)  {
                    
                    Text("username")
                        .font(.title3)
                        .fontWeight(.heavy)
                        .foregroundColor(Color.white)
                    
                    Text("full name")
                        .font(.callout)
                        .foregroundColor(Color.accentLightGray)
                }
                
                Spacer()
            }.padding(.top, 4)
            
            Divider()
                .foregroundColor(Color.accentLightGray)
        }
        .frame(height: 70)
        .padding()
        .background(Color.background)
    }

}

#Preview {
    ProfileRowView()
}
