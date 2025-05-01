//
//  ContentView.swift
//  Kindling
//
//  Created by Megan Wiemer on 5/1/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            TodoListView()
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        MainNavigationHeader()
                    }
                }
        }
    }
}

#Preview {
    ContentView()
}
