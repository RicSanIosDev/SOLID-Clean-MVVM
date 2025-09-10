//
//  APIUserRepository.swift
//  SOLID Clean Arq
//
//  Created by ricardo sanchez on 10/9/25.
//

import Foundation

class APIUserRepository: UserRepository {
    private let apiClient: APIClient
    private let usersURL = URL(string: "https://jsonplaceholder.typicode.com/users")!

    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }

    func getUsers(completion: @escaping (Result<[User], Error>) -> Void) {
        apiClient.fetch(from: usersURL, completion: completion)
    }
}
