
protocol Orderable {
    var order: Int { get set }
}

extension Array where Element: Orderable {
    
    /// Counts the next order value.
    func countNextOrder() -> Int {
        var result = 0
        for item in self {
            if (item.order > result) {
                result = item.order
            }
        }
        return result + 1
    }
}
