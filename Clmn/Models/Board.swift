import SwiftUI

typealias BoardId = UUID

struct Board: Identifiable, Equatable, Hashable, Orderable, Codable {

    var id: BoardId = BoardId()
    var name: String
    var order: Int
    var timestamp: Date = Date.now

    public static let foo = Board(name: "n/a", order: -1)
}
