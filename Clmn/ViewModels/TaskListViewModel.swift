import SwiftUI

class TaskListVM: ObservableObject {
    @Published private(set) var list: TaskList

    init(_ list: TaskList) {
        self.list = list
    }

    /// Adds a new task to the list or a group.
    func addNewTask(toGroup group: TaskGroup? = nil, _ name: String, progress: Int = 0, completed: Bool = false) {
        let task = Task(name: name, completed: completed, progress: progress)
        let realGroup = group ?? list.groups[0]
        list.groups.with(realGroup) { g in
            list.groups[g].tasks.append(task)
        }
    }

    private func updateTask(_ task: Task, _ name: String) {
        list.groups.with(task) { g, i in
            list.groups[g].tasks[i].name = name
        }
    }

    func addOrUpdateTask(item: ModelPairOpt<TaskGroup, Task>, _ name: String) {
        item.new { group in
            addNewTask(toGroup: group, name)
        } existing: { group, task in
            updateTask(task, name)
        }
    }

    /// Removes a task from the list.
    func deleteTask(_ task: Task) {
        list.groups.with(task) { g, i in
            list.groups[g].tasks.remove(at: i)
        }
    }

    func insertTask(_ task: Task, before: Task) {
        list.groups.with(before) { g, i in
            list.groups[g].tasks.insert(task, at: i)
        }
    }

    func toggleProgress(_ task: Task) {
        list.groups.with(task) { g, i in
            var progress = list.groups[g].tasks[i].progress
            progress += 1
            if (progress == 3) {
                progress = 0
            }
            list.groups[g].tasks[i].progress = progress
        }
    }

    func addTask(toGroup group: TaskGroup, task: Task) {
        list.groups.with(group) { g in
            list.groups[g].tasks.append(task)
        }
    }

    func reorder(group: TaskGroup, source: Task, destination: Task) {
        let fromIndex = group.tasks.firstIndex(of: source)
        let toIndex = group.tasks.firstIndex(of: destination)
        guard (fromIndex != nil && toIndex != nil) else { return }
        list.groups.with(group) { g in
            list.groups[g].tasks.move(fromOffsets: [fromIndex!], toOffset: toIndex!)
        }
    }


    // ---------------------------------------------------------------- groups

    @discardableResult
    func addNewTaskGroup(_ name: String) -> TaskGroup {
        let group = TaskGroup(name: name)
        list.groups.append(group)
        return group
    }

    func deleteTaskGroup(_ taskGroup: TaskGroup) {
        list.groups.removeElement(taskGroup)
    }

    private func updateTaskGroup(_ taskGroup: TaskGroup, _ name: String) {
        list.groups.with(taskGroup) { index in
            list.groups[index].name = name
        }
    }

    func addOrUpdateTaskGroup(item: ModelOpt<TaskGroup>, _ name: String) {
        item.new {
            addNewTaskGroup(name)
        } existing: { taskGroup in
            updateTaskGroup(taskGroup, name)
        }
    }

    func reorder(source: TaskGroup, destination: TaskGroup) {
        let fromIndex = list.groups.firstIndex(of: source)
        let toIndex = list.groups.firstIndex(of: destination)
        guard (fromIndex != nil && toIndex != nil) else { return }
        list.groups.move(fromOffsets: [fromIndex!], toOffset: toIndex!)
    }

    // ----------------------------------------------------------------

    func load(from lists: [TaskList]) {
        lists.with(list) { index in
            list = lists[index]
        }
    }
}
