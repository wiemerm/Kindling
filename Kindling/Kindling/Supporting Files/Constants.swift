//
//  Spacing.swift
//  Kindling
//
//  Created by Megan Wiemer on 5/2/25.
//

import Foundation

struct Spacing {
    static let extraExtraSmall: CGFloat = 4
    static let extraSmall: CGFloat = 8
    static let small: CGFloat = 12
    static let medium: CGFloat = 16
    static let large: CGFloat = 20
    static let extraLarge: CGFloat = 24
}

struct ImageSize {
    static let small: CGFloat = 24
    static let standard: CGFloat = 44
}

struct CornerRadius {
    static let standard: CGFloat = 12
}

struct TappableSize {
    static let minimum: CGFloat = 44
}

enum SystemImage: String {
    case flame
    case download
    case circleWithCheckmark
    case circle

    var systemName: String {
        switch self {
        case .flame: return "flame"
        case .download: return "square.and.arrow.down"
        case .circle: return "circle"
        case .circleWithCheckmark: return "checkmark.circle.fill"
        }
    }
}
