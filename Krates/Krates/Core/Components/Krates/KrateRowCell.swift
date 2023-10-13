import SwiftUI

struct KrateRowCell: View {
    @Binding var menuShowing: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .center) {
                NavigationLink(
                    destination: KrateObjectView()
                        .navigationBarBackButtonHidden(false)
                        .onAppear { // This will toggle menuShowing when KrateObjectView appears
                            menuShowing.toggle()
                        }
                        .onDisappear(){
                            menuShowing.toggle()
                        }
                ) {
                    Text("feeling lost in your 20's")
                        .foregroundColor(.whiteFont)
                        .font(.title3)
                        .fontWeight(.heavy)
                        .padding(.horizontal, 16)
                        .multilineTextAlignment(.leading)
                }
                
                
                NavigationLink(
                    destination: ProfileVisitingView()
                        .navigationBarBackButtonHidden(false)
                        .onAppear { // This will toggle menuShowing when KrateObjectView appears
                            menuShowing.toggle()
                        }
                        .onDisappear(){
                            menuShowing.toggle()
                        }
                ) {
                    HStack {
                        Text("dreadpirate")
                            .padding(.horizontal, -12)
                            .foregroundColor(.accentLightGray) // Replace with your custom color
                            .fontWeight(.heavy)
                            .font(.callout)
                            .padding()
                        
                        Circle()
                            .frame(width: 40, height: 40)
                            .foregroundColor(.blue)
                    }
                }
                
                
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
            
            NavigationLink(destination: KrateObjectView()) {
                Text("this is a list of “coming of age” type albums but for  those in their mid 20s something not knowing where their lives going. feeling lost, no hope that  things will change, feeling so so many things.")
                    .foregroundColor(.accentLightGray) // Replace with your custom color
                    .padding(.vertical, 8)
                    .padding(.horizontal, 16)
                    .font(.caption)
                    .fontWeight(.heavy)
                    .multilineTextAlignment(.leading)
            }
            
            Rectangle()
                .frame(height: 2)
                .foregroundColor(.divider) // Replace with your custom color
                .padding(.horizontal, 16)
                .cornerRadius(2)
        }
        .padding(.vertical, 8)
        .background(Color.background) // Replace with your custom color
        .edgesIgnoringSafeArea(.all)
    }
}

struct KrateRowCell_Previews: PreviewProvider {
    static var previews: some View {
        KrateRowCell(menuShowing: .constant(false))
    }
}

