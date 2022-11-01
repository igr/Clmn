import Foundation

extension Array where Element: Equatable {

    /// Removes the first element that is equal to the given `object`.
    /// Returns the index of removed element or -1
    @discardableResult
    mutating func removeElement(_ object: Element) -> Int {
        guard let index = firstIndex(of: object) else {
            return -1
        }
        remove(at: index)
        return index
    }

    /// Returns element on the index safely.
    func safeGet(_ index: Int) -> Element? {
        if (count == 0) {
            return nil
        }
        if (index < 0) {
            return first
        }
        if (index >= endIndex) {
            return last
        }
        return self[index]
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
        guard let index = firstIndex(of: object) else { return }
        consumer(index)
    }
}
