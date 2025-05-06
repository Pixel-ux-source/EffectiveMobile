//
//  EnumTodosUpdate.swift
//  EffectiveMobile
//
//  Created by Алексей on 05.05.2025.
//

import Foundation

enum EnumTodosUpdate {
    case title(String)
    case desc(String)
    case completed(Bool)
    
    var apply: (Todos) -> () {
        switch self {
        case .title(let value):
            return { $0.title = value }
        case .desc(let value):
            return { $0.desc = value }
        case .completed(let value):
            return { $0.completed = value }
        }
    }
}
