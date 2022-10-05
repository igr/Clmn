import SwiftUI

struct SideBarView: View {
    @StateObject var allBoardsVM = AllBoardsVM()

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
                ForEach(allBoardsVM.boards, id: \.id) { board in
                    NavigationLink(destination: BoardView(board: board, taskListDetails: $taskListDetails),
                        tag: board,
                        selection: $selectedBoard) {
                        Text(board.name)
                        .font(Font.App.sideboard)
                    }
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
                    allBoardsVM.reorder(from: indices, to: newOffset)
                }
            }
            .listStyle(.sidebar)
        }
        .sheet(item: $boardDetails) { item in
            BoardSheet(board: item.model) { boardName in
                allBoardsVM.addOrUpdateBoard(item: item, boardName: boardName)
            }
        }
        .deleteBoardConfirmation($deleteBoard) { deletedBoard in allBoardsVM.deleteBoard(deletedBoard) }
        .onAppear {
            allBoardsVM.loadBoards()
            selectedBoard = allBoardsVM.boards.first
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
