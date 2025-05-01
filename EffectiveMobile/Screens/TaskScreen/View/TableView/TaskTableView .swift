//
//  TableView .swift
//  EffectiveMobile
//
//  Created by Алексей on 29.04.2025.
//

import UIKit

final class TaskTableView: UITableView {
    // MARK: – Lifecycle
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        configureView()
        registerCell()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: – Configurations
    private func configureView() {
        backgroundColor = .clear
    }
    
    // MARK: – Register Cell
    private func registerCell() {
        register(TaskCell.self, forCellReuseIdentifier: TaskCell.id)
    }
}
