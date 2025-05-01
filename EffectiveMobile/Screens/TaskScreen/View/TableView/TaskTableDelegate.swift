//
//  TaskDelegate.swift
//  EffectiveMobile
//
//  Created by Алексей on 29.04.2025.
//

import UIKit

final class TaskTableDelegate: NSObject, UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        106
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) else { return }
        
        UIView.animate(withDuration: 0.1, animations: {
            cell.alpha = 0.5
        }) { _ in
            UIView.animate(withDuration: 0.2) {
                cell.alpha = 1.0
            }
        }

        tableView.deselectRow(at: indexPath, animated: false)
    }
}
