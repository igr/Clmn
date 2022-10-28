import SwiftUI

struct ContentView: View {

    @StateObject var dragTask: DragTaskModel = DragTaskModel()
    @StateObject var dragTaskList: DragTaskListModel = DragTaskListModel()
    @StateObject var dragTaskGroup: DragTaskGroupModel = DragTaskGroupModel()

//    @State private var sidebarCollapsed = false
//    @State private var sidebarInit: (Bool) -> Void = { b in
//        if (b == true) {
//            SideBarUtil.toggleSidebar()
//        }
//    }

    var body: some View {
        NavigationView {
            VStack {
                SideBarView()
            }
            .colorScheme(.dark)
            .background(Color.App.sidebarBackground)
//            .background(SplitViewAccessor(sideCollapsed: $sidebarCollapsed, onInit: $sidebarInit))
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
