//
//  ToDoManager.swift
//  Kindling
//
//  Created by Megan Wiemer on 5/3/25.
//

import SwiftData

class TodoSwiftDataManager {
    static let shared = TodoSwiftDataManager()

    var container: ModelContainer?
    var context: ModelContext?

    private init() {
        do {
            container = try ModelContainer(for: ToDoItem.self)
            if let container {
                context = ModelContext(container)
            }
        } catch {
            print(">>> Placeholder logo error: \(error)")
        }
    }
}
