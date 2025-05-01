//
//  TodoListItem.swift
//  Kindling
//
//  Created by Megan Wiemer on 5/1/25.
//

import SwiftUI

struct TodoListItem: View {
    let text: String

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: "circle")
                .symbolRenderingMode(.hierarchical)
                .resizable()
                .foregroundStyle(Color.primaryAccent)
                .frame(width: 28, height: 28)

            Text(text)
                .font(.body)
                .foregroundStyle(Color.primaryText)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.vertical, 8)
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    VStack {
        TodoListItem(text: "Walk the cat")
        TodoListItem(text: "Walk the cat")
        TodoListItem(text: "Walk the cat")
        TodoListItem(text: "Walk the cat")
        Spacer()
    }
    .padding()
    .background(Color.primaryBackground)
}
