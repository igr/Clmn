import SwiftUI

class BoardsViewModel: ObservableObject {

    @Published private(set) var boards: [Board] = []

    func loadBoards() {
        boards = services.boardService.fetchBoards()
    }

    /// Creates a new board.
    func addNewBoard(_ name: String) -> Board {
        let newBoard = Board(name: name, order: boards.countNextOrder())
        boards.append(newBoard)
        return newBoard
    }

    /// Deletes a board.
    func deleteBoard(_ boardToDelete: Board) {
        boards.removeElement(object: boardToDelete)
    }

    func updateBoard(_ boardToUpdate: Board, _ name: String) {
        boardToUpdate.name = name
    }
}
