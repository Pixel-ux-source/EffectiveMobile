//
//  TaskBuilder.swift
//  EffectiveMobile
//
//  Created by Алексей on 29.04.2025.
//

import Foundation

protocol TaskBuilderProtocol: AnyObject {
    static func build() -> TaskController
}

final class TaskBuilder: TaskBuilderProtocol {
    static func build() -> TaskController {
        let view = TaskController()
        let model = TaskDataManager.shared.fetchAll()
        let presenter = TaskPresenter(view: view, model: model)
        view.presenter = presenter
        return view
    }
}
