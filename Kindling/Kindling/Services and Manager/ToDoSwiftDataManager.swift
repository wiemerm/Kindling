//
//  ToDoManager.swift
//  Kindling
//
//  Created by Megan Wiemer on 5/3/25.
//

import SwiftData
import Foundation

@MainActor
class TaskSwiftDataManager {
    static let shared = TaskSwiftDataManager()

    var container: ModelContainer?
    var context: ModelContext?

    private init() {
        do {
            container = try ModelContainer(for: ToDo.self)
            if let container {
                context = ModelContext(container)
            }
        } catch {
            print(">>> Placeholder logo error: \(error)")
        }
    }

    func insert(_ item: ToDo) {
        container?.mainContext.insert(item)
        do {
            try container?.mainContext.save()
        } catch {
            print(">>> Log Error Saving ToDo: \(error)")
        }
    }

    func insert(_ items: [ToDo]) {
        for item in items {
            container?.mainContext.insert(item)
        }

        do {
            try container?.mainContext.save()
        } catch {
            print(">>>> Logging error saving multiple loaded TODOs: \(error)")
        }
    }

    func delete(_ item: ToDo) {
        self.container?.mainContext.delete(item)
        do {
            try self.container?.mainContext.save()
        } catch {
            print(">>> Log Error Deleting ToDoItem: \(error)")
        }
    }

    func loadLocalTaskItems() -> [ToDo] {
        let fetchDescriptor = FetchDescriptor<ToDo>(sortBy: [SortDescriptor(\.id, order: .forward)])
        do {
            let items = try container?.mainContext.fetch(fetchDescriptor)
            return items ?? []
        } catch {
            print(">>> Log Error Loading ToDoItems: \(error)")
            return []
        }
    }
}
