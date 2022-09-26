import AppKit

extension NSTextView {
    // Removes the background, so we can present the placeholder.
    open override var frame: CGRect {
        didSet {
            backgroundColor = .clear
            drawsBackground = true
        }
    }
}
