import SwiftUI

struct DragTaskGroupDropOnTaskGroup: DropDelegate {
    var source: DragTaskGroupModel
    var target: (TaskList, TaskGroup)
    var reorder: (_: TaskGroup, _: TaskGroup) -> Void

    func performDrop(info: DropInfo) -> Bool {
        guard info.hasItemsConforming(to: [TASKGROUP_UTI]) else { return false }
        guard let origin = source.group else { return false }
        source.stopDrop()

        // accept only groups within the same tasklist
        if (origin.0.id != target.0.id) {
            return false
        }

        let sourceGroup = origin.1
        let targetGroup = target.1

        if (sourceGroup.id == targetGroup.id) {
            return false
        }

        reorder(sourceGroup, targetGroup)

        return true
    }
}
