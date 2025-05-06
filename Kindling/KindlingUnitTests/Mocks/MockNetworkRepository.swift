//
//  MockNetworkRepository.swift
//  Kindling
//
//  Created by Megan Wiemer on 5/5/25.
//

@testable import Kindling

class MockNetworkRepository: NetworkRepository {
    private(set) var fetchTasksCallCount = 0
    var errorToThrow: Error?
    var tasksToReturn = [ToDo]()

    func fetchRemoteTasks() async throws -> [ToDo] {
        fetchTasksCallCount += 1

        if let errorToThrow {
            throw errorToThrow
        }

        return tasksToReturn
    }

}
