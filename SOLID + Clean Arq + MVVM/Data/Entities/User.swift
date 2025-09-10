//
//  User.swift
//  SOLID Clean Arq
//
//  Created by ricardo sanchez on 10/9/25.
//

import Foundation

struct User: Identifiable, Decodable {
    let id: Int
    let name: String
    let email: String
}
