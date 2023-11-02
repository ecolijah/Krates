//
//  ProfileRowView.swift
//  Krates
//
//  Created by Eli Lopez on 11/2/23.
//

import SwiftUI
import Kingfisher

struct ProfileRowView: View {
    let user: User
    var body: some View {
        
        VStack (alignment: .leading) { // parent container
            HStack { // profile info
                KFImage(URL(string: user.profileImageUrl))
                    .resizable()
                    .frame(width: 85, height: 85)
                    .clipShape(Circle())
               
                
                VStack (alignment: .leading)  {
                    
                    Text(user.username)
                        .font(.title3)
                        .fontWeight(.heavy)
                        .foregroundColor(Color.white)
                    
                    Text(user.fullname)
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

//#Preview {
//    ProfileRowView()
//}
