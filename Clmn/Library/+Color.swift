import SwiftUI
import AppKit

extension Color {
    // see: https://developer.apple.com/documentation/appkit/nscolor

    // MARK: Label Colors
    static let label = Color(NSColor.labelColor)
    static let secondaryLabel = Color(NSColor.secondaryLabelColor)
    static let tertiaryLabel = Color(NSColor.tertiaryLabelColor)
    static let quaternaryLabel = Color(NSColor.quaternaryLabelColor)

    // MARK: Text Colors
    static let text = Color(NSColor.textColor)
    static let placeholderText = Color(NSColor.placeholderTextColor)
    static let selectedText = Color(NSColor.selectedTextColor)
    static let textBackground = Color(NSColor.textBackgroundColor)
    static let selectedTextBackground = Color(NSColor.selectedTextBackgroundColor)
    static let keyboardFocusIndicator = Color(NSColor.keyboardFocusIndicatorColor)
    static let unemphasizedSelectedText = Color(NSColor.unemphasizedSelectedTextColor)
    static let unemphasizedSelectedTextBackground = Color(NSColor.unemphasizedSelectedTextBackgroundColor)

    // MARK: Content Colors
    static let link = Color(NSColor.linkColor)
    static let separator = Color(NSColor.separatorColor)
    static let selectedContentBackground = Color(NSColor.selectedContentBackgroundColor)
    static let unemphasizedSelectedContentBackground = Color(NSColor.unemphasizedSelectedContentBackgroundColor)

    // MARK: Menu Colors
    static let selectedMenuItemText = Color(NSColor.selectedMenuItemTextColor)

    // MARK: Table Colors
    static let grid = Color(NSColor.gridColor)
    static let headerText = Color(NSColor.headerTextColor)
    static let alternatingContentBackground0 = Color(NSColor.alternatingContentBackgroundColors[0])
    static let alternatingContentBackground1 = Color(NSColor.alternatingContentBackgroundColors[1])

    // MARK: Control Colors
    static let controlAccent = Color(NSColor.controlAccentColor)
    static let control = Color(NSColor.controlColor)
    static let controlBackground = Color(NSColor.controlBackgroundColor)
    static let controlText = Color(NSColor.controlTextColor)
    static let disabledControlText = Color(NSColor.disabledControlTextColor)
    static let selectedControl = Color(NSColor.selectedControlColor)
    static let selectedControlText = Color(NSColor.selectedControlTextColor)
    static let alternateSelectedControlText = Color(NSColor.alternateSelectedControlTextColor)
    static let scrubberTexturedBackground = Color(NSColor.scrubberTexturedBackground)

    // MARK: Window Colors
    static let windowBackground = Color(NSColor.windowBackgroundColor)
    static let windowFrameText = Color(NSColor.windowFrameTextColor)
    static let underPageBackground = Color(NSColor.underPageBackgroundColor)

    // MARK: Highlights and Shadows
    static let findHighlight = Color(NSColor.findHighlightColor)
    static let highlight = Color(NSColor.highlightColor)
    static let shadow = Color(NSColor.shadowColor)

    // MARK: System Colors
    static let systemBlue = Color(NSColor.systemBlue)
    static let systemBrown = Color(NSColor.systemBrown)
    static let systemGray = Color(NSColor.systemGray)
    static let systemGreen = Color(NSColor.systemGreen)
    static let systemIndigo = Color(NSColor.systemIndigo)
    static let systemOrange = Color(NSColor.systemOrange)
    static let systemPink = Color(NSColor.systemPink)
    static let systemPurple = Color(NSColor.systemPurple)
    static let systemRed = Color(NSColor.systemRed)
    static let systemTeal = Color(NSColor.systemTeal)
    static let systemYellow = Color(NSColor.systemYellow)

}

extension Color {

    /// Creates a color from a hex string.
    init?(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0

        var r: CGFloat = 0.0
        var g: CGFloat = 0.0
        var b: CGFloat = 0.0
        var a: CGFloat = 1.0

        let length = hexSanitized.count

        guard Scanner(string: hexSanitized).scanHexInt64(&rgb) else {
            return nil
        }

        if length == 6 {
            r = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
            g = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
            b = CGFloat(rgb & 0x0000FF) / 255.0

        } else if length == 8 {
            r = CGFloat((rgb & 0xFF000000) >> 24) / 255.0
            g = CGFloat((rgb & 0x00FF0000) >> 16) / 255.0
            b = CGFloat((rgb & 0x0000FF00) >> 8) / 255.0
            a = CGFloat(rgb & 0x000000FF) / 255.0

        } else {
            return nil
        }

        self.init(red: r, green: g, blue: b, opacity: a)
    }

    //// Returns hex String value of the color.
    func toHex() -> String? {
        let nsc = NSColor(self)
        guard let components = nsc.cgColor.components, components.count >= 3 else {
            return nil
        }
        let r = Float(components[0])
        let g = Float(components[1])
        let b = Float(components[2])
        var a = Float(1.0)

        if components.count >= 4 {
            a = Float(components[3])
        }

        if a != Float(1.0) {
            return String(format: "%02lX%02lX%02lX%02lX", lroundf(r * 255), lroundf(g * 255), lroundf(b * 255), lroundf(a * 255))
        } else {
            return String(format: "%02lX%02lX%02lX", lroundf(r * 255), lroundf(g * 255), lroundf(b * 255))
        }
    }

    static var random: Color {
        Color(red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1))
    }
}
