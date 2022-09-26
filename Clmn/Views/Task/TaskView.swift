import SwiftUI

struct TaskView: View {
    var task: Task

    var body: some View {
        #if DEBUG
        let _ = Self._printChanges()
        #endif
        HStack {
            HStack(alignment: .top) {
//                Image(systemName: checkboxName(task))
//                .font(Font.system(size: 16, design: .monospaced))
//                .foregroundColor(.gray)
//                .gesture(TapGesture().onEnded {
//                    let hasOption = NSEvent.modifierFlags.contains(.option)
//                    if (hasOption) {
//                        toggleProgress(task)
//                    } else {
//                        task.completed.toggle()
//                        if (task.completed == false) {
//                            task.inProgress = 0
//                        }
//                    }
//                })
//                .onHover { isHovered in CursorUtil.handOnHover(isHovered) }
//                .padding(.top, 2)

                Text((task.name).trimmingCharacters(in: .whitespacesAndNewlines).markdown())
                .strikethrough(task.completed)
                .padding(.top, 2)
//                .gesture(TapGesture(count: 2).onEnded {
//                    editTaskAction()
//                })

                Spacer()
            }
            .padding(2)
        }
//        .contextMenu {
//            Button(
//                action: editTaskAction,
//                label: {
//                    Label("Edit Task", systemImage: "square.and.pencil")
//                    .labelStyle(.titleAndIcon)
//
//                }
//            )
//            Button(
//                action: deleteTaskAction,
//                label: {
//                    Label("Delete Task", systemImage: "minus.square.fill")
//                    .labelStyle(.titleAndIcon)
//
//                }
//            )
//        }
//        .onDrag {
//            dragTask.task = task
//            return NSItemProvider(item: task.name! as NSString, typeIdentifier: TASK_UTI.identifier)
//        }
//        .onDrop(of: [TASK_UTI], delegate: TaskDropOnTaskDelegate(source: dragTask.task, target: task))
    }
}
