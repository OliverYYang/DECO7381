import SwiftUI

struct SettingView: View {
    @State private var delayTime: Int = 3 // 延迟时间的默认值
    @Environment(\.presentationMode) var presentationMode // 用于返回上一视图
    
    var body: some View {
        VStack {
            // 顶部导航栏
            HStack {
                Button(action: {
                    // 返回上一个视图
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "arrow.left")
                        .resizable()
                        .frame(width: 18, height: 18)
                        .foregroundColor(.white)
                        .padding(.leading) // 让返回按钮靠左
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
            
            // 中间的黑色容器，包含所有设置内容
            VStack(spacing: 20) {
                // 安全警告部分
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
                
                // 延迟识别时间设置
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
                
                // 清除游戏数据按钮
                Button(action: {
                    // 清除数据按钮的动作
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
            .background(Color.black.opacity(0.8)) // 设置黑色背景容器
            .cornerRadius(15)
            .padding(.horizontal)
            
            Spacer()
            
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
            .background(Color.black.opacity(0.8)) // 底部导航栏保持不变
        }
        .navigationBarHidden(true) // 隐藏原始导航栏
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}

