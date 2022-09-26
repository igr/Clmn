import Foundation

extension Array where Element: Equatable {

    /// Removes the first element that is equal to the given `object`.
    mutating func removeElement(_ object: Element) {
        guard let index = firstIndex(of: object) else {
            return
        }
        remove(at: index)
    }

    /// Returns random element from the array.
    func randomElement() -> Element? {
        guard !isEmpty else {
            return nil
        }
        let index = Int(arc4random_uniform(UInt32(count)))
        return self[index]
    }

    /// Consumes array element on given place.
    func withElement(_ object: Element, consumer: (_: Int) -> Void) {
        guard let index = firstIndex(of: object) else {
            return
        }
        consumer(index)
    }
}
