import os
import Foundation
import Fridge

class TaskListsService {

    private func boardObjectID(_ boardId: BoardId) -> String {
        "clmn.board.\(boardId.uuidString)"
    }

    private static let logger = Logger(
        subsystem: Bundle.main.bundleIdentifier!,
        category: String(describing: TaskListsService.self)
    )

    func fetchBoardLists(_ boardId: BoardId) -> [TaskList] {
        let objId = boardObjectID(boardId)
        if (!Fridge.isFrozen🔬(objId)) {
            return []
        }
        let lists: [TaskList]
        do {
            lists = try Fridge.unfreeze🪅🎉(objId)
            Self.logger.notice("Board fetched: \(boardId)")
        } catch {
            Self.logger.error("Failed to fetch board: \(error._code)")
            lists = [TaskList(boardId: boardId, title: "Error")]
        }
        
        // make sure that all lists are valid
        return lists.filter { $0.valid() }
    }

    func storeBoardLists(boardId: BoardId, boardTaskList: [TaskList]) {
        let objId = boardObjectID(boardId)
        do {
            try Fridge.freeze🧊(boardTaskList, id: objId)
            Self.logger.notice("Boards stored: \(boardId)")
        } catch {
            Self.logger.error("Failed to store boards: \(error._code)")
        }
    }

    func storeBoardListsAsync(boardId: BoardId, boardTaskList: [TaskList]) {
        DispatchQueue.global().async {
            self.storeBoardLists(boardId: boardId, boardTaskList: boardTaskList)
        }
    }

    func dropBoardLists(_ board: Board) {
        Fridge.drop🗑(boardObjectID(board.id))
    }

}
