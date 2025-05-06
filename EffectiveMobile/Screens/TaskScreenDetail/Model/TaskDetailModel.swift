//
//  TaskDetailModel.swift
//  EffectiveMobile
//
//  Created by Алексей on 02.05.2025.
//

import Foundation

final class TaskDetailModel {
    let id: Int64
    var todoTitle: String
    var todoDesc: String
    let todoDate: String
    
    init(id: Int64, todoTitle: String, todoDescription: String, todoDate: String) {
        self.id = id
        self.todoTitle = todoTitle
        self.todoDesc = todoDescription
        self.todoDate = todoDate
    }
}
