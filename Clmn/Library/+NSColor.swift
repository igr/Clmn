import AppKit

extension NSColor {

    /// Returns color instance from RGB values (0-255)
    static func fromRGB(red: Double, green: Double, blue: Double, alpha: Double = 100.0) -> NSColor {

        let rgbRed = CGFloat(red/255)
        let rgbGreen = CGFloat(green/255)
        let rgbBlue = CGFloat(blue/255)
        let rgbAlpha = CGFloat(alpha/100)

        let color = NSColor(red: rgbRed, green: rgbGreen, blue: rgbBlue, alpha: rgbAlpha)
        return color
    }
}
