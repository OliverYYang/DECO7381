import SwiftUI

@main
struct Lingoland2App: App {

    init() {
        GameStateManager.shared.registerDefaults()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()  
        }
    }
}
