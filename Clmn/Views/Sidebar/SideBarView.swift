import SwiftUI

struct SideBarView: View {
    @StateObject var allBoardsVM = AllBoardsVM()

    @State private var selectedBoard: Board?
    @State private var selectedTask: Task?
    @State private var taskListDetails: ModelOpt<TaskList>?

    @State private var boardDetails: ModelOpt<Board>?
    @State private var deleteBoard: DeleteIntent<Board> = DeleteIntent()

    @EnvironmentObject var addExample: AddExampleModel

    var body: some View {
        #if DEBUG
        let _ = Self._printChanges()
        #endif
        VStack(spacing: 0) {
            List {
                ForEach(allBoardsVM.boards, id: \.id) { board in
                    NavigationLink(destination: BoardView(board: board, taskListDetails: $taskListDetails, selectedTask: $selectedTask),
                        tag: board,
                        selection: $selectedBoard) {
                        Text(board.name)
                        .font(Font.App.sideboard)
                        .padding(2)
                    }
                    .contextMenu {
                        Button {
                            boardDetails = ModelOpt<Board>.of(board)
                        } label: {
                            Label("Edit Board", systemImage: Icons.edit)
                            .labelStyle(.titleAndIcon)
                        }
                        Button(role: .destructive) {
                            deleteBoard.set(board)
                        } label: {
                            Label("Delete Board", systemImage: Icons.delete)
                            .labelStyle(.titleAndIcon)
                        }
                        Divider()
                        Button {
                            taskListDetails = ModelOpt<TaskList>.ofNew()
                        } label: {
                            Label("New List", systemImage: Icons.addList)
                            .labelStyle(.titleAndIcon)
                        }
                    }
                }
                .onMove { indices, newOffset in
                    allBoardsVM.reorder(from: indices, to: newOffset)
                }
            }
            .listStyle(.sidebar)
            if (allBoardsVM.isEmpty()) {
                ZeroBoardView()
            }
        }
        .sheet(item: $boardDetails) { item in
            BoardSheet(board: item.model, allBoardsVM: allBoardsVM, selectedBoard: $selectedBoard)
        }
        .deleteBoardConfirmation($deleteBoard) { deletedBoard in
            let deletedIndex = allBoardsVM.deleteBoard(deletedBoard)
            let newIndex = allBoardsVM.boards.safeIndex(deletedIndex)
            if (newIndex != -1) {
                selectedBoard = allBoardsVM.boards[newIndex]
            } else {
                selectedBoard = nil
            }
            allBoardsVM.objectWillChange.send()
        }
        .onAppear {
            allBoardsVM.loadBoards()
            selectedBoard = allBoardsVM.boards.first
        }
        .onReceive([addExample.state].publisher.first()) { value in
            if (value > 0) {
                createExample(with: allBoardsVM)
                selectedBoard = allBoardsVM.boards.last
                addExample.reset()
            }
        }
        .onOpenURL(perform: { url in
            if (url.host == "tasks" && url.pathComponents.count >= 2) {
                let taskId = url.pathComponents[1]
                guard let locatedTask = allBoardsVM.findTaskById(TaskId(uuidString: taskId)!) else { return }
                selectedTask = locatedTask.3
                selectedBoard = locatedTask.0
            }
        })
        Spacer()
        Divider()
        HStack {
            Button(
                action: { boardDetails = ModelOpt<Board>.ofNew() },
                label: {
                    Image(systemName: Icons.addBoard)
                    Text("Add Board")
                }
            )
            .controlSize(.large)
        }
        .padding()
    }
}
