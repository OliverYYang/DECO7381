import SwiftUI

struct MonsterDexView: View {
    @Binding var defeatedMonsters: [Bool]  // 绑定击败状态

    let monsterNames = ["Squirtle", "Charmander", "Bulbasaur"]

    var body: some View {
        VStack {
            Text("MonsterDex")
                .font(.title)
                .bold()
                .padding()

            // 显示怪物图鉴
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3), spacing: 20) {
                ForEach(0..<monsterNames.count, id: \.self) { index in
                    VStack {
                        // 只有击败的怪物才显示图片
                        if defeatedMonsters[index] {
                            Image(monsterNames[index])
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 70, height: 70)
                                .clipShape(Circle())
                        } else {
                            // 如果没有击败怪物，可以显示一个占位符，或者直接不显示
                            Color.clear.frame(width: 70, height: 70) // 占位
                        }

                        // 显示怪物名字
                        Text(monsterNames[index])
                            .font(.subheadline)
                    }
                    .padding()
                    .background(defeatedMonsters[index] ? Color.orange : Color.gray.opacity(0.2)) // 根据状态改变背景颜色
                    .cornerRadius(10)
                }
            }
            .padding()
        }
        .onAppear {
            // 强制重新从 UserDefaults 加载最新的状态
            if let savedMonsters = UserDefaults.standard.array(forKey: "defeatedMonsters") as? [Bool] {
                defeatedMonsters = savedMonsters  // 刷新UI显示最新状态
                print("Loaded defeatedMonsters from UserDefaults in MonsterDexView: \(defeatedMonsters)")
            }
        }
    }
}

struct MonsterDexView_Previews: PreviewProvider {
    @State static var defeatedMonsters = [false, false, false]
    static var previews: some View {
        MonsterDexView(defeatedMonsters: $defeatedMonsters)
    }
}
