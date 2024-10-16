import SwiftUI
// 顶部搜索栏组件
struct SearchBarView: View {
    @Binding var searchText: String
    
    var body: some View {
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
    }
}

// 用户信息卡片组件
struct UserInfoCardView: View {
    var body: some View {
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
    }
}

// 底部导航栏组件
struct BottomNavBarView: View {
    var body: some View {
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
                NavigationLink(destination: ScannerContentView()) {
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

            // 修改为 NavigationLink 跳转到 SettingView
            VStack {
                NavigationLink(destination: SettingView()) { // 跳转到 SettingView
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
        .background(Color.black.opacity(0.8))
    }
}

// 主界面
struct ContentView: View {
    @State private var searchText: String = "" // 声明搜索文本
    @State private var defeatedMonsters: [Bool] = [false, false, false] // 定义怪物击败状态
    
    var body: some View {
        NavigationView {
            VStack {
                // 顶部搜索栏
                SearchBarView(searchText: $searchText)
                
                // 用户信息和任务
                VStack(alignment: .leading, spacing: 10) {
                    UserInfoCardView()
                    Spacer()
                    
                    // 战斗和怪物部分
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
                        
                        // 小火龙图片
                        Image("Charmander") // 替换为实际图片名称
                            .resizable()
                            .scaledToFit()
                            .frame(width: 120, height: 120)
                            .offset(y: -100)
                    }
                    
                    // 重置按钮
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
                .frame(maxWidth: .infinity, minHeight: 450)
                .background(Color.black.opacity(0.8))
                .cornerRadius(10)
                .padding()
                
                Spacer()
                
                // 词汇和怪物管理部分
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

                Spacer()
                
                // 底部导航栏
                BottomNavBarView()
            }
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                if let savedMonsters = UserDefaults.standard.array(forKey: "defeatedMonsters") as? [Bool] {
                    defeatedMonsters = savedMonsters
                }
            }
        }
    }
    
    // 重置函数
    func resetDefeatedMonsters() {
        UserDefaults.standard.removeObject(forKey: "defeatedMonsters")
        defeatedMonsters = [false, false, false]
        UserDefaults.standard.set(defeatedMonsters, forKey: "defeatedMonsters")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

