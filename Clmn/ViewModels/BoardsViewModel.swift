import SwiftUI

class BoardsVM: ObservableObject {

    @Published private(set) var boards: [Board] = []

    func loadBoards() {
        boards = services.boards.fetchBoards()
    }

    func saveBoards() {
        services.boards.storeBoards(boards)
    }

    /// Creates a new board.
    func addNewBoard(_ name: String) {
        let newBoard = Board(name: name, order: boards.countNextOrder())
        boards.append(newBoard)
        services.boards.storeBoardsAsync(boards)
    }

    /// Deletes a board.
    func deleteBoard(_ boardToDelete: Board) {
        boards.removeElement(boardToDelete)
        services.lists.dropBoardLists(boardToDelete)
    }

    /// Updates the board.
    func updateBoard(_ boardToUpdate: Board, _ name: String) {
        boards.withElement(boardToUpdate) { i in
            boards[i].name = name
        }
    }

    func addOrUpdate(item: ModelOpt<Board>, boardName: String) {
        item.apply {
            addNewBoard(boardName)
        } or: { b in
            updateBoard(b, boardName)
        }
    }

    /// Reorders the boards.
    func reorder(from set: IndexSet, to destinationIndex: Int) {
        boards.move(fromOffsets: set, toOffset: destinationIndex)
        boards.reorder(setOrder: setBoardOrder)
        saveBoards()
    }

    private func setBoardOrder(index: Int, newOrder: Int) {
        boards[index].order = newOrder
    }
}
