//
//  TodoListView.swift
//  Kindling
//
//  Created by Megan Wiemer on 5/1/25.
//

import SwiftUI

struct TodoListView: View {
    let tempList = ["Buy cat food", "Learn SwiftUI", "Go for a walk"]

    var body: some View {
        List(tempList, id: \.self) { todoItem in
            TodoListItem(text: todoItem)
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
