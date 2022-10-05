import UniformTypeIdentifiers

let TASKGROUP_UTI = UTType(APP_GROUP + ".group")!

class DragTaskGroupModel: ObservableObject {
    @Published var group: TaskGroup?

    func startDragOf(_ group: TaskGroup) -> NSItemProvider {
        self.group = group
        return NSItemProvider(item: group.name as NSString, typeIdentifier: TASKGROUP_UTI.identifier)
    }

}
