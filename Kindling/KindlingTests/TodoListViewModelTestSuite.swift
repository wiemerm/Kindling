//
//  KindlingTests.swift
//  KindlingTests
//
//  Created by Megan Wiemer on 5/1/25.
//

import Foundation
import Testing
@testable import Kindling

@MainActor
struct TodoListViewViewModelTestSuite {
    var mockDataService = MockToDoDataService()
    var viewModel: TodoListViewModel

    init() {
        viewModel = TodoListViewModel(dataSource: mockDataService)
    }

    @Test func addTodoItemToList() async throws {
        #expect(viewModel.todos.isEmpty)

        let newTodo = "todoItem".appendRandom()

        viewModel.addTodo(title: newTodo)

        try? await Task.sleep(for: .seconds(1)) // TODO: Get rid of this!

        #expect(viewModel.todos.count == 1)
        #expect(viewModel.todos.last?.title == newTodo)
    }

    @Test func removeTodoItemFromList() async throws {
        #expect(viewModel.todos.isEmpty)

        viewModel.addTodo(title: "new item")

        try? await Task.sleep(for: .seconds(1)) // TODO: Get rid of this!
        #expect(viewModel.todos.count == 1)

        let indexSet = IndexSet(integer: 0)

        viewModel.delete(at: indexSet)

        try? await Task.sleep(for: .seconds(1)) // TODO: Get rid of this!

        #expect(viewModel.todos.isEmpty)
    }
}

class MockToDoDataService: ToDoDataService {
    private(set) var todoItems = [ToDoItem]()

    func loadAllToDoItems() async -> [ToDoItem] {
        todoItems
    }

    func insert(_ item: ToDoItem) {
        todoItems.append(item)
    }

    func delete(_ item: ToDoItem) {
        todoItems.removeAll { $0.id == item.id }
    }
}
