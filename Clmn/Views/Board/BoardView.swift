import SwiftUI

struct BoardView: View {
    var board: Board
    @Binding var taskListDetails: ModelOpt<TaskList>?

    @StateObject var allListsVM = AllTaskListsVM()
    @EnvironmentObject var dragTaskList: DragTaskListModel

    var body: some View {
        #if DEBUG
        let _ = Self._printChanges()
        #endif

        VStack(spacing: 0) {
            if (allListsVM.lists.isEmpty) {
                EmptyBoardView(taskListDetails: $taskListDetails)
            } else {
                Divider()
                HStack(
                    alignment: .top,
                    spacing: 2
                ) {
                    ForEach(allListsVM.lists, id: \.id) { list in
                        TaskListView(allListsVM: allListsVM, listVM: TaskListVM(list))
                        .frame(minWidth: 200, minHeight: 200)
                        .onDrop(of: [TASKLIST_UTI], delegate: DragTaskListDropOnTaskList(source: dragTaskList.list, target: list, reorder: allListsVM.reorder))
                    }
                }
            }
        }
        .sheet(item: $taskListDetails) { item in
            TaskListSheet(taskList: item.model) { (title, description) in
                allListsVM.addOrUpdateList(item: item, title, description)
            }
        }
        .onAppear {
            allListsVM.loadLists(board: board)
        }
        .onDisappear {
            allListsVM.handleListChanges {
                allListsVM.saveLists()
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: NSApplication.willTerminateNotification), perform: { output in
            allListsVM.handleListChanges {
                allListsVM.saveLists()
            }
        })
    }
}
