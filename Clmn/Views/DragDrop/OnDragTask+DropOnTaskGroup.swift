import SwiftUI

struct DragTaskDropOnTaskGroup: DropDelegate {
    var source: DragTaskModel
    var target: TaskGroup
    var append: (_: TaskGroup, _: Task) -> Void

    func performDrop(info: DropInfo) -> Bool {
        guard info.hasItemsConforming(to: [TASK_UTI]) else { return false }
        guard let origin = source.task else { return false }
        let originRemoveOnDrop = source.removeOnDrop
        source.stopDrop()

        let sourceTaskGroup = origin.0
        let sourceTask = origin.1

        // source and target group are the same, nothing to do
        if (sourceTaskGroup.id == target.id) {
            return false
        }

        originRemoveOnDrop(sourceTask)
        append(target, sourceTask)

        return true
    }
}
