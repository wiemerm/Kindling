//
//  TodoListViewModel.swift
//  Kindling
//
//  Created by Megan Wiemer on 5/1/25.
//

import SwiftUI

@Observable class TodoListViewModel {
    let todos: [ToDoItem] = [
        ToDoItem.mock(),
        ToDoItem.mock(),
        ToDoItem.mock(),
        ToDoItem.mock(),
        ToDoItem.mock()
    ]
}
