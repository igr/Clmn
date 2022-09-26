import SwiftUI

struct MacTextEditor: NSViewRepresentable {

    var placeholderText: String?
    @Binding var text: String
    @Binding var shouldMoveCursorToEnd: Bool
    var font: NSFont = .systemFont(ofSize: 14, weight: .regular)

    var onSubmit        : () -> Void       = {}
    var onTextChange    : (String) -> Void = { _ in }
    var onEditingChanged: () -> Void       = {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeNSView(context: Context) -> NSScrollView {
        let scrollView = PlaceholderNSTextView.scrollableTextView()

        guard let textView = scrollView.documentView as? PlaceholderNSTextView else {
            return scrollView
        }

        textView.delegate = context.coordinator
        textView.string = text
        textView.drawsBackground = false
        textView.font = font
        textView.allowsUndo = true
        textView.placeholderText = placeholderText

        scrollView.hasVerticalScroller = false

        return scrollView
    }

    func updateNSView(_ view: NSScrollView, context: Context) {
        guard let textView = view.documentView as? NSTextView else {
            return
        }

        // the range is reset when updating the string of the textView
        // so this will set it back to where it was previously
        let currentRange = textView.selectedRange()
        textView.string = text
        textView.setSelectedRange(currentRange)
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
                // Do something when ENTER key pressed
                parent.onSubmit()
                return true
            }

            // return true if the action was handled; otherwise false
            return false
        }
    }
}

// for setting a proper placeholder text on an NSTextView
fileprivate class PlaceholderNSTextView: NSTextView {
    @objc private var placeholderAttributedString: NSAttributedString?
    var placeholderText: String? {
        didSet {
            var attributes = [NSAttributedString.Key: AnyObject]()
            attributes[.font] = font
            attributes[.foregroundColor] = NSColor.gray
            let captionAttributedString = NSAttributedString(string: placeholderText ?? "", attributes: attributes)
            placeholderAttributedString = captionAttributedString
        }
    }
}
