//
//  createKrateView.swift
//  Krates
//
//  Created by Eli Lopez on 11/2/23.
//

import SwiftUI

struct createKrateView: View {

    var body: some View {
        VStack (spacing: 0) { //parent container
            createHeader()
            
            createInfo()
            
            Spacer()
            
        }
        .background(Color.background)
        
        
    }
}

struct createInfo: View {
    
    @State private var krateName = ""
    @State private var krateDescription = ""
    
    var body: some View {
        VStack { // parent container
            VStack { //krate name stack
                HStack {
                    VStack (alignment: .leading) {
                        
                        Text("KRATE NAME")
                            .font(.caption)
                            .fontWeight(.semibold)
                        TextField("Add krate name...", text: $krateName)
                            .fontWeight(.heavy)
                            .font(.title3)
                            .foregroundColor(Color.accentLightGray)

                            
                    }
                    .foregroundColor(Color.accentLightGray)
                    .padding(.horizontal)
                }
                Divider()
            }
            VStack { // krate description
                HStack {
                    VStack (alignment: .leading) {
                        
                        Text("KRATE DESCRIPTION")
                            .font(.caption)
                            .fontWeight(.semibold)
                        TextField("Add description...", text: $krateDescription)
                            .fontWeight(.heavy)
                            .font(.title3)
                            .foregroundColor(Color.accentLightGray)
                            .frame(height: 140)
                        Spacer()

                    }
                    .foregroundColor(Color.accentLightGray)
                    .padding(.horizontal)
                }
                Divider()
            }
            
        }
        .padding(.vertical, 4)
    }
}
struct createHeader: View {
    
    @State private var allFieldsCompleted = false
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack { // parent container
            HStack { //header
                Button { //button to dismiss view
                    //code
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Text("Cancel")
                        .fontWeight(.semibold)
                        .foregroundColor(.accentLightGray)
                        
                }
                .padding(.leading)
                
                Spacer()
                Text("New Krate")
                    .offset(x: -6)
                    .foregroundColor(Color.white)
                    .fontWeight(.heavy)
                Spacer()
                Button {
                    //code
                } label: {
                    Text("Save")
                        .foregroundColor(allFieldsCompleted ? Color.white : Color.accentLightGray)
                        .fontWeight(.semibold)

                }
                .padding(.trailing)
                
                Divider()
            }
            
        }
        .frame(height: 50)
        .padding(.vertical)
    }
}

#Preview {
    createKrateView()
}
