import SwiftUI

struct ReviewImageView: View {
    var body: some View {
        VStack {
            Image("Review") // 确保图片名称为 "review"
                .resizable()
                .scaledToFit() // 保持图片比例
                .frame(maxWidth: .infinity, maxHeight: .infinity) // 适应屏幕大小
                .background(Color.black.opacity(0.8)) // 添加背景颜色
        }
        .navigationBarTitle("Review Image", displayMode: .inline)
    }
}
