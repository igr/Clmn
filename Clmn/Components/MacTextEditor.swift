import SwiftUI

/// Proper text (field) editor, because default one really sucks.
struct MacTextEditor: NSViewRepresentable {

    var placeholderText: String?
    var placeholderColor: Color = Color.gray
    @Binding var text: String
    var singleLine: Bool = false
    var moveCursorToEnd: Bool = true
    var font: NSFont = .systemFont(ofSize: 14, weight: .regular)
    var fontColor: Color = Color.text

    var onSubmit        : () -> Void       = {}
    var onTextChange    : (String) -> Void = { _ in }
    var onEditingChanged: () -> Void       = {}

    // Need to compute text attributes as lazy var seems to be mutable, meh.
    private var textAttributes: [NSAttributedString.Key : Any] {
        [
            NSAttributedString.Key.font: font,
            .foregroundColor: NSColor(fontColor)
        ]
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeNSView(context: Context) -> NSScrollView {
        let scrollView = PlaceholderNSTextView.scrollableTextView()

        guard let textView = scrollView.documentView as? PlaceholderNSTextView else {
            return scrollView
        }

        textView.delegate = context.coordinator
        textView.isRichText = false
        textView.importsGraphics = false
        textView.isEditable = true
        textView.isSelectable = true
        textView.drawsBackground = false
        textView.font = font
        textView.allowsUndo = true

        textView.placeholderColor = NSColor(placeholderColor)
        textView.placeholderText = placeholderText

        /// IMPORTANT DETAIL
        // There is a bug in macOS when the first letter of the text is an emoji.
        // textView.string = text
        textView.textStorage?.setAttributedString(NSAttributedString(string:text, attributes: textAttributes))

        scrollView.hasVerticalScroller = false
        scrollView.hasHorizontalRuler = false
        scrollView.borderType = .noBorder
        //scrollView.translatesAutoresizingMaskIntoConstraints = false

        if (singleLine) {
            scrollView.hasHorizontalScroller = false
            textView.maxSize = NSMakeSize(CGFloat.greatestFiniteMagnitude, CGFloat.greatestFiniteMagnitude)
            textView.isHorizontallyResizable = true
            textView.textContainer?.widthTracksTextView = false
            textView.textContainer?.containerSize = NSMakeSize(CGFloat.greatestFiniteMagnitude, CGFloat.greatestFiniteMagnitude)
        }

        if (moveCursorToEnd) {
            textView.becomeFirstResponder()
            let cursorPosition = text.utf16.count
            let cursorRange = NSRange(location: cursorPosition, length: 0)
            textView.selectedRange = cursorRange
            textView.scrollRangeToVisible(cursorRange)
        }

        return scrollView
    }

    func updateNSView(_ view: NSScrollView, context: Context) {
        guard let textView = view.documentView as? NSTextView else {
            return
        }

        // the range is reset when updating the string of the textView
        // so this will set it back to where it was previously
//        let currentRange = textView.selectedRange()

        /// IMPORTANT DETAIL
        // There is a bug in macOS.
        //textView.string = text
        textView.textStorage?.setAttributedString(NSAttributedString(string:text, attributes: textAttributes))

        // basically if we want to move the cursor to the end,
        // we don't set the selected range to what is was before the string update
        // otherwise, we set it
//        if !moveCursorToEnd {
//            textView.setSelectedRange(currentRange)
//        }
    }

}

extension MacTextEditor {
    class Coordinator: NSObject, NSTextViewDelegate {

        var parent: MacTextEditor

        init(_ parent: MacTextEditor) {
            self.parent = parent
        }

        func textDidBeginEditing(_ notification: Notification) {
            guard let textView = notification.object as? NSTextView else {
                return
            }

            parent.text = textView.string
            parent.onEditingChanged()
        }

        func textDidChange(_ notification: Notification) {
            guard let textView = notification.object as? NSTextView else {
                return
            }

            parent.onTextChange(textView.string)
            parent.text = textView.string
        }

        func textDidEndEditing(_ notification: Notification) {
            guard let textView = notification.object as? NSTextView else {
                return
            }

            parent.text = textView.string
            parent.onSubmit()
        }

        // handles commands
        func textView(_ textView: NSTextView, doCommandBy commandSelector: Selector) -> Bool {
            if (commandSelector == #selector(NSResponder.insertNewline(_:))) {
                parent.onSubmit()   // ENTER is pressed
                return true
            }
//            if (commandSelector == #selector(NSResponder.insertTab(_:))) {
//                return true
//            }

            // return true if the action was handled; otherwise false
            return false
        }
    }
}

// For setting a proper placeholder text on an NSTextView.
fileprivate class PlaceholderNSTextView: NSTextView {
    @objc private var placeholderAttributedString: NSAttributedString?
    var placeholderColor: NSColor?
    var placeholderText: String? {
        didSet {
            var attributes = [NSAttributedString.Key: AnyObject]()
            attributes[.font] = font
            attributes[.foregroundColor] = placeholderColor
            placeholderAttributedString = NSAttributedString(string: placeholderText ?? "", attributes: attributes)
        }
    }
}
