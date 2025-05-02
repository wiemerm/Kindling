//
//  Mocks.swift
//  Kindling
//
//  Created by Megan Wiemer on 5/2/25.
//

extension String {
    func appendRandom() -> String {
        "\(self)-\(Int.random(in: 0..<1000))"
    }
}
