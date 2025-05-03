//
//  ToDoItem.swift
//  Kindling
//
//  Created by Megan Wiemer on 5/1/25.
//

import SwiftData

@Model
class ToDoItem: Decodable, Identifiable {
    enum CodingKeys: CodingKey {
        case id
        case title
        case userId
        case completed
    }

    var id: Int
    var title: String
    var userId: Int
    var completed: Bool

    init(id: Int, title: String, userId: Int, completed: Bool) {
        self.id = id
        self.title = title
        self.userId = userId
        self.completed = completed
    }

    required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
        userId = try container.decode(Int.self, forKey: .userId)
        completed = try container.decode(Bool.self, forKey: .completed)
    }
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
