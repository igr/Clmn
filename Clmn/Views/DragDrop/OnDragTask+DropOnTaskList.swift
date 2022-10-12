import SwiftUI

struct DragTaskDropOnTaskList: DropDelegate {
    var source: DragTaskModel
    var target: TaskList

    var append: (_: Task) -> Void

    func performDrop(info: DropInfo) -> Bool {
        guard info.hasItemsConforming(to: [TASK_UTI]) else { return false }
        guard let origin = source.task else { return false }
        let originRemoveOnDrop = source.removeOnDrop
        source.stopDrop()

        if (origin.0.id == target.id) {
            return false
        }

        originRemoveOnDrop(origin.2)
        append(origin.2)

        return true
    }
}
