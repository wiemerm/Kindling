//
//  KindlingTests.swift
//  KindlingTests
//
//  Created by Megan Wiemer on 5/1/25.
//

import Foundation
import Testing
@testable import Kindling

struct TodoListViewViewModelTestSuite {
    let viewModel = TodoListViewModel()

    @Test func addTodoItemToList() async throws {
        // TODO: When removing the mocks make sure to update this to isEmpty to start
        #expect(viewModel.todos.count == 5)

        let newTodo = "todoItem".appendRandom()

        viewModel.addTodo(title: newTodo)

        #expect(viewModel.todos.count == 6)
        #expect(viewModel.todos.last?.title == newTodo)
    }

    @Test func removeTodoItemFromList() async throws {
        #expect(viewModel.todos.count == 5)

        let indexSet = IndexSet(integer: 0)

        viewModel.delete(at: indexSet)

        #expect(viewModel.todos.count == 4)
    }
}
