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

    /// Returns safe index or -1 if array is empty
    func safeIndex(_ index: Int) -> Int {
        if (endIndex == 0) {
            return -1
        }
        if (index < 0) {
            return 0
        }
        if (index >= endIndex) {
            return endIndex - 1
        }
        return index
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
