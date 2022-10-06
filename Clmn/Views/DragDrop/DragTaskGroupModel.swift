import UniformTypeIdentifiers

let TASKGROUP_UTI = UTType(APP_GROUP + ".group")!

class DragTaskGroupModel: ObservableObject {
    @Published var group: (TaskList, TaskGroup)?

    func startDragOf(_ owner: TaskList, _ group: TaskGroup) -> NSItemProvider {
        self.group = (owner, group)
        return NSItemProvider(item: group.name as NSString, typeIdentifier: TASKGROUP_UTI.identifier)
    }

    func stopDrop() {
        group = nil
    }

}
