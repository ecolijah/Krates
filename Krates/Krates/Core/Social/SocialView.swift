//
//  SocialView.swift
//  Krates
//
//  Created by Eli Lopez on 10/4/23.
//

import SwiftUI

struct SocialView: View {
    @State private var selectedIndex = 0
    let buttons: [String] = ["Friends" , "You", "Incoming"]
    
    var body: some View {
        
        VStack {
            HStack {
                Spacer()
                Spacer()
                Text("Social")
                    .font(.title)
                    .foregroundColor(.whiteFont)
                    .bold()
                    .padding()
                Spacer()
                Button(action: {
                    //filterbutton?
                }) {
                    Image("icons8-filter-50")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .padding()
                }
                
                
            }
            
            HStack(spacing: 16) {
                ForEach(0..<3){ index in
                    Button(action: {
                        //something
                        selectedIndex = index
                    }) {
                        Text(buttons[index])
                            .frame(width: 100)
                            .font(.title3)
                            .foregroundColor(selectedIndex == index ? Color.brightOrange : Color.accentLightGray)                            .bold()
                    }
                    if index < 2 {
                        Divider()
                            .background(Color.accentLightGray)
                            .frame(height: 30)
                            .padding(.vertical, 4)
                    }
                    
                }
                
            }
            .padding(.horizontal, 6)
            .background(Color.accentDarkGray)
            .cornerRadius(10)

            NotificationsView(notifIndex: $selectedIndex)

            
        }
        .background(Color.background)
    }
    
}

struct NotificationsView: View {
    @Binding var notifIndex: Int
    let notifTypes: [String] = ["Friends","You","Incoming"]
    var body: some View {
        
//        Text(notifTypes[notifIndex])
//            .foregroundColor(.whiteFont)
        ScrollView {
            VStack(spacing: 0) {
                ForEach(0..<20) { index in
                    HorizontalNotificationsCell()
                    
                }
            }
        }
        .background(Color.accentDarkGray)
    }
}

struct HorizontalNotificationsCell: View {
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Circle()
                    .frame(width: 30, height: 34)
                    .foregroundColor(.accentLightGray)
                    .padding(.horizontal, 4)
                Text("Notifcation message")
                    .foregroundColor(.accentLightGray)
                Spacer()
                Text("2h")
                    .foregroundColor(.accentLightGray)
       
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
//            .background(Color.background)
            
            Rectangle()
                .fill(Color.divider) // Choose your desired color
                .frame(height: 2)
                .cornerRadius(1)
         
        }
        
    }
}

#Preview {
    SocialView()
}
