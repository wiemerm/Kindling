//
//  TaskRepositoryTestCase.swift
//  KindlingTests
//
//  Created by Megan Wiemer on 5/5/25.
//

@testable import Kindling
import XCTest

final class TaskRepositoryTestCase: XCTestCase {
    var context: MockModelContext!
    var repository: DefaultTaskRepository!

    override func setUpWithError() throws {
        context = MockModelContext()
        repository = DefaultTaskRepository(context: context)
    }

    func test_loadLocalItems_callsThroughToContext() async throws {
        let expectedTasks = [ToDo.mock(id: 1), ToDo.mock(id: 2)]
        context.tasksToReturn = expectedTasks

        let tasks = try await repository.loadLocalItems()
        XCTAssertEqual(context.fetchCallCount, 1)
        XCTAssertEqual(tasks, expectedTasks)
    }

    func test_insert_callsThroughToContext_toInsertAndSave() async throws {
        let toDoToSave = ToDo.mock(id: Int.random(in: 0..<99))

        try await repository.insert(toDoToSave)
        XCTAssertEqual(context.insertCallCount, 1)
        XCTAssertEqual(context.saveCallCount, 1)
    }

    func test_delete_callThroughToContext_toDeleteAndSave() async throws {
        let toDoToSave = ToDo.mock(id: Int.random(in: 0..<99))
        let toDoToDelete = ToDo.mock(id: Int.random(in: 0..<99))

        try await repository.insert(toDoToSave)
        try await repository.insert(toDoToSave)
        XCTAssertEqual(context.insertCallCount, 2)
        XCTAssertEqual(context.saveCallCount, 2)

        try await repository.delete(toDoToDelete)
        XCTAssertEqual(context.deleteCallCount, 1)
        XCTAssertEqual(context.saveCallCount, 3)
    }
}
