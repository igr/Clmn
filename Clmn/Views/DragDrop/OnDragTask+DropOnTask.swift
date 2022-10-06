import SwiftUI

struct DragTaskDropOnTask: DropDelegate {
    var source: DragTaskModel
    var target: (TaskGroup, Task)
    var appendToTarget: (_: Task) -> Void
    var reorder: (_: Task, _: Task) -> Void

    func performDrop(info: DropInfo) -> Bool {
        guard info.hasItemsConforming(to: [TASK_UTI]) else { return false }
        guard let origin = source.task else { return false }
        let originRemoveOnDrop = source.removeOnDrop
        source.stopDrop()

        let sourceTaskGroup = origin.0
        let sourceTask = origin.1

        let targetTaskGroup = target.0
        let targetTask = target.1

        if (sourceTask.id == targetTask.id) {
            return false
        }

        if (sourceTaskGroup.id == targetTaskGroup.id) {
            reorder(sourceTask, targetTask)
            return true
        }

        originRemoveOnDrop(sourceTask)
        appendToTarget(sourceTask)

        return true
    }
}
