//
//  TaskPresenter.swift
//  EffectiveMobile
//
//  Created by Алексей on 29.04.2025.
//

import Foundation

protocol TaskViewProtocol: AnyObject {
    func setData(_ model: [Todos])
}

protocol TaskPresenterProtocol: AnyObject {
    init(view: TaskViewProtocol, model: [Todos])
    func showData()
}

final class TaskPresenter: TaskPresenterProtocol {
    private let view: (TaskViewProtocol)
    private let model: [Todos]
    
    init(view: TaskViewProtocol, model: [Todos]) {
        self.view = view
        self.model = model
    }
    
    func showData() {
        view.setData(model)
    }
}
