import AppKit

extension String {
    /// Empty string.
    static let empty: String = ""

    /// Parses input text as Markdown.
    func markdown() -> AttributedString {
        do {
            return try AttributedString(markdown: self)
//            let highlight = AttributeContainer.foregroundColor(.red).backgroundColor(.mint)
//            a.replaceAttributes(AttributeContainer.inlinePresentationIntent(.emphasized), with: highlight)
        } catch {
            return AttributedString("Error parsing markdown: \(error)")
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
