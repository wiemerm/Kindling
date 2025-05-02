//
//  QuickAddItemView.swift
//  Kindling
//
//  Created by Megan Wiemer on 5/2/25.
//

import SwiftUI

// TODO: Desireable behavior to resign textfield when tapping outside of it anywhere else on screen
struct QuickAddToDoView: View {
    let addAction: (String) -> Void
    @State var text = ""

    var body: some View {
        HStack {
            TextField("Enter text...", text: $text)
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
                .onSubmit { addAction(text) }

            Button("Add") {
                addAction(text)
            }
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
}

#Preview {
    QuickAddToDoView { _ in }
}
