//
//  MainNavigationHeader.swift
//  Kindling
//
//  Created by Megan Wiemer on 5/1/25.
//

import SwiftUI

struct MainNavigationHeader: View {
    var body: some View {
        HStack(spacing: 4) {
            Image(systemName: "flame")
                .symbolRenderingMode(.hierarchical)
                .resizable()

                .foregroundStyle(
                    LinearGradient(
                        colors: [
                        .secondaryAccent,
                            .primaryAccent,
                            .highlight
                    ],
                        startPoint: .bottom,
                        endPoint: .top
                    )
                )
                .frame(width: 44, height: 44)

            Text("Kindling")
                .font(.largeTitle)
                .foregroundStyle(Color.primaryAccent)
        }
        .padding(.top, 20)
    }
}

#Preview {
    MainNavigationHeader()
}
