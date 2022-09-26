import SwiftUI

struct BoardView: View {
    var board: Board
    @Binding var taskListDetails: ModelOpt<TaskList>?

    @StateObject var listsVM = TaskListsVM()
    @EnvironmentObject var dragTaskList: DragTaskListModel

    var body: some View {
        #if DEBUG
        let _ = Self._printChanges()
        #endif

        VStack(spacing: 0) {
            if (listsVM.lists.isEmpty) {
                EmptyBoardView(taskListDetails: $taskListDetails)
            } else {
                Divider()
                HStack(
                    alignment: .top,
                    spacing: 2
                ) {
                    ForEach(listsVM.lists, id: \.id) { list in
                        TaskListView(list: list, listsVM: listsVM)
                        .frame(minWidth: 200, minHeight: 200)
                        .onDrop(of: [TASKLIST_UTI], delegate: DragTaskListDropOnTaskList(source: dragTaskList.list, target: list, reorder: listsVM.reorder))
                    }
                }
            }
        }
        .sheet(item: $taskListDetails) { item in
            TaskListSheet(taskList: item.model) { (title, description) in
                listsVM.addOrUpdate(item: item, title, description)
            }
        }
        .onAppear {
            listsVM.loadLists(board: board)
        }
        .onDisappear {
            // TODO
            print("Save tasklists!")
        }
    }
}
