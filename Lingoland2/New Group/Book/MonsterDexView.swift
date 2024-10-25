//
//  BookList.swift
//  Lingoland2
//
//  Created by 杨小洲 on 2024/10/13.
//

import SwiftUI

struct MonsterDexView: View {
    @Binding var defeatedMonsters: [Bool]  // 传递击败状态

    let monsterNames = ["Squirtle", "Charmander", "Bulbasaur"]

    var body: some View {
        VStack {
            Text("Switch your monster!")
                .font(.title)
                .bold()
                .padding()

            // 显示怪物的图鉴
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3), spacing: 20) {
                ForEach(0..<monsterNames.count, id: \.self) { index in
                    VStack {
                        Image(defeatedMonsters[index] ? monsterNames[index] : "\(monsterNames[index])_gray")
                            .resizable()
                            .frame(width: 70, height: 70)
                            .clipShape(Circle())
                        Text(monsterNames[index])
                            .font(.subheadline)
                    }
                    .padding()
                    .background(defeatedMonsters[index] ? Color.orange : Color.gray.opacity(0.2))
                    .cornerRadius(10)
                }
            }
            .padding()

            // 返回游戏按钮
            Button(action: {
                // 返回到游戏视图
            }) {
                Text("Back to Game")
                    .foregroundColor(.white)
                    .frame(width: 200, height: 40)
                    .background(Color.gray)
                    .cornerRadius(10)
                    .padding()
            }
        }
        .navigationBarTitle("MonsterDex", displayMode: .inline)
    }
}

struct MonsterDexView_Previews: PreviewProvider {
    static var previews: some View {
        MonsterDexView()
    }
}
