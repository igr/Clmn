import SwiftUI

struct BoardView: View {
    private var board: Board

    @StateObject var listsVM = TaskListsViewModel()

    init(_ board: Board) {
        self.board = board
    }

    var body: some View {
        #if DEBUG
        let _ = Self._printChanges()
        #endif

        VStack(spacing: 0) {
            Divider()
            if (listsVM.lists.isEmpty) {
                EmptyBoardView()
            } else {
                HStack(
                    alignment: .top,
                    spacing: 2
                ) {
                    ForEach(listsVM.lists, id: \.id) { list in
                        Text(list.title)
//                            TaskListView(list: list)
//                            .frame(minWidth: 200, minHeight: 200)
                    }
                }
            }
        }
        .onAppear {
            listsVM.loadLists(board: board)
        }
    }
}
