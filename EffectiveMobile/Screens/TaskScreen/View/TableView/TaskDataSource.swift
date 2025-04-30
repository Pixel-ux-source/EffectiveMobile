//
//  TaskDataSource.swift
//  EffectiveMobile
//
//  Created by Алексей on 29.04.2025.
//

import UIKit

final class TaskDataSource: NSObject, UITableViewDataSource {
    var model: [Todos] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TaskCell.id,for: indexPath) as? TaskCell else { fatalError("ERROR_TASK_CELL_DEQUEUE") }
        
        return cell
    }
    
    
}
