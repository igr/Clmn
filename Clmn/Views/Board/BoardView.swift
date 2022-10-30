import SwiftUI

struct BoardView: View {
    var board: Board
    @Binding var taskListDetails: ModelOpt<TaskList>?
    @Binding var selectedTask: Task?

    @StateObject var allListsVM = AllTaskListsVM()
    @State private var isEmpty = false

    var body: some View {
        #if DEBUG
        let _ = Self._printChanges()
        #endif

        VStack(spacing: 0) {
            if (isEmpty) {
                EmptyBoardView(taskListDetails: $taskListDetails)
            } else {
                HStack(
                    alignment: .top,
                    spacing: 2
                ) {
                    ForEach(allListsVM.lists, id: \.id) { list in
                        TaskListView(
                            allListsVM: allListsVM,
                            listVM: TaskListVM(list),
                            selectedTask: $selectedTask
                        )
                        .frame(minWidth: 200, minHeight: 200)
                        .shadow(color: Color.App.listSplitLine, radius: 5, x: 15, y: 15)
                    }
                }
            }
        }
        .sheet(item: $taskListDetails) { item in
            TaskListSheet(list: item.model, allListsVM: allListsVM)
        }
        .onAppear {
            allListsVM.loadLists(board: board)
            isEmpty = allListsVM.lists.isEmpty
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
