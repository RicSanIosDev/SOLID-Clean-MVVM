//
//  UserRepository.swift
//  SOLID Clean Arq
//
//  Created by ricardo sanchez on 10/9/25.
//

import Foundation

protocol UserRepository {
    func getUsers(completion: @escaping (Result<[User], Error>) -> Void)
}
