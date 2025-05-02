//
//  TodoListViewModel.swift
//  Kindling
//
//  Created by Megan Wiemer on 5/1/25.
//

import SwiftUI

@Observable class TodoListViewModel {
    var todoText: String = ""

    private(set) var todos: [ToDoItem] = [
        ToDoItem.mock(),
        ToDoItem.mock(),
        ToDoItem.mock(),
        ToDoItem.mock(),
        ToDoItem.mock()
    ]

    func addTodo(title: String) {
        // TODO: userId could likely be deleted in this instance as there is no switching users, but verify this against the todo json first
        let newTodo = ToDoItem(id: todos.count, title: title, userId: 1)
        todos.append(newTodo)
    }

    func delete(at indexSet: IndexSet) {
        todos.remove(atOffsets: indexSet)
    }
}
