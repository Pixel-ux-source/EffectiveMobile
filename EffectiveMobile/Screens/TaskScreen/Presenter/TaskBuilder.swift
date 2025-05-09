//
//  TaskBuilder.swift
//  EffectiveMobile
//
//  Created by Алексей on 29.04.2025.
//

import Foundation

protocol TaskBuilderProtocol: AnyObject {
    static func build(_ completion: @escaping(TaskController) -> ())
}

final class TaskBuilder: TaskBuilderProtocol {
    static func build(_ completion: @escaping (TaskController) -> ()) {
        let view = TaskController()
        TaskDataManager.shared.fetchAll { model in
            let presenter = TaskPresenter(view: view, model: model)
            view.presenter = presenter
            completion(view)
        }
    }
}
