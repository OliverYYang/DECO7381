import SwiftUI

@main
struct Lingoland2App: App {

    // 在应用启动时注册默认值
    init() {
        GameStateManager.shared.registerDefaults()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()  // 你的初始视图
        }
    }
}
