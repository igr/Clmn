struct Queue<T> {
    private var elements: [T] = []

    mutating func push(_ value: T) {
        elements.append(value)
    }

    mutating func pop() -> T? {
        guard !elements.isEmpty else {
            return nil
        }
        return elements.removeFirst()
    }

    var head: T? {
        elements.first
    }

    mutating func clear() {
        elements.removeAll()
    }

    var tail: T? {
        elements.last
    }

    var size: Int { elements.endIndex }
}
