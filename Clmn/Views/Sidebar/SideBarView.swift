import SwiftUI

struct SideBarView: View {
    @StateObject var boardsVM = BoardsVM()

    @State private var selectedBoard: Board?
    @State private var taskListDetails: ModelOpt<TaskList>?

    @State private var boardDetails: ModelOpt<Board>?
    @State private var deleteBoard: DeleteIntent<Board> = DeleteIntent()

    var body: some View {
        #if DEBUG
        let _ = Self._printChanges()
        #endif
        VStack(spacing: 0) {
            List {
                ForEach(boardsVM.boards, id: \.id) { board in
                    NavigationLink(destination: BoardView(board: board, taskListDetails: $taskListDetails),
                        tag: board,
                        selection: $selectedBoard) {
                        Text("\(board.name) \(board.order)")
                        .font(Font.App.sideboard)
                    }
                    .modifier(DeleteBoardConfirmationDialog(deleteIntent: $deleteBoard) { deletedBoard in boardsVM.deleteBoard(deletedBoard) })
                    .contextMenu {
                        Button {
                            boardDetails = ModelOpt<Board>.of(board)
                        } label: {
                            Label("Edit Board", systemImage: Icons.squareAndPencil)
                            .labelStyle(.titleAndIcon)
                        }
                        Button(role: .destructive) {
                            deleteBoard.set(board)
                        } label: {
                            Label("Delete Board", systemImage: Icons.minusSquareFill)
                            .labelStyle(.titleAndIcon)
                        }
                        Divider()
                        Button {
                            taskListDetails = ModelOpt<TaskList>.ofNew()
                        } label: {
                            Label("New List", systemImage: Icons.plus)
                            .labelStyle(.titleAndIcon)
                        }
                    }
                }
                .onMove { indices, newOffset in
                    boardsVM.reorder(from: indices, to: newOffset)
                }
            }
            .listStyle(.sidebar)
        }
        .sheet(item: $boardDetails) { item in
            BoardSheet(board: item.model) { boardName in
                boardsVM.addOrUpdate(item: item, boardName: boardName)
            }
        }
        .onAppear {
            boardsVM.loadBoards()
            selectedBoard = boardsVM.boards.first
        }
        Spacer()
        Divider()
        HStack {
            Button(
                action: { boardDetails = ModelOpt<Board>.ofNew() },
                label: {
                    Image(systemName: Icons.plusSquareFill)
                    Text("Add Board")
                }
            )
            .controlSize(.large)
        }
        .padding()
    }
}
