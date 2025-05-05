//
//  ToDoService.swift
//  Kindling
//
//  Created by Megan Wiemer on 5/3/25.
//

import SwiftData
import Foundation

protocol TaskService {
    func insert(_ item: ToDo) async throws
    func delete(_ item: ToDo) async throws
    func loadLocalTasks() async throws -> [ToDo]
    func fetchRemoteTasks() async throws
}

class DefaultTaskService: TaskService {
    private let taskRepository: TaskRepository
//    private let networkService: NetworkService

    init(taskRepository: TaskRepository) {
        self.taskRepository = taskRepository
    }

    func loadLocalTasks() async throws -> [ToDo] {
        // Limitting to a hard-coded userId of 1 as filtering on other users would occur w/
        // a switch user functionality and introduction of some type of User
        //        await manager.loadLocalTaskItems().filter { $0.userId == 1 }
        try await taskRepository.loadLocalItems()
    }

    func insert(_ item: ToDo) async throws {
        try await taskRepository.insert(item)
    }

    func delete(_ item: ToDo) async throws {
        try await taskRepository.delete(item)
    }

    func fetchRemoteTasks() async throws {
//        let remoteTasks = try await networkService.fetchRemoteTasks()
//        await manager.insert(remoteTasks)
    }
}
