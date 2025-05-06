//
//  TaskDataSource.swift
//  EffectiveMobile
//
//  Created by Алексей on 29.04.2025.
//

import UIKit

final class TaskDataSource: NSObject, UITableViewDataSource {
    var viewModel: TaskViewModel!

    weak var delegateTaskCell: TaskCellDelegate?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TaskCell.id,for: indexPath) as? TaskCell else { fatalError("ERROR_TASK_CELL_DEQUEUE") }
        let item = viewModel.model[indexPath.row]
        cell.setUI(title: item.title, desc: item.desc, date: item.createdAt.formattedDate(), completed: item.completed)
        cell.delegate = delegateTaskCell
        return cell
    }
}
