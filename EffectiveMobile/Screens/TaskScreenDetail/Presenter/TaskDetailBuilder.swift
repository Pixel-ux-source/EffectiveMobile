//
//  TaskDetailBuilder.swift
//  EffectiveMobile
//
//  Created by Алексей on 02.05.2025.
//

import UIKit

protocol TaskDetailBuilderProtocol: AnyObject {
    static func build(_ id: Int64, _ title: String, _ desc: String, _ date: String) -> TaskDetailController
}

final class TaskDetailBuilder: TaskDetailBuilderProtocol {
    static func build(_ id: Int64, _ title: String, _ desc: String, _ date: String) -> TaskDetailController {
        let view = TaskDetailController()
        let model = TaskDetailModel(id: id, todoTitle: title, todoDescription: desc, todoDate: date)
        let presenter = TaskDetailPresenter(view: view, model: model)
        view.presenter = presenter
        return view
    }
}
