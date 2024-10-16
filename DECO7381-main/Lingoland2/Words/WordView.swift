import SwiftUI

struct Word: Identifiable {
    var id: UUID = UUID()
    var word: String
    var translation: String  // 新增翻译字段
}

struct WordView: View {
    @ObservedObject var viewModel = WordViewModel() // 绑定视图模型
    @State private var sortOrder = 1  // 排序方式的状态
    @State private var showAlert = false // 控制弹窗显示
    @Environment(\.presentationMode) var presentationMode // 用于返回上一个视图

    var body: some View {
        VStack {
            // 自定义顶部容器
            HStack {
                Button(action: {
                    // 返回到上一个视图
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "arrow.left")
                        .resizable()
                        .frame(width: 18, height: 18)
                        .foregroundColor(.white)
                }
                .padding(.leading) // 让返回按钮靠左
                
                Spacer()
                
                Text("Vocabulary")
                    .font(.title3)
                    .foregroundColor(.white)
                    .bold() // 设置标题居中显示
                
                Spacer()
            }
            .padding() // 给顶部容器添加一些 padding
            .background(Color.black.opacity(0.8)) // 设置背景颜色为黑色并加一点透明度
            
            HStack {
                Text("New words:")
                    .font(.title3)
                    .bold()
                Spacer()
                Picker("Sort", selection: $sortOrder) {  // 绑定选择器的状态
                    Text("A to Z").tag(1)
                    Text("Z to A").tag(2)
                }
                .pickerStyle(MenuPickerStyle())
                .onChange(of: sortOrder, perform: { _ in
                    viewModel.sortWords(order: sortOrder)  // 调用视图模型的排序方法
                })
            }
            .padding()

            if viewModel.isLoading {
                ProgressView("Loading words...")
                    .padding()
            } else {
                List(viewModel.wordsArray) { word in
                    HStack {
                        Text(word.word)
                        Spacer()
                        
                        // 在这里将加号按钮放到最右侧
                        Button(action: {
                            viewModel.addToAnotherTable(word: word)
                            print("Word \(word.word) added to game successfully!")
                            showAlert = true // 触发弹窗显示
                        }) {
                            Image(systemName: "plus.circle")
                                .foregroundColor(.blue)
                        }
                    }
                    .padding(.vertical, 8)  // 添加垂直填充来分隔单词项
                }
            }
        }
        .navigationBarHidden(true) // 隐藏默认导航栏
        .onAppear {
            viewModel.fetchWords()
        }
        // 添加弹窗
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Success"),
                message: Text("Word added to game successfully!"),
                dismissButton: .default(Text("OK"))
            )
        }
    }
}

struct WordView_previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            WordView()
        }
    }
}
