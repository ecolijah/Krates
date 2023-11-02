import SwiftUI

// ViewModel that holds the shared state and business logic
class KrateViewModel: ObservableObject {
    @Published var krateName: String = ""
    @Published var krateDescription: String = ""
    @Published var showAlert: Bool = false
    @Published var alertMessage: String = ""
    // Method to handle the save action
    func saveKrate() {
        if krateName.isEmpty || krateDescription.isEmpty {
            // If any field is empty, show an error alert
            alertMessage = "Please fill in all fields."
            showAlert = true
            print("DEBUG: pls fill in all fields")
        } else {
            // If all fields are filled, show a success message and perform the save operation
            alertMessage = "Krate added successfully!"
            showAlert = true
            print("DEBUG: nice")

            // Insert your code here to actually save the krate
        }
    }
}

// Main view that creates an instance of the ViewModel
struct CreateKrateView: View {
    @StateObject var viewModel = KrateViewModel()

    var body: some View {
        VStack(spacing: 0) { // Parent container
            CreateHeaderView(viewModel: viewModel)
            CreateInfoView(viewModel: viewModel)
            Spacer()
        }
        .background(Color.background)
    }
}

// View for creating the header
struct CreateHeaderView: View {
    @ObservedObject var viewModel: KrateViewModel
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack { // Parent container
            HStack { // Header
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
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
                
                Button(action: {
                    // Save action
                    viewModel.saveKrate()
                    if !viewModel.krateName.isEmpty || !viewModel.krateDescription.isEmpty {
                        presentationMode.wrappedValue.dismiss()

                    }

                }) {
                    Text("Save")
                        .foregroundColor(Color.accentLightGray)
                        .fontWeight(.semibold)
                }
                .padding(.trailing)
                .alert(isPresented: $viewModel.showAlert) {
                                    Alert(title: Text("Krate Status"), message: Text(viewModel.alertMessage), dismissButton: .default(Text("OK")))
                                }
            }
        }
        .frame(height: 50)
        .padding(.vertical)
    }
}

// View for creating the info fields
struct CreateInfoView: View {
    @ObservedObject var viewModel: KrateViewModel

    var body: some View {
        VStack { // Parent container
            VStack { // Krate name stack
                HStack {
                    VStack(alignment: .leading) {
                        Text("KRATE NAME")
                            .font(.caption)
                            .fontWeight(.semibold)
                        TextField("Add krate name...", text: $viewModel.krateName)
                            .fontWeight(.heavy)
                            .font(.title3)
                            .foregroundColor(Color.accentLightGray)
                    }
                    .foregroundColor(Color.accentLightGray)
                    .padding(.horizontal)
                }
                Divider()
            }
            
            VStack { // Krate description
                HStack {
                    VStack(alignment: .leading) {
                        Text("KRATE DESCRIPTION")
                            .font(.caption)
                            .fontWeight(.semibold)
                        TextField("Add description...", text: $viewModel.krateDescription)
                            .fontWeight(.heavy)
                            .font(.title3)
                            .foregroundColor(Color.accentLightGray)
                            .frame(height: 140)
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

// Preview for the main view
struct CreateKrateView_Previews: PreviewProvider {
    static var previews: some View {
        CreateKrateView()
    }
}
