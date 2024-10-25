import SwiftUI

struct SettingView: View {
    @State private var delayTime: Int = 3 // Default value for delay time
    @Environment(\.presentationMode) var presentationMode // Used to navigate back to the previous view
    
    var body: some View {
        VStack {
            // Top navigation bar
            HStack {
                Button(action: {
                    // Go back to the previous view
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "arrow.left")
                        .resizable()
                        .frame(width: 18, height: 18)
                        .foregroundColor(.white)
                        .padding(.leading) // Align the back button to the left
                }
                
                Spacer()
                
                Text("Setting")
                    .font(.title3)
                    .foregroundColor(.white)
                    .bold()
                
                Spacer()
            }
            .padding()
            .background(Color.black.opacity(0.8))
            
            // Central black container that holds all settings content
            VStack(spacing: 20) {
                // Security warning section
                VStack(alignment: .leading, spacing: 10) {
                    Text("Security Warning")
                        .font(.headline)
                        .foregroundColor(.white)
                    
                    Text("Please note: Please do not use this function in dangerous environments!")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.white)
                        .cornerRadius(8)
                }
                .padding(.horizontal)
                
                Spacer()
                
                // Delay recognition time setting
                VStack(alignment: .leading, spacing: 10) {
                    Text("Delayed Recognition Time")
                        .font(.headline)
                        .foregroundColor(.white)
                    
                    HStack {
                        Stepper("\(delayTime)", value: $delayTime, in: 1...10)
                            .labelsHidden()
                            .frame(width: 100)
                            .foregroundColor(.white)
                        
                        Text("Second")
                            .foregroundColor(.white)
                    }
                }
                .padding(.horizontal)
                
                Spacer()
                
                // Clear game data button
                Button(action: {
                    // Action for clearing game data
                }) {
                    Text("Clean Game Data")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.gray)
                        .cornerRadius(8)
                }
                .padding(.horizontal)
            }
            .padding()
            .background(Color.black.opacity(0.8)) // Set black background for the container
            .cornerRadius(15)
            .padding(.horizontal)
            
            Spacer()
            
            // Bottom navigation bar
            HStack {
                Spacer()
                VStack {
                    NavigationLink(destination: UserView()) {
                        Image(systemName: "person.circle")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .foregroundColor(.white)
                    }
                    Text("User")
                        .font(.footnote)
                        .foregroundColor(.white)
                }
                Spacer()

                Spacer()

                VStack {
                    NavigationLink(destination: SettingView()) {
                        Image(systemName: "gear")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .foregroundColor(.white)
                    }
                    Text("Setting")
                        .font(.footnote)
                        .foregroundColor(.white)
                }
                Spacer()
            }
            .padding()
            .background(Color.black.opacity(0.8)) // Bottom navigation bar remains unchanged
        }
        .navigationBarHidden(true) // Hide the original navigation bar
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}

