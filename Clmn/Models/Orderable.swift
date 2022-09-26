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

//    func reorder(source: Int, destination: Int, setOrder: (_ index: Int, _ newOrder: Int) -> Void) {
//        if (source == destination) {
//            return
//        }
//
//        if (source > destination) {
//            // move up
//            for b in self {
//                if (b.order < destination) {
//                    // don't touch anything bellow destination
//                }
//                else if (b.order < source) {
//                    // previous elements needs to ++
//                    withElement(b) { index in setOrder(index, b.order + 1) }
//                }
//                else if (b.order == source) {
//                    withElement(b) { index in setOrder(index, destination) }
//                }
//            }
//        }
//        else {
//            // move down
//            for b in self {
//                if (b.order > destination) {
//                    // don't touch anything after destination
//                }
//                else if (b.order > source) {
//                    // next elements needs to --
//                    withElement(b) { index in setOrder(index, b.order - 1) }
//                }
//                else if (b.order == source) {
//                    withElement(b) { index in setOrder(index, destination) }
//                }
//            }
//        }
//    }

    func reorder(setOrder: (_ index: Int, _ newOrder: Int) -> Void) {
        for (index, _) in enumerated() {
            setOrder(index, index + 1)
        }
    }
}
