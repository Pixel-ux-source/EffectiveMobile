//
//  TaskDelegate.swift
//  EffectiveMobile
//
//  Created by Алексей on 29.04.2025.
//

import UIKit

protocol TaskTableDelegateProtocol: AnyObject {
    func didUpdateCount(at count: Int)
}

final class TaskTableDelegate: NSObject, UITableViewDelegate {
    var coordinator: AppCoordinator!
    var viewModel: TaskViewModel!
    weak var delegate: TaskTableDelegateProtocol?
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
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
        
        let item = viewModel.model[indexPath.row]
        let title = item.title ?? ""
        let desc = item.desc ?? ""
        let date = item.createdAt.formattedDate()
        let id = item.id
        coordinator.openToTaskDetailScreen(id, title, desc, date)
    }
    
    func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        let menu = UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { _ in
            UIMenu(title: "", children: [
                UIAction(title: "Редактировать", image: UIImage(named: "edit"), handler: { _ in
                    self.edit(at: indexPath)
                }),
                
                UIAction(title: "Поделиться", image: UIImage(named: "export"), handler: { _ in
                    self.share(at: indexPath)
                }),
                
                UIAction(title: "Удалить", image: UIImage(named: "trash"), attributes: .destructive, handler: { _ in
                    self.delete(at: indexPath, tableView)
                })
            ])
        }
        return menu
    }
    
    private func edit(at indexPath: IndexPath) {
        let item = viewModel.model[indexPath.row]
        let title = item.title ?? ""
        let desc = item.desc ?? ""
        let date = item.createdAt.formattedDate()
        let id = item.id
        self.coordinator.openToTaskDetailScreen(id, title, desc, date)
    }
    
    private func share(at indexPath: IndexPath) {
        
    }

    private func delete(at indexPath: IndexPath, _ tableView: UITableView) {
        let id = viewModel.model[indexPath.row].id
        TaskDataManager.shared.delete(with: id)
        DispatchQueue.main.async {
            self.viewModel.model.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            self.delegate?.didUpdateCount(at: self.viewModel.model.count)
        }
    }

}
