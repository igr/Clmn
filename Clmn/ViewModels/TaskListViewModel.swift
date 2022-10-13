import SwiftUI
import CoreData

class TaskListVM: ObservableObject {
    @Published private(set) var list: TaskList

    init(_ list: TaskList) {
        self.list = list
    }

    /// Adds a new task to the list or a group.
    func addNewTask(toGroup group: TaskGroup? = nil, _ name: String, color: Int = 0, progress: Int = 0, completed: Bool = false) {
        var task = Task(name: name, color: color, completed: completed, progress: progress)
        if (completed) {
            task.completedAt = Date.now
        }
        let realGroup = group ?? list.groups[0]
        list.groups.with(realGroup) { g in
            list.groups[g].tasks.append(task)
        }
    }

    private func updateTask(_ task: Task, _ name: String, color: Int? = nil) {
        list.groups.with(task) { g, i in
            list.groups[g].tasks[i].name = name
            if (color != nil) {
                list.groups[g].tasks[i].color = color!
            }
        }
    }

    func addOrUpdateTask(group: TaskGroup, task: Task?, _ name: String, _ color: Int) {
        if (task == nil) {
            addNewTask(toGroup: group, name, color: color)
        } else {
            updateTask(task!, name, color: color)
        }
    }

    /// Removes a task from the list.
    func deleteTask(_ task: Task) {
        print("delete task")
        list.groups.with(task) { g, i in
            print("delete task!!! \(i)")
            list.groups[g].tasks.remove(at: i)
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
            if (completed == false) {
                list.groups[g].tasks[i].progress = 0
                list.groups[g].tasks[i].completedAt = nil
            } else {
                list.groups[g].tasks[i].completedAt = Date.now
            }
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
