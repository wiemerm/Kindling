//
//  KindlingApp.swift
//  Kindling
//
//  Created by Megan Wiemer on 5/1/25.
//

import SwiftData
import SwiftUI

@main
struct KindlingApp: App {
    static let shared: KindlingApp = .init()
    private let container: ModelContainer
    var taskRepository: TaskRepository {
        DefaultTaskRepository(modelContainer: container)
    }

    var body: some Scene {

        WindowGroup {
            ContentView()
        }
    }

    init() {
        do {
            container = try ModelContainer(for: ToDo.self)
        } catch {
            fatalError("Failed to create ModelContainer for ToDo items required for running.")
        }
    }
}
