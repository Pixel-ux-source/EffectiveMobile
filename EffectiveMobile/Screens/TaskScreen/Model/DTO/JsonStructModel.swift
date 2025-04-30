//
//  StructModel.swift
//  EffectiveMobile
//
//  Created by Алексей on 29.04.2025.
//

import Foundation

struct ResponseAPI: Codable {
    let todos: [Todo]
    let total: Int
    let skip: Int
    let limit: Int
}

struct Todo: Codable {
    let id: Int
    let todo: String
    let completed: Bool
    let userId: Int
}
