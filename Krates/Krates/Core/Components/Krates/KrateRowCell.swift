//
//  KrateRowCell.swift
//  Krates
//
//  Created by Eli Lopez on 10/7/23.
//

import SwiftUI

struct KrateRowCell: View {
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .center) {
                Text("feeling lost in your 20's")
                    .foregroundColor(.whiteFont)
                    .font(.title3)
                    .bold()
                    .padding(.horizontal, 16)
                    
                
                Spacer()
                
                Text("dreadpirate")
                    .padding(.horizontal, 8)
                    .foregroundColor(.accentLightGray)
                    .bold()
                
                Circle()
                    .frame(width: 40, height: 40)
                    .foregroundColor(.blue)
            }
            ScrollView(.horizontal, showsIndicators: true) {
                HStack(spacing: 0) {
                    ForEach(0..<8) { index in
                        Image("dummy")
                            .resizable()
                            .frame(width: 64, height: 64)
                    }
                }
            }
            .padding(.horizontal, 16)
            .edgesIgnoringSafeArea(.all)
            

            Text("this is a list of “coming of age” type albums but for  those in their mid 20s something not knowing where their lives going. feeling lost, no hope that  things will change, feeling so so many things.")
                .foregroundColor(.accentLightGray)
                .padding(.vertical, 8)
                .padding(.horizontal, 16)
            Divider()
                .background(Color.accentLightGray)
                .padding(.horizontal, 16)
        }
        .padding(.vertical, 8)
        .background(Color.background)
    }

}

#Preview {
    KrateRowCell()
}
