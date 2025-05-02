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
        VStack {
            // TODO: Create file for textfield and add button that updates the todos in viewmodel
            TextField("Walk the cat", text: $viewModel.todoText)

            List {
                ForEach(viewModel.todos) { todoItem in
                    TodoListItem(todo: todoItem)
                        .listRowBackground(RoundedRectangle(cornerRadius: 12).fill(Color.secondaryBackground))
                }
                .onDelete(perform: viewModel.delete)
            }
            .listRowSpacing(4)
            .scrollContentBackground(.hidden)

        }
        .background(.primaryBackground)
        .navigationHeader()
    }
}

#Preview {
        TodoListView()
}
