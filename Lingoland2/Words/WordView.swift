import SwiftUI

struct Word: Identifiable {
    var id: UUID = UUID()
    var word: String
    var translation: String  // 新增翻译字段
}


struct WordView: View {
    @ObservedObject var viewModel = WordViewModel() // 绑定视图模型

    var body: some View {
        VStack {
            HStack {
                Text("New words:")
                    .font(.title3)
                    .bold()
                Spacer()
                Picker("Sort", selection: .constant(1)) {
                    Text("A to Z").tag(1)
                    Text("Z to A").tag(2)
                }
                .pickerStyle(MenuPickerStyle())
            }
            .padding()

            if viewModel.isLoading {
                // 加载中显示转圈
                ProgressView("Loading words...")
                    .padding()
            } else {
                // 显示单词列表
                List(viewModel.wordsArray) { word in
                    HStack {
                        Text(word.word)
                        Spacer()
                        // 添加按钮，点击后将单词添加到数据库的另一个表中
                        Button(action: {
                            viewModel.addToAnotherTable(word: word)
                        }) {
                            Image(systemName: "plus.circle")
                                .foregroundColor(.blue)
                        }
                        NavigationLink(destination: Text("Translation: \(word.translation)")) {
                            Image(systemName: "chevron.right")
                        }
                    }
                    .padding()
                }

            }
        }
        .navigationTitle("Vocabulary")
        .onAppear {
            // 视图出现时调用ViewModel获取单词数据
            viewModel.fetchWords()
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
