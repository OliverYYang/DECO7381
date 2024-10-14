import SwiftUI

struct Word: Identifiable {
    var id: UUID = UUID()
    var word: String
    var translation: String  // 新增翻译字段
}


struct WordView: View {
    @ObservedObject var viewModel = WordViewModel() // 绑定视图模型
    @State private var sortOrder = 1  // 排序方式的状态

    var body: some View {
        VStack {
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
