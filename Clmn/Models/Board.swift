import SwiftUI

typealias BoardId = UUID

struct Board: Identifiable, Equatable, Hashable, Codable {

    var id: BoardId = BoardId()
    var name: String
    var timestamp: Date = Date.now

    public static let foo = Board(name: "n/a")
}
