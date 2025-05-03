//
//  ToDoService.swift
//  Kindling
//
//  Created by Megan Wiemer on 5/3/25.
//

import SwiftData
import Foundation

protocol ToDoDataService {
    func insert(_ item: ToDoItem) async
    func delete(_ item: ToDoItem) async
    func loadAllToDoItems() async -> [ToDoItem]
}

class DefaultToDoDataService: ToDoDataService {
    private let container: ModelContainer?
    private let context: ModelContext?

    init(manager: TodoSwiftDataManager = .shared) {
        self.container = manager.container
        self.context = manager.context
    }

    func insert(_ item: ToDoItem) async {
        await MainActor.run {
            self.container?.mainContext.insert(item)
            do {
                try self.container?.mainContext.save()
            } catch {
                print(">>> Log Error Saving ToDoItem: \(error)")
            }
        }
    }

    func delete(_ item: ToDoItem) async {
        await MainActor.run {
            self.container?.mainContext.delete(item)
            do {
                try self.container?.mainContext.save()
            } catch {
                print(">>> Log Error Deleting ToDoItem: \(error)")
            }
        }
    }

    func loadAllToDoItems() async -> [ToDoItem] {
        await MainActor.run {
            let fetchDescriptor = FetchDescriptor<ToDoItem>(sortBy: [SortDescriptor(\.id, order: .forward)])
            do {
                let items = try self.container?.mainContext.fetch(fetchDescriptor)
                return items ?? []
            } catch {
                print(">>> Log Error Loading ToDoItems: \(error)")
                return []
            }
        }
    }
}
