import SwiftUI
import UIKit

// Opens the device-lab entry URL (Info.plist LaunchURL) in Safari as soon as the app is active, and again on each tap.
@main
struct LauncherApp: App {
    @Environment(\.scenePhase) private var phase
    @State private var opened = false
    private let url = URL(string: Bundle.main.object(forInfoDictionaryKey: "LaunchURL") as! String)!
    var body: some Scene {
        WindowGroup {
            VStack(spacing: 24) {
                Text("Bonsai Image lab").font(.title)
                Text(url.absoluteString).font(.footnote).multilineTextAlignment(.center).padding()
                Button("Open in Safari") { UIApplication.shared.open(url) }.font(.title2)
            }
            .onChange(of: phase) { _, p in
                if p == .active && !opened { opened = true; UIApplication.shared.open(url) }
            }
        }
    }
}
