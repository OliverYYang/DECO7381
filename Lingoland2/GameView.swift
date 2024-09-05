import SwiftUI

struct GameView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                // Top navigation bar with centered title
                HStack {
                    Button(action: {
                        // Back button action
                    }) {
                        Image(systemName: "arrow.left")
                            .padding()
                            .offset(x:5, y:10)

                    }-
                    Spacer()
                }
                .background(Color.gray.opacity(0.2))
                
                // Profile and Mission Section
                HStack(alignment: .top) {
                    Image("Ash") // Replace with actual image name
                        .resizable()
                        .frame(width: 60, height: 60)
                        .clipShape(Circle())
                    
                    VStack(alignment: .leading, spacing: 5) {
                        Text("ID: 傻东西")
                            .font(.headline)
                        Text("Today's Mission: 8 / 10 words")
                            .font(.subheadline)
                        Text("Cost: 91 +1")
                            .font(.subheadline)
                            .foregroundColor(.orange)
                            .padding(.trailing)
                    }
                    Spacer()
                }
                .padding(.horizontal)
                
                // HP and Question section with Squirtle image
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.white)
                        .shadow(radius: 5)
                    
                    HStack {
                        Image("Squirtle") // Replace with the actual image name
                            .resizable()
                            .frame(width: 100, height: 100)
                            .offset(x: -15, y: 0)
                        
                        VStack(alignment: .leading, spacing: 5) {
                            HStack {
                                Text("HP: 96 /100")
                                    .font(.subheadline)
                                Spacer()
                                // HP bar
                                HStack(spacing: 0) {
                                    Capsule()
                                        .fill(Color.orange)
                                        .frame(width: 60, height: 4)
                                    Capsule()
                                        .fill(Color.black)
                                        .frame(width: 20, height: 4)
                                }
                            }
                            Text("Which one is")
                                .font(.title3)
                            Text("Computer ?")
                                .font(.largeTitle)
                                .bold()
                        }
                        .padding(.vertical)
                        .padding(.leading, 10) // Add some padding to separate text from image
                    }
                    .padding(.horizontal, 20)
                }
                .padding(.horizontal)
                
                // Options Section
                VStack(spacing: 10) {
                    HStack(spacing: 10) {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.orange)
                            .frame(width: 150, height:90 )
                            .overlay(
                                Image("computer_image") // Replace with actual image name
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 60, height: 60)
                            )
                        
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.black)
                            .frame(width: 150, height: 90)
                            .overlay(
                                Image("car_image") // Replace with actual image name
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 60, height: 60)
                            )
                    }
                    HStack(spacing: 10) {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.green)
                            .frame(width: 150, height: 90)
                            .overlay(
                                Image("car_image") // Replace with actual image name
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 150, height: 60)
                            )
                        
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.pink)
                            .frame(width: 150, height: 90)
                            .overlay(
                                Image("car_image") // Replace with actual image name
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 60, height: 60)
                            )
                    }
                }
                .padding(.horizontal)
                
                Divider().padding(.vertical)
                
                // Charmander Card
                VStack(alignment: .leading) {
                    HStack {
                        Text("Charmander Lv 6:")
                            .font(.headline)
                        Spacer()
                        Text("HP: 95 /103")
                            .font(.subheadline)
                        Image("Charmander")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 55, height: 55)
                    }
                    .padding(.bottom, 5)
                    
                    HStack {
                        Text("Exp: 5 / 10  Atk:4  HP:+3")
                            .font(.subheadline)
                        Spacer()
                    }
                    .padding(.bottom, 10)
                    
                    HStack {
                        Button(action: {
                            // Heal action
                        }) {
                            HStack {
                                Image(systemName: "cross.case.fill")
                                    .foregroundColor(.white)
                                Text("Heal 5 Cost 5")
                                    .foregroundColor(.white)
                            }
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.gray)
                            .cornerRadius(8)
                        }
                        Spacer().frame(width: 10)
                        Button(action: {
                            // Exp action
                        }) {
                            HStack {
                                Image(systemName: "star.fill")
                                    .foregroundColor(.white)
                                Text("Exp 5 Cost 5")
                                    .foregroundColor(.white)
                            }
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.gray)
                            .cornerRadius(8)
                        }
                    }
                }
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                .shadow(radius: 5)
                .padding(.horizontal)
                
                // Bottom Navigation
                HStack {
                    Spacer()
                    VStack {
                        Image(systemName: "person.circle")
                            .resizable()
                            .frame(width: 40, height: 40)
                        Text("User")
                            .font(.footnote)
                    }
                    Spacer()
                    VStack {
                        Image("Scan") // Replace with the actual scan icon image name
                            .resizable()
                            .frame(width: 80, height: 80)
                        Text("Scan")
                            .font(.footnote)
                    }
                    Spacer()
                    VStack {
                        Image(systemName: "gear")
                            .resizable()
                            .frame(width: 40, height: 40)
                        Text("Setting")
                            .font(.footnote)
                    }
                    Spacer()
                }
                .padding()
                .background(Color.gray.opacity(0.1))
            }
            .navigationBarHidden(true)
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}

