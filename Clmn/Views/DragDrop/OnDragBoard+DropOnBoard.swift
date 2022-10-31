import SwiftUI

struct DragBoardDropOnBoard: DropDelegate {
    var source: DragBoardModel
    var target: Board
    var reorder: (_: Board, _: Board) -> Void

    func performDrop(info: DropInfo) -> Bool {
        guard info.hasItemsConforming(to: [BOARD_UTI]) else { return false }
        guard let origin = source.board else { return false }
        source.stopDrop()

        if (origin.id == target.id) {
            return false
        }

        reorder(origin, target)
        return true
    }
}
