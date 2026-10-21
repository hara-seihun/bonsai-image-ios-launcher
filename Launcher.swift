import SwiftUI
import UIKit

// Opens the device-lab entry URL (Info.plist LaunchURL) in Safari as soon as the app is active, and again on each tap.
@main
struct LauncherApp: App {
    @State private var opened = false
    private let url = URL(string: Bundle.main.object(forInfoDictionaryKey: "LaunchURL") as! String)!
    var body: some Scene {
        WindowGroup {
            VStack(spacing: 24) {
                Text("Bonsai Image lab").font(.title)
                Text(url.absoluteString).font(.footnote).multilineTextAlignment(.center).padding()
                Button("Open in Safari") { UIApplication.shared.open(url) }.font(.title2)
            }
            // onChange does not fire for the initial .active phase, so the first open happens on appear
            .task { if !opened { opened = true; try? await Task.sleep(nanoseconds: 500_000_000); await UIApplication.shared.open(url) } }
        }
    }
}
