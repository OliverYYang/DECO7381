import SwiftUI

struct UserView: View {
    var body: some View {
        VStack {
            // 自定义顶部容器
            HStack {
                Button(action: {
                    // 返回按钮的动作，例如返回到上一个视图
                }) {
                    Image(systemName: "arrow.left")
                        .resizable()
                        .frame(width: 18, height: 18)
                        .foregroundColor(.white)
                }
                .padding(.leading) // 让返回按钮靠左
                
                Spacer()
                
                Text("User")
                    .font(.title3)
                    .foregroundColor(.white)
                    .bold() // 设置标题居中显示
                
                Spacer()
            }
            .padding() // 给顶部容器添加一些 padding
            .background(Color.black.opacity(0.8)) // 设置背景颜色为黑色并加一点透明度
            
            Spacer() // 占位符，将顶部容器与内容分隔开
            
            // 这里是其他内容，如你原先的Profile内容等
            VStack {
                // Profile 1: Child
                HStack {
                    Image("Ash") // Replace with the actual image name
                        .resizable()
                        .frame(width: 80, height: 80)
                        .clipShape(Circle())
                    
                    VStack(alignment: .leading) {
                        Text("Level:")
                            .font(.headline)
                        Text("Child")
                            .font(.subheadline)
                    }
                    
                    Spacer()
                    VStack {
                        Button(action: {
                            // Action for Set Daily Task
                        }) {
                            Text("Set Daily Task")
                                .padding()
                                .background(Color.black)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }
                        
                        Button(action: {
                            // Action for Clear Game Data
                        }) {
                            Text("Clear Game Data")
                                .padding()
                                .background(Color.black)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }
                    }
                }
                .padding()
                .background(Color.white)
                .cornerRadius(15)
                .shadow(radius: 5)
                .padding(.horizontal)

                // Profile 2: Parent
                HStack {
                    Image("Parent") // Replace with the actual image name
                        .resizable()
                        .frame(width: 80, height: 80)
                        .clipShape(Circle())
                    
                    VStack(alignment: .leading) {
                        Text("Level:")
                            .font(.headline)
                        Text("Parent")
                            .font(.subheadline)
                    }
                    
                    Spacer()
                    
                    VStack {
                        Button(action: {
                            // Action for Set Daily Task
                        }) {
                            Text("Set Daily Task")
                                .padding()
                                .background(Color.black)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }
                        
                        Button(action: {
                            // Action for Learning Situation
                        }) {
                            Text("Review situation")
                                .padding()
                                .background(Color.black)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                            
                        }

                        Button(action: {
                            // Action for Change Password
                        }) {
                            Text("Change PWS")
                                .padding()
                                .background(Color.black)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }
                        
                        Button(action: {
                            // Action for Delete Account
                        }) {
                            Text("DEL Account")
                                .padding()
                                .background(Color.black)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }
                    }
                }
                .padding()
                .background(Color.white)
                .cornerRadius(15)
                .shadow(radius: 5)
                .padding(.horizontal)

                Spacer()
                
                // Floating Action Button
                HStack {
                    Button(action: {
                        // Action for the floating button
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(.orange)
                            .padding()
                    }
                }
                .padding(.trailing)
                Spacer()
                
                // 底部导航栏
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
                        // 添加 NavigationLink，点击后进入 ScannerView
                        NavigationLink(destination: ScannerView(isFullScreenMode: true) { text in
                            // 处理从 ScannerView 返回的 OCR 结果
                            print("OCR 结果: \(text ?? "未识别到文本")")
                        }) {
                            Image("Scan")
                                .resizable()
                                .frame(width: 80, height: 80)
                                .foregroundColor(.white)
                        }
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
            .navigationBarHidden(true) // 隐藏原始导航栏
        }
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView()
    }
}

