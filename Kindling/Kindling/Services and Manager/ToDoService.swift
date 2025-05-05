//
//  ToDoService.swift
//  Kindling
//
//  Created by Megan Wiemer on 5/3/25.
//

import SwiftData
import Foundation

protocol TaskService {
    func insert(_ item: ToDo) async
    func delete(_ item: ToDo) async
    func loadLocalTaskItems() async -> [ToDo]
    func fetchRemoteTaskItems() async throws
}

class DefaultToDoDataService: TaskService {
//    private let manager: TaskSwiftDataManager
    private let networkService: NetworkService

    init(
//        manager: TaskSwiftDataManager,
        networkService: NetworkService = DefaultNetworkService()
    ) {
//        self.manager = manager
        self.networkService = networkService
    }

    func insert(_ item: ToDo) async {
        Task {
//            await manager.insert(item)
        }
    }

    func delete(_ item: ToDo) async {
        Task {
//            await manager.delete(item)
        }
    }

    func loadLocalTaskItems() async -> [ToDo] {
        // Limitting to a hard-coded userId of 1 as filtering on other users would occur w/
        // a switch user functionality and introduction of some type of User
//        await manager.loadLocalTaskItems().filter { $0.userId == 1 }
        []
    }

    func fetchRemoteTaskItems() async throws {
        let remoteTasks = try await networkService.fetchRemoteTasks()
//        await manager.insert(remoteTasks)
    }
}
