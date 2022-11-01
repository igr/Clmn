import SwiftUI

struct MainView: View {
    @StateObject var allBoardsVM = AllBoardsVM()

    @State private var selectedBoard: Board?
    @State private var selectedTask: Task?
    @State private var taskListDetails: ModelOpt<TaskList>?

    @State private var boardDetails: ModelOpt<Board>?
    @State private var deleteBoard: DeleteIntent<Board> = DeleteIntent()

    @EnvironmentObject var addExample: AddExampleModel
    @EnvironmentObject var dragBoard: DragBoardModel

    var body: some View {
        #if DEBUG
        let _ = Self._printChanges()
        #endif

        AppSplitView(
            sidebar: boardsListView,
            main: selectedBoardView
        )
        .sheet(item: $boardDetails) { item in
            BoardSheet(board: item.model, allBoardsVM: allBoardsVM, selectedBoard: $selectedBoard)
        }
        .deleteBoardConfirmation($deleteBoard) { deletedBoard in
            let deletedIndex = allBoardsVM.deleteBoard(deletedBoard)
            selectedBoard = allBoardsVM.boards.safeGet(deletedIndex)
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
                guard let locatedTask = allBoardsVM.findTaskById(TaskId(uuidString: taskId)!) else {
                    return
                }
                selectedTask = locatedTask.3
                selectedBoard = locatedTask.0
            }
        })
    }

    /// BOARDS
    private var boardsListView: some View {
        VStack(spacing: 0) {
            Spacer().frame(height: 10) // need this to prevent coloring issue.
            ForEach(allBoardsVM.boards, id: \.id) { board in
                Button {
                    selectedBoard = board
                } label: {
                    Text(board.name)
                    .font(Font.App.sideboard)
                    .padding(5)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    .contentShape(Rectangle())
                    .onDrag {
                        dragBoard.startDragOf(board)
                    }
                }
                .buttonStyle(.plain)
                .background(selectedBoard == board ? Color.App.sidebarSelected : .clear)
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
                .onDrop(
                    of: [BOARD_UTI],
                    delegate: DragBoardDropOnBoard(
                        source: dragBoard,
                        target: board,
                        reorder: { s, d in allBoardsVM.reorder(from: s, to: d) }
                    )
                )
            }
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
        .background(Color.App.sidebarBackground)
        .colorScheme(.dark)
    }

    /// SINGLE SELECTED BOARD
    private var selectedBoardView: some View {
        VStack(spacing: 0) {
            if (allBoardsVM.isEmpty()) {
                ZeroBoardView()
            }
            ForEach(allBoardsVM.boards, id: \.id) { board in
                if (selectedBoard == board) {
                    BoardView(
                        board: board,
                        taskListDetails: $taskListDetails,
                        selectedTask: $selectedTask)
                }
            }
        }
        .layoutPriority(1)
    }
}

fileprivate struct SizePreferenceKey: PreferenceKey {
    static var defaultValue: CGSize = .zero

    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        value = nextValue()
    }
}
