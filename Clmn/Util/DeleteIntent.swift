import SwiftUI

/// Simple struct to store pair of values:
/// one flag for the UI confirmation dialog and the target item.
struct DeleteIntent<T> {
    var isPresented: Bool = false
    var target: T? = nil

    mutating func set(_ target: T) {
        self.target = target
        isPresented = true
    }

    mutating func reset() {
        isPresented = false
        target = nil
    }
}
