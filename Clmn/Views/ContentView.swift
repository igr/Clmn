import SwiftUI

struct ContentView: View {

    @StateObject var dragTaskList: DragTaskListModel = DragTaskListModel()

    var body: some View {
        NavigationView {
            VStack {
                SideBarView()
            }
            .colorScheme(.dark)
            .background(Color.App.sidebarBackground)
        }
        .environmentObject(dragTaskList)
        .navigationViewStyle(.columns)
        .toolbar {
            ToolbarItem(placement: .navigation) {
                Button(
                    action: SideBarUtil.toggleSidebar,
                    label: { Image(systemName: Icons.sidebarLeft) }
                )
            }
        }
    }

}
