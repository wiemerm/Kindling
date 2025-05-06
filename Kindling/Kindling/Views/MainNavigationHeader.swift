//
//  MainNavigationHeader.swift
//  Kindling
//
//  Created by Megan Wiemer on 5/1/25.
//

import SwiftUI

struct MainNavigationHeader: View {
    var body: some View {
        HStack(spacing: Spacing.extraExtraSmall) {
            Image(systemName: SystemImage.flame.systemName)
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
                .frame(width: ImageSize.small, height: ImageSize.small)

            Text("Kindling")
                .font(.title)
                .foregroundStyle(Color.primaryAccent)
        }
    }
}

#Preview {
    MainNavigationHeader()
}
