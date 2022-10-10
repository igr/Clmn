import SwiftUI

struct TaskListButton: View {
    var list: TaskList
    @Binding var taskListDetails: ModelOpt<TaskList>?
    @Binding var taskGroupDetails: ModelOpt<TaskGroup>?
    @Binding var taskDetails: ModelPairOpt<TaskGroup, Task>?
    @Binding var hovered: Bool

    var body: some View {
        if (hovered) {
            HStack {
                Spacer()
                Menu {
                    Button {
                        taskListDetails = ModelOpt<TaskList>.of(list)
                    } label: {
                        Label("Edit List", systemImage: Icons.squareAndPencil)
                        .labelStyle(.titleAndIcon)
                    }
                    Divider()
                    Button {
                        taskListDetails = ModelOpt<TaskList>.ofNew()
                    } label: {
                        Label("Add List", systemImage: Icons.plusSquare)
                        .labelStyle(.titleAndIcon)
                    }
                    Divider()
                    Button {
                        taskGroupDetails = ModelOpt<TaskGroup>.ofNew()
                    } label: {
                        Label("Add Group", systemImage: Icons.plusViewfinder)
                        .labelStyle(.titleAndIcon)
                    }
                    Button {
                        taskDetails = ModelPairOpt<TaskGroup, Task>.ofNew(list.defaultGroup())
                    } label: {
                        Label("Add Task", systemImage: Icons.plus)
                        .labelStyle(.titleAndIcon)
                    }
                } label: {
                    TaskListMenuLabel()
                }
                .menuStyle(.borderlessButton)
                .menuIndicator(.hidden)
                .fixedSize()
                Spacer()
            }
        } else {
            Spacer()
            .frame(height: 24)
        }
    }
}

internal struct TaskListMenuLabel: View {

    internal var body: some View {
        Text(Image.init(systemName: Icons.ellipsis).resizable())
        .font(.system(size: 20))
    }
}
