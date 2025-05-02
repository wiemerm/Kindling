//
//  NavigationHeader.swift
//  Kindling
//
//  Created by Megan Wiemer on 5/1/25.
//

import SwiftUI

extension View {
    func navigationHeader() -> some View {
        NavigationStack {
            self
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        MainNavigationHeader()
                    }

                    ToolbarItem(placement: .topBarTrailing) {
                        Button(
                            action: {
                                print("Import")
                            },
                            label: {
                                Image(systemName: "square.and.arrow.down")
                                    .tint(.primaryAccent)
                            })
                    }
                }
        }
    }
}

#Preview {
   TodoListView()
}
