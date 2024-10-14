import SwiftUI

struct GameView1: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                
                
                VStack(spacing:3) {
                    
                    VStack(alignment: .leading, spacing: 10) {
                        HStack {
                            Image("Ash") // 替换为实际图片名称
                                .resizable()
                                .frame(width: 60, height: 60)
                                .clipShape(Circle())
                            VStack(alignment: .leading) {
                                Text("ID: Ash")
                                    .font(.headline)
                                    .foregroundColor(.white) // 使用白色字体
                                Text("Today's Mission: 10 / 10 words")
                                    .font(.subheadline)
                                    .foregroundColor(.white) // 使用白色字体
                            }
                            Spacer()
                            Text("Cost: 91")
                                .font(.subheadline)
                                .foregroundColor(.orange)
                                .padding(.trailing)
                        }
                    }
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
                    .padding(.horizontal)

                    // 当前怪物状态部分
                    VStack(spacing: 20) {
                        Text("Current monster in battle")
                            .font(.headline)
                            .foregroundColor(.white)

                        Text("Charmander")
                            .font(.title)
                            .foregroundColor(.orange)

                        Image("Charmander") // 替换为实际图片名称
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 100, height: 100)

                        // 怪物状态
                        VStack(alignment: .leading, spacing: 5) {
                            HStack {
                                Text("Lv 6: Exp: 5 / 10")
                                    .font(.subheadline)
                                    .foregroundColor(.white)
                                Spacer()
                                Button(action: {
                                    // 增加经验值的操作
                                }) {
                                    Text("Exp+1 by Cost 1")
                                        .font(.subheadline)
                                        .foregroundColor(.white)
                                        .padding(5)
                                        .background(Color.gray)
                                        .cornerRadius(8)
                                }
                            }

                            ProgressView(value: 0.5)
                                .progressViewStyle(LinearProgressViewStyle(tint: Color.orange))

                            Text("Atk: 4  Hp: 103 (+3)")
                                .font(.subheadline)
                                .foregroundColor(.white)
                        }
                        .padding()
                        .background(Color.black) // 怪物状态容器背景为黑色
                        .cornerRadius(10)
                    }
                    .padding(.horizontal)

                    // 进化按钮
                    Button(action: {
                        // 进化操作
                    }) {
                        Text("Level up to 10 to Evolve")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.orange)
                            .cornerRadius(10)
                    }
                    .padding(.horizontal)

                    // 切换怪物按钮
                    Button(action: {
                        // 切换怪物操作
                    }) {
                        HStack {
                            Image(systemName: "gamecontroller.fill")
                                .foregroundColor(.white)
                            Text("Switch monster for battle")
                                .font(.headline)
                                .foregroundColor(.white)
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.gray)
                        .cornerRadius(10)
                    }
                    .padding(.horizontal)
                }
                .padding() // 容器内部边距
                .background(Color.black) // 整个容器背景为黑色
                .cornerRadius(15)
                .padding(.horizontal)

                Spacer()

                // 底部导航栏保持不变
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
                    // 修改过---------------------------
                    VStack {
                        NavigationLink(destination: ScannerView(isFullScreenMode: true) { text in
                                // 处理 OCR 结果的逻辑，可以在这里打印或处理识别到的文本
                                print("OCR 结果: \(text ?? "未识别到文本")")
                            }) {
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
            .navigationTitle("Game")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct GameView1_Previews: PreviewProvider {
    static var previews: some View {
        GameView1()
    }
}

