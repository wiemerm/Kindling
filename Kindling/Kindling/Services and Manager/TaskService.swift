//
//  ToDoService.swift
//  Kindling
//
//  Created by Megan Wiemer on 5/3/25.
//

import SwiftData
import Foundation

protocol TaskService {
    func insert(_ item: ToDo) async throws -> [ToDo]
    func delete(_ item: ToDo) async throws -> [ToDo]
    func loadLocalTasks() async throws -> [ToDo]
    func fetchRemoteTasks() async throws -> [ToDo]
}

class DefaultTaskService: TaskService {
    private let taskRepository: TaskRepository
    private let networkRepository: NetworkRepository

    init(
        taskRepository: TaskRepository = KindlingApp.shared.taskRepository,
        networkRepository: NetworkRepository = DefaultNetworkRepository()
    ) {
        self.taskRepository = taskRepository
        self.networkRepository = networkRepository
    }

    func loadLocalTasks() async throws -> [ToDo] {
        // Limiting to a hard-coded userId of 1 as filtering on other users would occur w/
        // a switch user functionality and introduction of some model of User
        try await taskRepository.loadLocalItems()
    }

    func insert(_ item: ToDo) async throws -> [ToDo] {
        try await taskRepository.insert([item])
        return try await loadLocalTasks()
    }

    func delete(_ item: ToDo) async throws -> [ToDo] {
        try await taskRepository.delete(item)
        return try await loadLocalTasks()
    }

    func fetchRemoteTasks() async throws -> [ToDo] {
        // For the sake of simplicity w/o there being different users only import userId 1
        let remoteTasks = try await networkRepository.fetchRemoteTasks()
            .filter { $0.userId == 1 }
        try await taskRepository.insert(remoteTasks)
        return try await taskRepository.loadLocalItems()
    }
}
