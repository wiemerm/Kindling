//
//  NavigationHeader.swift
//  Kindling
//
//  Created by Megan Wiemer on 5/1/25.
//

import SwiftUI

extension View {
    func navigationHeader(importHandler: (() -> Void)? = nil) -> some View {
        NavigationStack {
            self
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        MainNavigationHeader()
                    }

                    if let importHandler {
                        ToolbarItem(placement: .topBarTrailing) {
                            Button {
                                importHandler()
                            } label: {
                                Image(systemName: SystemImage.download.systemName)
                                    .tint(.primaryAccent)
                            }
                        }
                    }
                }
        }
    }
}

#Preview {
   TodoListView()
}
