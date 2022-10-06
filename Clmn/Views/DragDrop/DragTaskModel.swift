import UniformTypeIdentifiers

let TASK_UTI = UTType(APP_GROUP + ".task")!

class DragTaskModel: ObservableObject {
    @Published var task: (TaskGroup, Task)?

    // When task is moved between the owners (i.e. from one list to the another),
    // we need this action to remove the task from the previous container.
    var removeOnDrop: (_: Task) -> Void = { task in }

    func startDragOf(_ task: (TaskGroup, Task), removeOnDrop: @escaping (_: Task) -> Void = { task in }) -> NSItemProvider {
        self.task = task
        self.removeOnDrop = removeOnDrop
        return NSItemProvider(item: task.0.name as NSString, typeIdentifier: TASK_UTI.identifier)
    }

    func stopDrop() {
        task = nil
        removeOnDrop = { task in }
    }

}
