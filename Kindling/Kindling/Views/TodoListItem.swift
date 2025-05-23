//
//  TodoListItem.swift
//  Kindling
//
//  Created by Megan Wiemer on 5/1/25.
//

import SwiftUI

struct TodoListItem: View {
    let todo: ToDo

    var body: some View {
        HStack(spacing: Spacing.small) {
            Image(
                systemName: todo.completed ?
                SystemImage.circleWithCheckmark.systemName :
                    SystemImage.circle.systemName
            )
            .symbolRenderingMode(.hierarchical)
            .resizable()
            .foregroundStyle(Color.primaryAccent)
            .frame(width: ImageSize.small, height: ImageSize.small)
            .onTapGesture {
                todo.completed.toggle()
            }

            Text(todo.title)
                .font(.body)
                .strikethrough(todo.completed)
                .foregroundStyle(Color.primaryText)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.vertical, Spacing.extraSmall)
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    VStack {
        TodoListItem(todo: ToDo.mock(title: "Walk the cat", completed: false))
        TodoListItem(todo: ToDo.mock(title: "Walk the cat", completed: true))
    }
    .padding()
    .background(Color.primaryBackground)
}
