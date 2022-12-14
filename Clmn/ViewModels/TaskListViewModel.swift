import SwiftUI
import CoreData

class TaskListVM: ObservableObject {
    @Published private(set) var list: TaskList

    init(_ list: TaskList) {
        self.list = list
    }

    /// Adds a new task to the list or a group.
    func addNewTask(toGroup group: TaskGroup? = nil, _ name: String, note: String? = nil, color: Int = 0, progress: Int = 0, completed: Bool = false) {
        var task = Task(
            name: name.trim(),
            note: String.trimAndNil(note),
            color: color,
            completed: completed,
            progress: progress)
        if (completed) {
            task.completedAt = Date.now
        }
        let realGroup = group ?? list.groups[0]
        list.groups.with(realGroup) { g in
            list.groups[g].tasks.append(task)
        }
    }

    private func updateTask(_ task: Task, _ name: String, note: String? = nil, color: Int? = nil) {
        list.groups.with(task) { g, i in
            list.groups[g].tasks[i].name = name.trim()
            list.groups[g].tasks[i].note = String.trimAndNil(note)
            if (color != nil) {
                list.groups[g].tasks[i].color = color!
            }
        }
    }

    func addOrUpdateTask(group: TaskGroup, task: Task?, name: String, note: String?, color: Int) {
        if (task == nil) {
            addNewTask(toGroup: group, name, note: note, color: color)
        } else {
            updateTask(task!, name, note: note, color: color)
        }
    }

    /// Removes a task from the list.
    func deleteTask(_ task: Task) {
        list.groups.with(task) { g, i in
            list.groups[g].tasks.remove(at: i)
        }
    }

    /// Deletes all completed and canceled tasks.
    func deleteCompletedTasks() {
        for (i, _) in list.groups.enumerated() {
            list.groups[i].tasks.removeAll(where: { t in t.completed } )
        }
    }
    func deleteCanceledTasks() {
        for (i, _) in list.groups.enumerated() {
            list.groups[i].tasks.removeAll(where: { t in t.canceled() } )
        }
    }

    func insertTask(_ task: Task, before: Task) {
        list.groups.with(before) { g, i in
            list.groups[g].tasks.insert(task, at: i)
        }
    }

    func addTask(toGroup group: TaskGroup, task: Task) {
        list.groups.with(group) { g in
            list.groups[g].tasks.append(task)
        }
    }

    func addTaskToList(_ task: Task) {
        list.groups[0].tasks.append(task)
    }

    // ---------------------------------------------------------------- mutators

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

    func toggleCancel(_ task: Task) {
        list.groups.with(task) { g, i in
            var progress = list.groups[g].tasks[i].progress
            if (progress >= 0) {
                progress = -1
            }
            else {
                progress = 0
            }
            list.groups[g].tasks[i].progress = progress
        }
    }

    func toggleCompleted(_ task: Task) {
        list.groups.with(task) { g, i in
            var completed = list.groups[g].tasks[i].completed
            completed.toggle()
            list.groups[g].tasks[i].completedAt = completed ? Date.now : nil
            list.groups[g].tasks[i].progress = 0
            list.groups[g].tasks[i].completed = completed
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
        let group = TaskGroup(
            name: name.trim()
        )
        list.groups.append(group)
        return group
    }

    func deleteTaskGroup(_ taskGroup: TaskGroup) {
        list.groups.removeElement(taskGroup)
    }

    private func updateTaskGroup(_ taskGroup: TaskGroup, _ name: String) {
        list.groups.with(taskGroup) { index in
            list.groups[index].name = name.trim()
        }
    }

    func addOrUpdateTaskGroup(group: TaskGroup?, _ name: String) {
        if (group == nil) {
            addNewTaskGroup(name)
        } else {
            updateTaskGroup(group!, name)
        }
    }

    func reorder(source: TaskGroup, destination: TaskGroup) {
        let fromIndex = list.groups.firstIndex(of: source)
        let toIndex = list.groups.firstIndex(of: destination)
        guard (fromIndex != nil && toIndex != nil) else { return }
        list.groups.move(fromOffsets: [fromIndex!], toOffset: toIndex!)
    }

    // ---------------------------------------------------------------- parent VM

    func load(from lists: [TaskList]) {
        lists.with(list) { index in
            list = lists[index]
        }
    }
}
