//
//  TodoListView.swift
//  Kindling
//
//  Created by Megan Wiemer on 5/1/25.
//

import SwiftUI

struct TodoListView: View {
    @State private var viewModel = TodoListViewModel()

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            QuickAddToDoView(addAction: viewModel.addTodo(title:))
                .padding(.horizontal, Spacing.large)
            List {
                ForEach(viewModel.todos) { todoItem in
                    TodoListItem(todo: todoItem)
                        .listRowBackground(
                            RoundedRectangle(cornerRadius: Spacing.small)
                                .fill(Color.secondaryBackground)
                        )
                }
                .onDelete(perform: viewModel.delete)
            }
            .listRowSpacing(Spacing.extraSmall)
            .scrollContentBackground(.hidden)
        }
        .background(.primaryBackground)
        .navigationHeader()
    }
}

#Preview {
        TodoListView()
}
