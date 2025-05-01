//
//  TodoListItem.swift
//  Kindling
//
//  Created by Megan Wiemer on 5/1/25.
//

import SwiftUI

struct TodoListItem: View {
    let todo: ToDoItem

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: todo.completed ? "checkmark.circle.fill" : "circle")
                .symbolRenderingMode(.hierarchical)
                .resizable()
                .foregroundStyle(Color.primaryAccent)
                .frame(width: 28, height: 28)

            Text(todo.title)
                .font(.body)
                .strikethrough(todo.completed)
                .foregroundStyle(Color.primaryText)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.vertical, 8)
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    VStack {
        TodoListItem(todo: ToDoItem.mock(title: "Walk the cat", completed: false))
        TodoListItem(todo: ToDoItem.mock(title: "Walk the cat", completed: true))
    }
    .padding()
    .background(Color.primaryBackground)
}
