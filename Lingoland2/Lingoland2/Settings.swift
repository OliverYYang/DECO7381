import SwiftUI

struct SettingView: View {
    @State private var delayTime: Int = 3 // 延迟时间的默认值
    
    var body: some View {
        VStack {
            // 顶部导航栏
            HStack {
                NavigationLink(destination: ContentView()) {
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
                        .foregroundColor(.orange)
                    Text("Setting")
                        .font(.footnote)
                        .foregroundColor(.orange)
                }
                Spacer()
            }
            .padding()
            .background(Color.black.opacity(0.8))
        }
        .navigationBarHidden(true)
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}

