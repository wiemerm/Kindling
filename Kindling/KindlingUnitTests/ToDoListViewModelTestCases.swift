//
//  ToDoListViewModelTestCases.swift
//  KindlingTests
//
//  Created by Megan Wiemer on 5/5/25.
//

@testable import Kindling
import XCTest

final class ToDoListViewModelTestCases: XCTestCase {
    var mockTaskService: MockTaskService!
    var viewModel: TodoListViewModel!

    override func setUpWithError() throws {
        mockTaskService = MockTaskService()
        viewModel = TodoListViewModel(taskService: mockTaskService)
    }

    func test_onInit_loadTasks() async {
        XCTAssertEqual(mockTaskService.loadLocalTasksCallCount, 1)
    }

    func test_onSuccessfulLoad_updatesTasks() async {
        let tasksToReturn = [
            ToDo.mock(id: Int.random(in: 0..<100)),
            ToDo.mock(id: Int.random(in: 0..<100)),
            ToDo.mock(id: Int.random(in: 0..<100)),
            ToDo.mock(id: Int.random(in: 0..<100))
        ]

        mockTaskService.tasksToReturn = tasksToReturn
        await viewModel.fetchStoredTasks()

        XCTAssertEqual(mockTaskService.loadLocalTasksCallCount, 2)
        XCTAssertEqual(viewModel.tasks, tasksToReturn)
    }

    func test_onFailedLoad_doesNotUpdateTasks_showsError() async {
        mockTaskService.errorToReturn = .errorForTesting(message: "Fake error for testing")

        await viewModel.fetchStoredTasks()

        XCTAssertEqual(mockTaskService.loadLocalTasksCallCount, 2)
        XCTAssertTrue(viewModel.tasks.isEmpty)
        XCTAssertTrue(viewModel.showError)
    }

    func test_onFailedLoad_showsError_clearsOnRetry() async {
        mockTaskService.errorToReturn = .errorForTesting(message: "Fake error for testing")

        await viewModel.fetchStoredTasks()

        XCTAssertEqual(mockTaskService.loadLocalTasksCallCount, 2)
        XCTAssertTrue(viewModel.tasks.isEmpty)
        XCTAssertTrue(viewModel.showError)

        mockTaskService.errorToReturn = nil
        let tasksToReturn = [
            ToDo.mock(id: Int.random(in: 0..<100)),
            ToDo.mock(id: Int.random(in: 0..<100)),
            ToDo.mock(id: Int.random(in: 0..<100)),
            ToDo.mock(id: Int.random(in: 0..<100))
        ]

        mockTaskService.tasksToReturn = tasksToReturn

        await viewModel.fetchStoredTasks()

        XCTAssertEqual(mockTaskService.loadLocalTasksCallCount, 3)
        XCTAssertEqual(viewModel.tasks, tasksToReturn)
        XCTAssertFalse(viewModel.showError)
    }

    func test_addTodo_callsToService_andUpdatesOnResponse() async {
        let newTodoText = "New Todo Text"
        let expectation = XCTestExpectation(description: "Waiting for updates")

        withObservationTracking({
            _ = viewModel.tasks
        }, onChange: {
            Task { @MainActor in
                if !self.viewModel.tasks.isEmpty {
                    expectation.fulfill()
                }
            }
        })

        viewModel.addTodo(title: newTodoText)

        await fulfillment(of: [expectation], timeout: 1)
        XCTAssertEqual(mockTaskService.insertCallCount, 1)
        XCTAssertEqual(self.viewModel.tasks.count, 1)
        XCTAssertEqual(viewModel.tasks.first?.title, newTodoText)
    }

    func test_deleteAtIndexSet_callsToService_andUpdatesOnResponse() async {
        let indexSet: IndexSet = [0]
        let expectation = XCTestExpectation(description: "Waiting for updates")

        let tasksToReturn = [
            ToDo.mock(id: Int.random(in: 0..<100)),
            ToDo.mock(id: Int.random(in: 0..<100)),
            ToDo.mock(id: Int.random(in: 0..<100)),
            ToDo.mock(id: Int.random(in: 0..<100))
        ]

        mockTaskService.tasksToReturn = tasksToReturn

        await viewModel.fetchStoredTasks()

        withObservationTracking({
            _ = viewModel.tasks
        }, onChange: {
            Task { @MainActor in
                if self.viewModel.tasks.count < tasksToReturn.count {
                    XCTAssertEqual(self.viewModel.tasks.count, tasksToReturn.count - 1)
                    expectation.fulfill()
                }
            }
        })

        viewModel.delete(at: indexSet)

        await fulfillment(of: [expectation], timeout: 1)
        XCTAssertEqual(mockTaskService.deleteCallCount, 1)
    }

    func test_importTasks_callsThroughToService() async {
        let tasksToReturn = [
            ToDo.mock(id: Int.random(in: 0..<100)),
            ToDo.mock(id: Int.random(in: 0..<100)),
            ToDo.mock(id: Int.random(in: 0..<100)),
            ToDo.mock(id: Int.random(in: 0..<100))
        ]

        mockTaskService.tasksToReturn = tasksToReturn
        await viewModel.importTasks()

        XCTAssertEqual(mockTaskService.fetchRemoteTasksCallCount, 1)
        XCTAssertEqual(viewModel.tasks, tasksToReturn)
    }

    func test_onFailedImport_doesNotUpdateTasks_showsError() async {
        mockTaskService.errorToReturn = .errorForTesting(message: "Fake error for testing")

        await viewModel.importTasks()

        XCTAssertEqual(mockTaskService.fetchRemoteTasksCallCount, 1)
        XCTAssertTrue(viewModel.tasks.isEmpty)
        XCTAssertTrue(viewModel.showError)
    }

    func test_onFailedImport_showsError_clearsOnRetry() async {
        mockTaskService.errorToReturn = .errorForTesting(message: "Fake error for testing")

        await viewModel.importTasks()

        XCTAssertEqual(mockTaskService.fetchRemoteTasksCallCount, 1)
        XCTAssertTrue(viewModel.tasks.isEmpty)
        XCTAssertTrue(viewModel.showError)

        mockTaskService.errorToReturn = nil
        let tasksToReturn = [
            ToDo.mock(id: Int.random(in: 0..<100)),
            ToDo.mock(id: Int.random(in: 0..<100)),
            ToDo.mock(id: Int.random(in: 0..<100)),
            ToDo.mock(id: Int.random(in: 0..<100))
        ]

        mockTaskService.tasksToReturn = tasksToReturn

        await viewModel.importTasks()

        XCTAssertEqual(mockTaskService.fetchRemoteTasksCallCount, 2)
        XCTAssertEqual(viewModel.tasks, tasksToReturn)
        XCTAssertFalse(viewModel.showError)
    }
}
