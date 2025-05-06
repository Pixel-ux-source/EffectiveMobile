//
//  TaskDetailController.swift
//  EffectiveMobile
//
//  Created by Алексей on 02.05.2025.
//

import UIKit
import SnapKit

final class TaskDetailController: UIViewController {
    // MARK: – Instance's
    private let scrollView = UIScrollView()
    private let contentView = DetailView()
    
    // MARK: – Variable's
    var presenter: TaskDetailPresenterProtocol!
    var coordinator: AppCoordinator!
    var model: TaskDetailModel?
    
    // MARK: – Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.showData()
        setupUI()
        configureKeyboard()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        updateModel()
    }
    
    // MARK: – Update Model
    private func updateModel() {
        guard let title = model?.todoTitle.trimmingCharacters(in: .whitespacesAndNewlines),
              let desc = model?.todoDesc.trimmingCharacters(in: .whitespacesAndNewlines),
              !title.isEmpty && !desc.isEmpty else { return }
        guard let id = model?.id else { return }

        if id == 0 {
            TaskDataManager.shared.createNewData(title: title, desc: desc)
            coordinator.reloadTaskController()
        } else {
            TaskDataManager.shared.update(with: id, on: [.title(title), .desc(desc)])
            coordinator.reloadTaskController()
        }
    }
    
    // MARK: – Configuration's
    private func configureKeyboard() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    // MARK: – Setup's
    private func setupUI() {
        setupScrollView()
    }
        
    private func setupScrollView() {
        view.addSubview(scrollView)

        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
                
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }
    }
    
    // MARK: – @OBJC func
    @objc
    private func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension TaskDetailController: TaskDetailViewProtocol {
    func setData(model: TaskDetailModel) {
        self.model = model
        contentView.model = self.model
    }
}
