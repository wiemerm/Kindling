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
        List(viewModel.todos) { todoItem in
            TodoListItem(todo: todoItem)
                .listRowBackground(RoundedRectangle(cornerRadius: 12).fill(Color.secondaryBackground))
        }
        .listRowSpacing(4)
        .background(.primaryBackground)
        .scrollContentBackground(.hidden)
    }
}

#Preview {
    TodoListView()

}
