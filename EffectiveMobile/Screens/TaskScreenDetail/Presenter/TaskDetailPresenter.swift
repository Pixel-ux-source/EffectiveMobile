//
//  TaskDetailPresenter.swift
//  EffectiveMobile
//
//  Created by Алексей on 02.05.2025.
//

import UIKit

protocol TaskDetailViewProtocol: AnyObject {
    func setData(model: TaskDetailModel)
}

protocol TaskDetailPresenterProtocol {
    init(view: TaskDetailController, model: TaskDetailModel)
    func showData()
}

final class TaskDetailPresenter: TaskDetailPresenterProtocol {
    private let view: TaskDetailController
    private let model: TaskDetailModel
    
    init(view: TaskDetailController, model: TaskDetailModel) {
        self.view = view
        self.model = model
    }
    
    func showData() {
        view.setData(model: model)
    }
    
    
}
