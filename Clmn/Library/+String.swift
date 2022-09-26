import AppKit

extension String {
    /// Empty string.
    static let empty: String = ""

    /// Parses input text as Markdown.
    func markdown() -> AttributedString {
        do {
            return try AttributedString(markdown: self)
        } catch {
            return AttributedString("Error parsing markdown: \(error)")
        }
    }
}
