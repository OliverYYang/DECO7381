import SwiftUI

struct ContentView: View {
    @State private var searchText: String = "" // 声明搜索文本
    @State private var defeatedMonsters: [Bool] = [false, false, false] // 定义怪物击败状态
    
    var body: some View {
        NavigationView {
            VStack {
                // 顶部搜索栏容器
                HStack {
                    TextField("Search...", text: $searchText)
                        .padding(.leading, 10)
                    NavigationLink(destination: VocabularyView(wordToTranslate: searchText)) {
                        Image(systemName: "magnifyingglass")
                            .padding(.trailing, 10)
                    }
                }
                .frame(height: 40)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(25)
                .padding(.horizontal)

                // 个人信息和任务部分
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Image("Ash") // 替换为实际图片名称
                            .resizable()
                            .frame(width: 60, height: 60)
                            .clipShape(Circle())
                        VStack(alignment: .leading) {
                            Text("ID: Ash")
                                .font(.headline)
                            Text("Today's Mission:")
                            Text("8/10")
                                .font(.subheadline)
                        }
                        .foregroundColor(.white)
                        Spacer()
                        Text("Cost: 90")
                            .foregroundColor(.orange)
                            .font(.subheadline)
                            .padding(.trailing)
                    }

                    Spacer()

                    // 使用 ZStack 确保图片在橘色按钮的上层
                    ZStack {
                        NavigationLink(destination: GameView()) {
                            Text("Master!                                      Let's Catch                               Squirtle!")
                                .font(.title2)
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: 400, minHeight: 180)
                                .background(Color.orange)
                                .cornerRadius(8)
                        }

                        // 小火龙图片，确保其在按钮上方
                        VStack {
                            Image("Charmander") // 替换为实际图片名称
                                .resizable()
                                .scaledToFit()
                                .frame(width: 120, height: 120)
                                .offset(y: -100)
                        }
                    }

                    Button(action: {
                        resetDefeatedMonsters()  // 调用重置函数
                    }) {
                        Text("Reset Monster Defeat State")
                            .foregroundColor(.red)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.red, lineWidth: 2)
                            )
                    }

                    Spacer()

                    // 选择目标按钮
                    NavigationLink(destination: GameView3()) {
                        Text("Select your Target")
                            .foregroundColor(.black)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.white)
                            .cornerRadius(8)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.gray, lineWidth: 1)
                            )
                    }
                }
                .padding()
                .frame(maxWidth: .infinity, minHeight: 400)
                .background(Color.black.opacity(0.8))
                .cornerRadius(10)
                .padding()

                Spacer() // 让"Manage"部分往下移动
                
                // 管理词汇与怪物部分
                HStack {
                    NavigationLink(destination: WordView()) {
                        VStack {
                            Image("Book")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 85, height: 85)
                            Text("Manage my Vocabulary")
                                .foregroundColor(.white)
                                .font(.footnote)
                        }
                    }
                    .frame(width: 150, height: 120)
                    .background(Color.black.opacity(0.7))
                    .cornerRadius(10)
                    .padding()

                    NavigationLink(destination: MonsterDexView(defeatedMonsters: $defeatedMonsters)) {
                        VStack {
                            Image("Pokeball")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 120, height: 85)
                            Text("Manage my Monster")
                                .foregroundColor(.white)
                                .font(.footnote)
                        }
                    }
                    .frame(width: 150, height: 120)
                    .background(Color.black.opacity(0.7))
                    .cornerRadius(10)
                    .padding()
                }

                Spacer() // 这个Spacer将底部导航栏往下推
                
                // 底部导航栏
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
                .background(Color.black.opacity(0.8))
            }
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                if let savedMonsters = UserDefaults.standard.array(forKey: "defeatedMonsters") as? [Bool] {
                    defeatedMonsters = savedMonsters
                    print("Loaded defeatedMonsters from UserDefaults in ContentView: \(defeatedMonsters)")
                }
            }
        }
    }
    
    // 重置函数
    func resetDefeatedMonsters() {
        UserDefaults.standard.removeObject(forKey: "defeatedMonsters")
        defeatedMonsters = [false, false, false]
        UserDefaults.standard.set(defeatedMonsters, forKey: "defeatedMonsters")
        print("Defeated monsters state has been reset to: \(defeatedMonsters)")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
