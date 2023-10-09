//
//  ProfileView.swift
//  Krates
//
//  Created by Eli Lopez on 10/4/23.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        VStack {
            
            HStack {
                Spacer()
                Spacer()
                Text("Profile")
                    .font(.title)
                    .foregroundColor(.whiteFont)
                    .padding(.horizontal)
                    .bold()
                Spacer()
                Button(action: {
                    //settings
                }) {
                    Image("icons8-three-dots-50")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .padding(.horizontal)
                }
                
            }
            ZStack(alignment: .leading)  {
                
                Rectangle()
                    .frame(height: 300)
                    .foregroundColor(.blue)
                
                VStack {
                    Spacer()
                    HStack(alignment: .center) {
                        Circle()
                            .frame(width: 140)
                            .padding()
                        VStack (alignment: .leading) {
                            Image("dummy")
                                .resizable()
                                .frame(width: 50, height: 50)
                            Text("asaucy_goth")
                                .font(.title3)
                                .foregroundColor(.whiteFont)
                            HStack() {
                                Text("lists")
                                    .font(.caption)
                                    .foregroundColor(.accentLightGray)


                                Text("albums")
                                    .font(.caption)
                                    .foregroundColor(.accentLightGray)



                            }
                            HStack {
                                Text("100 Followers")
                                    .font(.caption)
                                    .foregroundColor(.accentLightGray)

                                Text("200 Following")
                                    .font(.caption)
                                    .foregroundColor(.accentLightGray)



                            }
                            
                            
                        }
                        
                    }.background(.red)
                    
                }
                .background(.gray)
                .frame(height: 300)
              
                
                
                    
            }
          
            Spacer()
        }
        .background(Color.accentDarkGray)
    }
}

#Preview {
    ProfileView()
}
