import SwiftUI

struct ContentView: View {

    @StateObject var dragTask: DragTaskModel = DragTaskModel()
    @StateObject var dragTaskList: DragTaskListModel = DragTaskListModel()
    @StateObject var dragTaskGroup: DragTaskGroupModel = DragTaskGroupModel()

    var body: some View {
        NavigationView {
            VStack {
                SideBarView()
            }
            .colorScheme(.dark)
            .background(Color.App.sidebarBackground)
        }
        .environmentObject(dragTask)
        .environmentObject(dragTaskList)
        .environmentObject(dragTaskGroup)
        .navigationViewStyle(.columns)
        .toolbar {
            ToolbarItem(placement: .navigation) {
                Button(
                    action: SideBarUtil.toggleSidebar,
                    label: { Image(systemName: Icons.sidebarToggle) }
                )
            }
        }
    }

}
