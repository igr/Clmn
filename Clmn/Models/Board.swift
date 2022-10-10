import SwiftUI

typealias BoardId = UUID

struct Board: Identifiable, Equatable, Hashable, Codable {

    var id: BoardId = BoardId()
    var name: String
    // meta
    var timestamp: Date = Date.now

    public static let foo = Board(name: "n/a")
}

extension Array where Element == Board {

    func with(_ board: Board, consumer: (Int) -> Void) {
        guard let index = firstIndex(where: { b in b.id == board.id } ) else { return }
        consumer(index)
    }
}
