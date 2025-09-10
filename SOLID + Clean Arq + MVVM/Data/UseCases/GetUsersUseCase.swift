//
//  GetUsersUseCase.swift
//  SOLID Clean Arq
//
//  Created by ricardo sanchez on 10/9/25.
//

import Foundation

class GetUsersUseCase {
    private let repository: UserRepository

    init(repository: UserRepository) {
        self.repository = repository
    }

    func execute(completion: @escaping (Result<[User], Error>) -> Void) {
        repository.getUsers(completion: completion)
    }
}
