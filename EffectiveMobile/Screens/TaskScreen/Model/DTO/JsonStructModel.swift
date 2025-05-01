//
//  StructModel.swift
//  EffectiveMobile
//
//  Created by Алексей on 29.04.2025.
//

import Foundation

struct ResponseAPI: Codable {
    let todos: [Todo]
    let total: Int64
    let skip: Int64
    let limit: Int64
}

struct Todo: Codable {
    let id: Int64
    let todo: String
    let completed: Bool
    let userId: Int64
    let createdAt: Date?
}
