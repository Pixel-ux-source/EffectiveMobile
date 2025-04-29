//
//  ViewController.swift
//  EffectiveMobile
//
//  Created by Алексей on 29.04.2025.
//

import UIKit

final class TaskController: UIViewController {
    // MARK: – Instances
    
    // MARK: – Variables
    var presenter: TaskPresenterProtocol!
    var coordinator: AppCoordinator!

    // MARK: – Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        presenter.showData()
    }
    
    // MARK: – Configuration
    private func configureView() {
        view.backgroundColor = #colorLiteral(red: 0.01266666781, green: 0.01266666595, blue: 0.01266666781, alpha: 1)
    }
}

extension TaskController: TaskViewProtocol {
    func setData(_ model: [Todos]) {
        print("Change data success")
    }
}
