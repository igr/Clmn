import SwiftUI

struct TaskListButton: View {
    var list: TaskList
    @Binding var taskListDetails: ModelOpt<TaskList>?
    @Binding var hovered: Bool
    @Binding var isLast: Bool

    var body: some View {
        if (hovered) {
            HStack {
                Spacer()
                Button {
                    taskListDetails = ModelOpt<TaskList>.of(list)
                } label: {
                    TaskListMenuLabel()
                }
                .buttonStyle(.borderless)
                Spacer()
                if (isLast) {
                    Button {
                        taskListDetails = ModelOpt<TaskList>.ofNew()
                    } label: {
                        Image(systemName: Icons.addList)
                        .resizable()
                        .frame(width: 18, height: 18)
                    }
                    .buttonStyle(.borderless)
                    .padding(.trailing, 2)
                }
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
