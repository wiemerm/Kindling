//
//  ToDoManager.swift
//  Kindling
//
//  Created by Megan Wiemer on 5/3/25.
//

import SwiftData
import Foundation

protocol ModelContextProtocol {
    func fetch<T>(_ fetchDescriptor: FetchDescriptor<T>) throws -> [T] where T: PersistentModel
    func insert<T>(_ model: T) where T: PersistentModel
    func delete<T>(_ model: T) where T: PersistentModel
    func save() throws
}

protocol TaskRepository {
    func loadLocalItems() async throws -> [ToDo]
    func insert(_ item: ToDo) async throws
    func delete(_ item: ToDo) async throws
}

actor DefaultTaskRepository: TaskRepository {
    private let context: ModelContextProtocol

    init(context: ModelContextProtocol) {
        self.context = context
    }

    func loadLocalItems() async throws -> [ToDo] {
        let fetchDescriptor = FetchDescriptor<ToDo>(sortBy: [SortDescriptor(\.id, order: .forward)])
        return try context.fetch(fetchDescriptor)
    }

    func insert(_ item: ToDo) async throws {
        context.insert(item)
        try context.save()
    }

    func delete(_ item: ToDo) async throws {
        context.delete(item)
        try context.save()
    }
}
