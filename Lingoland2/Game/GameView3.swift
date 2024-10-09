import SwiftUI

struct GameView3: View {
    @State private var selectedTarget: String = "Bulbasaur"

    var body: some View {
        VStack {

            HStack {
                Button(action: {
                    
                }) {
                    Image(systemName: "arrow.left")
                        .resizable()
                        .frame(width: 18, height: 18)
                        .foregroundColor(.white)
                }
                .padding(.leading) // 让返回按钮靠左

                Spacer()

                Text("Game")
                    .font(.title3)
                    .foregroundColor(.white)
                    .bold() // 设置标题居中显示

                Spacer()
            }
            .padding() // 给顶部容器添加一些 padding
            .background(Color.black.opacity(0.8)) // 黑色背景

            // 任务信息和按钮部分的黑色背景容器
            VStack {
                // 任务信息
                VStack(alignment: .leading) {
                    HStack {
                        Image("Ash") // Replace with actual image name
                            .resizable()
                            .frame(width: 60, height: 60)
                            .clipShape(Circle())
                        VStack(alignment: .leading) {
                            Text("ID: 傻东西")
                                .font(.headline)
                                .foregroundColor(.white)
                            Text("Today's Mission: 10 / 10 words")
                                .font(.subheadline)
                                .foregroundColor(.white)
                        }
                        Spacer()
                        Text("Cost: 91")
                            .foregroundColor(.orange)
                            .font(.headline)
                    }
                    .padding()
                    .padding(.horizontal)
                }
                
                Text("Select your Target!(examples)")
                    .font(.title2)
                    .foregroundColor(.white)
                    .padding(.top)
                // 目标选择网格布局
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                    ForEach(["Squirtle", "Bulbasaur", "Pichu"], id: \.self) { target in
                        Button(action: {
                            selectedTarget = target // 更新选择的目标
                        }) {
                            VStack {
                                Image(target) // Replace with actual image name
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 50, height: 50)
                                    .padding()
                                    .background(selectedTarget == target ? Color.orange : Color.white)
                                    .cornerRadius(12)
                                Text(target)
                                    .font(.headline)
                                    .foregroundColor(.white)
                            }
                        }
                    }
                }
                .padding()

                Spacer()

                // 按钮容器
                VStack(spacing: 15) {
                    Button(action: {
                        // Continue to Catch Bulbasaur
                    }) {
                        Text("Continue to Catch \(selectedTarget)")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.orange)
                            .cornerRadius(8)
                    }
                    .padding(.horizontal)
                    .frame(maxWidth: 350)

                    Button(action: {
                        // Back to Homepage
                    }) {
                        Text("Back to Homepage")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.gray)
                            .cornerRadius(8)
                    }
                    .padding(.horizontal)
                    .frame(maxWidth: 350)
                }
                .padding()
            }
            .background(Color.black.opacity(0.8)) // 黑色背景容器
            .cornerRadius(15)
            .padding(.horizontal)

            Spacer()

            // 底部导航栏（保持不变）
            HStack {
                Spacer()
                VStack {
                    Image(systemName: "person.circle")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .foregroundColor(.white)
                    Text("User")
                        .font(.footnote)
                        .foregroundColor(.white)
                }
                Spacer()

                VStack {
                    NavigationLink(destination: ScannerView()) {
                        Image("Scan")
                            .resizable()
                            .frame(width: 80, height: 80)
                            .foregroundColor(.white)
                    }
                    Text("Scan")
                        .font(.footnote)
                        .foregroundColor(.white)
                }
                Spacer()
                VStack {
                    Image(systemName: "gear")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .foregroundColor(.white)
                    Text("Setting")
                        .font(.footnote)
                        .foregroundColor(.white)
                }
                Spacer()
            }
            .padding()
            .background(Color.black.opacity(0.8)) // 底部导航栏保持不变
        }
        .navigationBarHidden(true) // 隐藏原始导航栏
    }
}

struct GameView3_Previews: PreviewProvider {
    static var previews: some View {
        GameView3()
    }
}

