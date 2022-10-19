import AppKit

extension String {
    /// Empty string.
    static let empty: String = ""

    /// Parses input text as Markdown.
    func markdown() -> AttributedString {
        do {
            var attributedString = try AttributedString(markdown: self,
                options: AttributedString.MarkdownParsingOptions(
                    allowsExtendedAttributes: true,
                    interpretedSyntax: .inlineOnlyPreservingWhitespace))

            let runs = attributedString.runs
            for run in runs {
                let range = run.range
//                if let textStyle = run.inlinePresentationIntent {
//                    if textStyle.contains(.emphasized) {
//                        // change foreground color of bold text
//                        attributedString[range].foregroundColor = .green
//                    }
//                }
                if run.link != nil {
                    var container = AttributeContainer()
                    container.foregroundColor = NSColor.fromRGB(red: 33, green: 150, blue: 243)
                    attributedString[range].setAttributes(container)
                }
            }
            return attributedString
        } catch {
            return AttributedString(self)
        }
    }

    /// Trims whitespaces.
    func trim() -> String {
        trimmingCharacters(in: .whitespacesAndNewlines)
    }

    /// Turns String to nil if empty.
    func nilIfEmpty() -> String? {
        (count == 0) ? nil : self
    }

    static func trimAndNil(_ str: String?) -> String? {
        str != nil ? str!.trim().nilIfEmpty() : nil
    }
}
