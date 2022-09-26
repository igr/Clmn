import UniformTypeIdentifiers

let BOARD_UTI = UTType(APP_GROUP + ".task")!

class DragBoardModel: ObservableObject {
    @Published var board: Board?

    func startDragOf(_ board: Board) -> NSItemProvider {
        self.board = board
        return NSItemProvider(item: board.name as NSString, typeIdentifier: BOARD_UTI.identifier)
    }
}
