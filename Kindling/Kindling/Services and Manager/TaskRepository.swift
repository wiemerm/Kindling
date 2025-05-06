//
//  ToDoManager.swift
//  Kindling
//
//  Created by Megan Wiemer on 5/3/25.
//

import SwiftData
import Foundation

protocol TaskRepository {
    func loadLocalItems() async throws -> [ToDo]
    func insert(_ items: [ToDo]) async throws
    func delete(_ item: ToDo) async throws
}

@ModelActor
actor DefaultTaskRepository: TaskRepository {
    private var context: ModelContext { modelExecutor.modelContext }

    func loadLocalItems() async throws -> [ToDo] {
        let fetchDescriptor = FetchDescriptor<ToDo>(sortBy: [SortDescriptor(\.id, order: .forward)])
        return try context.fetch(fetchDescriptor)
    }

    func insert(_ items: [ToDo]) async throws {
        for item in items {
            let id = item.id
            let predicate = #Predicate<ToDo> { $0.id == id }
            let count = try context.fetchCount(FetchDescriptor(predicate: predicate))

            if count == 0 {
                context.insert(item)
            }
        }
        try context.save()
    }

    func delete(_ item: ToDo) async throws {
        context.delete(item)
        try context.save()
    }
}
