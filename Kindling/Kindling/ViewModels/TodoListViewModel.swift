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
    private(set) var todos = [ToDoItem]()
    private let dataSource: ToDoDataService

    init(dataSource: ToDoDataService) {
        self.dataSource = dataSource
        fetchStoredTodos()
    }

    func fetchStoredTodos() {
        Task {
            todos = await dataSource.loadAllToDoItems()
        }
    }

    func addTodo(title: String) {
        Task {
            // TODO: userId could likely be deleted in this instance as there is no switching users
            // but verify this against the todo json first
            let newTodo = ToDoItem(id: todos.count, title: title, userId: 1, completed: false)
            Task {
                await dataSource.insert(newTodo)
                fetchStoredTodos()
            }
        }
    }

    func delete(at indexSet: IndexSet) {
        indexSet.forEach { index in
            let todo = todos[index]
            Task {
                await dataSource.delete(todo)
                fetchStoredTodos()
            }
        }
    }
}
