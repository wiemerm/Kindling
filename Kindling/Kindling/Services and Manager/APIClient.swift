//
//  APIClient.swift
//  Kindling
//
//  Created by Megan Wiemer on 5/3/25.
//

import Foundation

struct APIClient {
    static let shared = APIClient()

    private init() { }

    func send<T: Decodable>(_ request: URLRequest) async throws -> T {
        let (data, response) = try await URLSession.shared.data(for: request)
        return try JSONDecoder().decode(T.self, from: data)
    }
}

enum APIError: Error {
    case invalidURL
    case invalidResponse
    case decodingFailed
}
