import os
import Foundation
import Fridge

class BoardsService {

    private func allBoardsObjectID() -> String {
        "clmn.boards"
    }

    private static let logger = Logger(
        subsystem: Bundle.main.bundleIdentifier!,
        category: String(describing: BoardsService.self)
    )

    func fetchBoards() -> [Board] {
        let objId = allBoardsObjectID()
        if (!Fridge.isFrozen🔬(objId)) {
            return []
        }
        let boards: [Board]
        do {
            boards = try Fridge.unfreeze🪅🎉(objId)
            Self.logger.notice("Boards fetched: \(boards.count)")
        } catch {
            Self.logger.error("Failed to fetch boards: \(error.localizedDescription)")
            boards = []
        }
        return boards
    }

    func storeBoards(_ boards: [Board]) {
        let objId = allBoardsObjectID()
        do {
            try Fridge.freeze🧊(boards, id: objId)
            Self.logger.notice("Boards stored: \(boards.count)")
        } catch {
            Self.logger.error("Failed to store boards: \(error.localizedDescription)")
        }
    }

    func storeBoardsAsync(_ boards: [Board]) {
        DispatchQueue.global().async {
            self.storeBoards(boards)
        }
    }

}
