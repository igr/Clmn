import SwiftUI

let goldenRatio = GoldenRatio()

struct GoldenRatio {
    func of(_ value: Int) -> CGFloat {
        CGFloat(Double(value) * 1.61803398875)
    }
}
