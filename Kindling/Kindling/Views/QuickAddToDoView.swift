//
//  QuickAddItemView.swift
//  Kindling
//
//  Created by Megan Wiemer on 5/2/25.
//

import SwiftUI

struct QuickAddToDoView: View {
    let addAction: (String) -> Void
    @State var text = ""
    @FocusState private var isFocused: Bool

    var body: some View {
        HStack {
            TextField("Enter text...", text: $text)
                .focused($isFocused)
                .foregroundStyle(Color.primaryText)
                .padding(.horizontal, Spacing.small)
                .frame(
                    minWidth: TappableSize.minimum,
                    minHeight: TappableSize.minimum
                )
                .background {
                    RoundedRectangle(cornerRadius: CornerRadius.standard)
                        .fill(Color.secondaryBackground)
                }
                .onSubmit(submit)

            Button("Add", action: submit)
            .foregroundStyle(Color.primaryText)
            .padding(Spacing.extraSmall)
            .background {
                RoundedRectangle(cornerRadius: CornerRadius.standard)
                    .fill(Color.primaryAccent)
                    .frame(
                        minWidth: TappableSize.minimum,
                        minHeight: TappableSize.minimum
                    )
            }
        }
    }

    private func submit() {
        addAction(text)
        text = ""
        isFocused = false
    }
}

#Preview {
    QuickAddToDoView { _ in }
}
