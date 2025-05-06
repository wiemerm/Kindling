//
//  TodoListViewModel.swift
//  Kindling
//
//  Created by Megan Wiemer on 5/1/25.
//

import SwiftData
import SwiftUI

@Observable
class TodoListViewModel {
    private(set) var tasks = [ToDo]()
    // Better yet have error able to create its own messaging for display and set it rather than Bool
    private(set) var showError = false

    private let taskService: TaskService

    init(taskService: TaskService = DefaultTaskService()) {
        self.taskService = taskService

        Task {
            await fetchStoredTasks()
        }
    }

    func fetchStoredTasks() async {
        showError = false
            do {
                tasks = try await taskService.loadLocalTasks()
            } catch {
                showError = true
            }
    }

    func addTodo(title: String) {
        Task {
            showError = false
            do {
                // For the sake of simplicity for this assuming 1 user and only using userId: 1
                let newTodo = ToDo(id: abs(UUID().hashValue), title: title, userId: 1, completed: false)
                tasks = try await taskService.insert(newTodo)
            } catch {
                showError = true
            }
        }
    }

    func delete(at indexSet: IndexSet) {
        guard !tasks.isEmpty else { return }

        indexSet.forEach { index in
            let taskToDelete = tasks[index]
            Task {
                showError = false
                do {
                    tasks = try await taskService.delete(taskToDelete)
                } catch {
                    showError = true
                }
            }
        }
    }

    func importTasks() async {
        do {
            showError = false
            tasks = try await taskService.fetchRemoteTasks()
        } catch {
            showError = true
        }
    }
}
