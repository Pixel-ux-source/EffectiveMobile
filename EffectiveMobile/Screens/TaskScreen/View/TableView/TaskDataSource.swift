//
//  TaskDataSource.swift
//  EffectiveMobile
//
//  Created by Алексей on 29.04.2025.
//

import UIKit

final class TaskDataSource: NSObject, UITableViewDataSource {
    var model: [Todos] = []
    weak var delegateTaskCell: TaskCellDelegate?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TaskCell.id,for: indexPath) as? TaskCell else { fatalError("ERROR_TASK_CELL_DEQUEUE") }
        let item = model[indexPath.row]
        cell.setUI(title: item.todo, desc: item.todo, date: item.createdAt.formattedDate(), completed: item.completed)
        
        cell.delegate = delegateTaskCell
        
        return cell
    }
}
