//
//  NetworkService.swift
//  Kindling
//
//  Created by Megan Wiemer on 5/3/25.
//

import Foundation

protocol NetworkService {
    func fetchRemoteTasks() async throws -> [ToDo]
}

struct DefaultNetworkService: NetworkService {
    let client: APIClient

    init(client: APIClient = APIClient.shared) {
        self.client = client
    }

    func fetchRemoteTasks() async throws -> [ToDo] {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/todos") else {
            throw APIError.invalidURL
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        return try await client.send(request)
    }
}
