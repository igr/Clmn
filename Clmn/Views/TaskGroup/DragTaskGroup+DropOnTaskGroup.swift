import SwiftUI

struct DragTaskGroupDropOnTaskGroup: DropDelegate {
    var source: TaskGroup?
    var target: TaskGroup
    var reorder: (_: TaskGroup, _: TaskGroup) -> Void

    func performDrop(info: DropInfo) -> Bool {
        guard source != nil else {
            return false
        }
        guard info.hasItemsConforming(to: [TASKGROUP_UTI]) else {
            return false
        }
        let from : TaskGroup = source!

        if (from.id == target.id) {
            return false
        }

        reorder(from, target)

        return true
    }
}
