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
    private(set) var todos = [ToDo]()
    private let service: TaskService

    init(dataSource: TaskService) {
        self.service = dataSource
        fetchStoredTasks()
    }

    func fetchStoredTasks() {
        Task {
            todos = await service.loadLocalTaskItems()
        }
    }

    func addTodo(title: String) {
        // For the sake of example limiting to userId 1
        // This would change when supporting switching users as json includes more than userId: 1
        let newTodo = ToDo(id: todos.count, title: title, userId: 1, completed: false)
        Task {
            await service.insert(newTodo)
            fetchStoredTasks()
        }
    }

    func delete(at indexSet: IndexSet) {
        indexSet.forEach { index in
            let todo = todos[index]
            Task {
                await service.delete(todo)
                fetchStoredTasks()
            }
        }
    }

    func importTasks() {
        Task {
            do {
                try await service.fetchRemoteTaskItems()
                fetchStoredTasks()
            } catch {
                print(">>> Failure to fetch and update tasks: \(error.localizedDescription)")
                // Would want to handle error here, propogating it to end user
            }
        }
    }
}
