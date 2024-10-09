import SwiftUI

struct GameView: View {
    @State private var monsterHP = 100
    @State private var playerCost = 0
    @State private var playerEXP = 0
    @State private var playerHP = 100
    @State private var charmanderLevel = 1
    @State private var maxHP = 100
    @State private var currentQuestion: String = ""
    @State private var options: [String] = []  // 动态获取的选项
    @State private var feedbackMessage: String = ""
    @State private var completedWords = 0  // 用来保存已完成的题目数量
    let totalWords = 10  // 今日任务的总题目数量
    @State private var isMissionCompleted = false  // 防止重复增加 Cost
    @State private var monsterImage = "Squirtle"
    @State private var monsterImages = ["Squirtle", "Charmander", "Bulbasaur"]
    @State private var currentMonsterIndex = 0
    @State private var correctTranslation: String = ""  // 添加一个状态来保存正确的翻译


    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                // 头像和任务信息部分
                HStack(alignment: .top) {
                    Image("Ash")
                        .resizable()
                        .frame(width: 60, height: 60)
                        .clipShape(Circle())
                    
                    VStack(alignment: .leading, spacing: 5) {
                        Text("ID: Ash")
                            .font(.headline)
                        // 动态显示已完成的单词数
                        Text("Today's Mission: \(completedWords) / \(totalWords) words")
                            .font(.subheadline)
                        HStack {
                            Text("Cost: \(playerCost)")
                                .font(.subheadline)
                                .foregroundColor(.orange)
                        }
                    }
                    Spacer()
                }
                .padding(.horizontal)
                
