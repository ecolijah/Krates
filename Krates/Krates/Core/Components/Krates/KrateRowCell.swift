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
                    .fontWeight(.heavy)
                    .padding(.horizontal, 16)
                    
                
                Spacer()
                
                Text("dreadpirate")
                    .padding(.horizontal, -12)
                    .foregroundColor(.accentLightGray)
                    .fontWeight(.heavy)
                    .font(.callout)
                
                Circle()
                    .frame(width: 40, height: 40)
                    .foregroundColor(.blue)
                    .padding(.horizontal, 16)
            }
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 4) {
                    ForEach(0..<8) { index in
                        Image("dummy")
                            .resizable()
                            .frame(width: 64, height: 64)
                            .cornerRadius(2)
                    }
                }
            }
            .padding(.leading, 16)
            .edgesIgnoringSafeArea(.all)
            

            Text("this is a list of “coming of age” type albums but for  those in their mid 20s something not knowing where their lives going. feeling lost, no hope that  things will change, feeling so so many things.")
                .foregroundColor(.accentLightGray)
                .padding(.vertical, 8)
                .padding(.horizontal, 16)
                .font(.caption)
                .fontWeight(.heavy)
      
            Rectangle()
                .frame(height: 2)
                .foregroundColor(.divider)
                .padding(.horizontal, 16)
                .cornerRadius(2)
        }
        .padding(.vertical, 8)
        .background(Color.background)
    }

}

#Preview {
    KrateRowCell()
}
