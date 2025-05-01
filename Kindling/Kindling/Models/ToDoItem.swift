//
//  ToDoItem.swift
//  Kindling
//
//  Created by Megan Wiemer on 5/1/25.
//

struct ToDoItem: Codable, Identifiable {
    let id: Int
    let title: String
    let userId: Int
    var completed: Bool
}

#if DEBUG
extension ToDoItem {
    static func mock(
        id: Int = Int.random(in: 0..<1000),
        title: String = "Todo Item",
        userId: Int = 1,
        completed: Bool = false
    ) -> ToDoItem {
        ToDoItem(
            id: id,
            title: title,
            userId: userId,
            completed: completed
        )
    }
}
#endif