                // 怪物与问题区域
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.white)
                        .shadow(radius: 5)
                    
                    HStack {
                        Image(monsterImage)
                            .resizable()
                            .frame(width: 100, height: 100)
                            .offset(x: -15, y: 0)
                        
                        VStack(alignment: .leading, spacing: 5) {
                            // 显示怪物HP
                            HStack {
                                Text("HP: \(monsterHP) / 100")
                                    .font(.subheadline)
                                Spacer()
                                
                                // HP进度条
                                HStack(spacing: 0) {
                                    Capsule()
                                        .fill(Color.orange)
                                        .frame(width: CGFloat(monsterHP) / 100 * 60, height: 4)
                                    Capsule()
                                        .fill(Color.black)
                                        .frame(width: 60 - (CGFloat(monsterHP) / 100 * 60), height: 4)
                                }
                            }
                            Text("Which one is")
                                .font(.title3)
                            Text(currentQuestion)
                                .font(.largeTitle)
                                .bold()
                        }
                        .padding(.vertical)
                        .padding(.leading, 10)
                    }
                    .padding(.horizontal, 20)
                }
                .padding(.horizontal)

                Divider().padding(.vertical)

                // 选项部分
                VStack(spacing: 10) {
                    ForEach(0..<2) { row in
                        HStack(spacing: 10) {
                            ForEach(0..<2) { column in
                                let index = row * 2 + column
                                if index < options.count {
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(Color.orange)
                                        .frame(width: 150, height: 70)
                                        .overlay(
                                            Text(options[index])
                                                .font(.title3)
                                                .foregroundColor(.white)
                                        )
                                        .onTapGesture {
                                            handleOptionTap(selectedOption: options[index])
                                        }
                                }
                            }
                        }
                    }
                }
                .padding(.horizontal)

                // 显示反馈消息
                Text(feedbackMessage)
                    .font(.headline)
                    .foregroundColor(.red)
                    .padding()
                
                // Charmander 区域
                ZStack {
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color.white)
                        .shadow(radius: 5)
                    
                    HStack {
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Charmander Lv \(charmanderLevel):")
                                .font(.headline)
                            HStack {
                                Text("Exp: \(playerEXP) / 10")
                            }
                            .font(.subheadline)
                            
                            // Exp 进度条
                            HStack(spacing: 5) {
                                Capsule()
                                    .fill(Color.orange)
                                    .frame(width: CGFloat(playerEXP) / 10 * 100, height: 5)
                                Capsule()
                                    .fill(Color.black)
                                    .frame(width: CGFloat(100 - (CGFloat(playerEXP) / 10 * 100)), height: 5)
                            }
                            
                            Text("HP: \(playerHP) / \(maxHP)")
                                .font(.subheadline)
                            
                            // HP 进度条
                            HStack(spacing: 5) {
                                Capsule()
                                    .fill(Color.orange)
                                    .frame(width: CGFloat(playerHP) / CGFloat(maxHP) * 100, height: 5)
                                Capsule()
                                    .fill(Color.black)
                                    .frame(width: CGFloat(100 - (CGFloat(playerHP) / CGFloat(maxHP) * 100)), height: 5)
                            }
                        }
                        
                        Spacer()
                        
                        Image("Charmander")
                            .resizable()
                            .frame(width: 100, height: 100)
                    }
                    .padding(.horizontal, 20)
                }
                .padding(.horizontal)
                
                // 操作按钮部分
                HStack(spacing: 10) {
                    // Heal 按钮
                    Button(action: {
                        if playerCost >= 5 {
                            playerCost -= 5
                            playerHP = min(playerHP + 5, maxHP)
                        }
                    }) {
                        VStack {
                            Image(systemName: "cross.case.fill")
                                .resizable()
                                .frame(width: 30, height: 30)
                            Text("Heal 5 Cost 5")
                                .font(.footnote)
                        }
                        .padding()
                        .frame(width: 120, height: 100)
                        .background(Color.gray)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                    }
                    
                    // Exp 按钮
                    Button(action: {
                        if playerCost >= 5 {
                            playerCost -= 5
                            playerEXP += 5
                            if playerEXP >= 10 {
                                playerEXP = 0
                                charmanderLevel += 1
                                maxHP += 5
                                playerHP = maxHP
                            }
                        }
                    }) {
                        VStack {
                            Image(systemName: "star.fill")
                                .resizable()
                                .frame(width: 30, height: 30)
                            Text("Exp 5 Cost 5")
                                .font(.footnote)
                        }
                        .padding()
                        .frame(width: 120, height: 100)
                        .background(Color.gray)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                    }
                }
                .padding(.horizontal)
                
                // 显示玩家当前的Cost
                Text("Cost: \(playerCost)")
                    .font(.headline)
            }
            .onAppear {
                loadNewQuestion()  // 视图加载时自动调用问题生成函数
            }
            .navigationBarHidden(true)
        }
    }

    // 加载新问题
    func loadNewQuestion() {
        generateNewQuestion { question, answers, correctAnswer in
            currentQuestion = question
            options = answers
            correctTranslation = correctAnswer  // 直接赋值为从数据库中获取的正确答案
        }
    }


    // 点击选项后的处理逻辑
    func handleOptionTap(selectedOption: String) {
        // 判断答案是否正确，直接比较用户点击的选项和正确的翻译
        if selectedOption == correctTranslation {
            feedbackMessage = "正确！"
            monsterHP -= 5
            playerCost += 1
            completedWords += 1
            if monsterHP <= 0 {
                loadNewMonster()
            }
            if completedWords == totalWords && !isMissionCompleted {
                playerCost += 10  // 完成任务后增加 10 Cost
                isMissionCompleted = true
            }
            loadNewQuestion()
        } else {
            feedbackMessage = "错误，请再试一次。"
            playerHP -= 5
            if playerHP < 0 {
                playerHP = 0  // 防止HP变成负数
            }
        }
    }
    
    // 加载新怪物
    func loadNewMonster() {
        monsterHP = 100
        currentMonsterIndex = (currentMonsterIndex + 1) % monsterImages.count
        monsterImage = monsterImages[currentMonsterIndex]
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}

