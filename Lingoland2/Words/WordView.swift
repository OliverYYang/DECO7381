import SwiftUI

struct Word: Identifiable {
    var id: UUID = UUID()
    var word: String
    var translation: String  // Added translation field
}

struct WordView: View {
    @ObservedObject var viewModel = WordViewModel() // Bind the view model
    @State private var sortOrder = 1  // State for sorting order
    @State private var showAlert = false // State to control the alert display
    @Environment(\.presentationMode) var presentationMode // Used to navigate back to the previous view

    var body: some View {
        VStack {
            // Custom top container
            HStack {
                Button(action: {
                    // Navigate back to the previous view
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "arrow.left")
                        .resizable()
                        .frame(width: 18, height: 18)
                        .foregroundColor(.white)
                }
                .padding(.leading) // Align the back button to the left
                
                Spacer()
                
                Text("Vocabulary")
                    .font(.title3)
                    .foregroundColor(.white)
                    .bold() // Center the title text
                
                Spacer()
            }
            .padding() // Add padding to the top container
            .background(Color.black.opacity(0.8)) // Set the background color to black with some opacity
            
            HStack {
                Text("New words:")
                    .font(.title3)
                    .bold()
                Spacer()
                Picker("Sort", selection: $sortOrder) {  // Bind picker state
                    Text("A to Z").tag(1)
                    Text("Z to A").tag(2)
                }
                .pickerStyle(MenuPickerStyle())
                .onChange(of: sortOrder, perform: { _ in
                    viewModel.sortWords(order: sortOrder)  // Call the sort method from the view model
                })
            }
            .padding()

            if viewModel.isLoading {
                ProgressView("Loading words...")
                    .padding()
            } else {
                List(viewModel.wordsArray) { word in
                    HStack {
                        Text(word.word)
                        Spacer()
                        
                        // Place the plus button on the far right
                        Button(action: {
                            viewModel.addToAnotherTable(word: word)
                            print("Word \(word.word) added to game successfully!")
                            showAlert = true // Trigger alert display
                        }) {
                            Image(systemName: "plus.circle")
                                .foregroundColor(.blue)
                        }
                    }
                    .padding(.vertical, 8)  // Add vertical padding to separate word items
                }
            }
        }
        .navigationBarHidden(true) // Hide the default navigation bar
        .onAppear {
            viewModel.fetchWords()
        }
        // Add alert popup
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Success"),
                message: Text("Word added to game successfully!"),
                dismissButton: .default(Text("OK"))
            )
        }
    }
}

struct WordView_previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            WordView()
        }
    }
}

