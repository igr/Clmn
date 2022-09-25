import SwiftUI

struct Board : Identifiable, Equatable, Hashable, Orderable {

    let id: UUID = UUID()
    var name: String
    var order: Int
    var timestamp: Date = Date.now

}
