import SwiftUI

/// Appearance fiddling.
enum Appearance: String, CaseIterable, Identifiable {
    case system
    case light
    case dark

    var id: String {
        self.rawValue
    }

    /// The working way of theme change across the application.
    static func applyTheme(_ theme: Appearance) {
        @AppStorage("appThemeSetting") var appThemeSetting = Appearance.system

        appThemeSetting = theme

        switch theme {
        case .light:
            NSApp.appearance = NSAppearance(named: .vibrantLight)
        case .dark:
            NSApp.appearance = NSAppearance(named: .darkAqua)
        default:
            NSApp.appearance = nil
        }
    }
}
