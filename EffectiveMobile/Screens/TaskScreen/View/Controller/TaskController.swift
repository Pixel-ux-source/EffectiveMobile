//
//  ViewController.swift
//  EffectiveMobile
//
//  Created by Алексей on 29.04.2025.
//

import UIKit
import SnapKit

final class TaskController: UIViewController {
    // MARK: – UI Elements
    private lazy var taskLabel: UILabel = TabBarLabel()
    
    private lazy var btnCreateTask: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(systemName: "square.and.pencil"), for: .normal)
        btn.tintColor = .yellowCustom
        btn.addTarget(self, action: #selector(createTask), for: .touchUpInside)
        
        btn.imageView?.contentMode = .scaleAspectFit
        btn.contentVerticalAlignment = .fill
        btn.contentHorizontalAlignment = .fill
        return btn
    }()
    
    // MARK: – Instances
    private let tableView = TaskTableView()
    private let dataSource = TaskDataSource()
    private let tableDelegate = TaskTableDelegate()
    private let networkService = NetworkService()
    private let viewModel = TaskViewModel()
    
    // MARK: – Variables
    var presenter: TaskPresenterProtocol!
    var coordinator: AppCoordinator!
    var countTask: Int = 1 {
        didSet { updateTaskLabel() }
    }
    
    // MARK: – Update Task Label
    private func updateTaskLabel() {
        let word = RussianWordHelper.taskWordForm(for: countTask)
        taskLabel.text = "\(countTask) \(word)"
    }

    // MARK: – Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        configureTabBar()
        configureSearchController()
        presenter.showData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavigationBar()
        countTask = viewModel.model.count
        tableView.reloadData()
    }
    
    // MARK: – Configuration
    private func configureTableView() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        tableView.rowHeight = UITableView.automaticDimension
        
        tableView.separatorInset = .init(top: 0, left: 20, bottom: 0, right: -20)
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = .stroke
        tableView.keyboardDismissMode = .onDrag
        
        tableView.tableHeaderView = UIView()
        tableView.tableFooterView = UIView()
        
        tableView.dataSource = dataSource
        tableView.delegate = tableDelegate
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 106
        
        dataSource.delegateTaskCell = self
        tableDelegate.delegate = self
        tableDelegate.coordinator = coordinator
        dataSource.viewModel = viewModel
        tableDelegate.viewModel = viewModel
    }
    
    private func configureNavigationBar() {
        navigationItem.title = "Задачи"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .blackCustom
        
        appearance.largeTitleTextAttributes = [
            .foregroundColor: UIColor.whiteCustom,
            .font: UIFont(name: "SFPro-Bold", size: 34)!,
            .kern: 0.4
        ]
        
        appearance.titleTextAttributes = [
            .foregroundColor: UIColor.whiteCustom,
            .font: UIFont(name: "SFPro-Bold", size: 20)!
        ]
        
        appearance.backButtonAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.yellowCustom]
        appearance.buttonAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.yellowCustom]
        navigationController?.navigationBar.tintColor = .yellowCustom
        
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
    }
    
    private func configureSearchController() {
        navigationItem.searchController = SearchConfiguration.make(for: self)
        definesPresentationContext = true
        navigationItem.searchController?.delegate = self
    }
    
    private func configureTabBar() {
        let tabBar = coordinator.tabBar
        
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .grayCustom
        
        tabBar.tabBar.standardAppearance = appearance
        tabBar.tabBar.scrollEdgeAppearance = appearance

        tabBar.tabBar.addSubviews(taskLabel, btnCreateTask)
        
        taskLabel.snp.makeConstraints { make in
            make.centerX.equalTo(tabBar.tabBar.snp_centerXWithinMargins)
            make.bottom.equalTo(tabBar.tabBar.snp_bottomMargin).offset(-8)
        }
        
        btnCreateTask.snp.makeConstraints { make in
            make.centerY.equalTo(tabBar.tabBar.snp_centerYWithinMargins)
            make.trailing.equalTo(tabBar.tabBar.snp_trailingMargin).offset(-20)
            make.width.height.equalTo(24)
        }
    }
    
    // MARK: – Reload Screen
    func reloadScreen() {
        DispatchQueue.global(qos: .userInitiated).async {
            let model = TaskDataManager.shared.fetchAll()
            DispatchQueue.main.async {
                self.viewModel.model = model
                self.countTask = model.count
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: – @OBJC Func
    @objc private func createTask() {
        coordinator.openToTaskDetailScreen(0, "", "", "")
    }
}

extension TaskController: TaskViewProtocol {
    func setData(_ model: [Todos]) {
        if model.isEmpty {
            networkService.getData { response in
                switch response {
                case .success(let data):
                    TaskDataManager.shared.createDataJson(from: data)
                    let newModel = TaskDataManager.shared.fetchAll()
                    self.viewModel.model = newModel
                    self.countTask = self.viewModel.model.count
                    self.tableView.reloadData()
                case .failure(let error):
                    print("Error network: \(error.localizedDescription)")
                }
            }
        } else {
            self.viewModel.model = model
            countTask = self.viewModel.model.count
            tableView.reloadData()
        }
    }
}

extension TaskController: UISearchResultsUpdating, UISearchControllerDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        guard let query = searchController.searchBar.text else {
            viewModel.model = []
            return
        }
        
        TaskDataManager.shared.searchData(with: query) { [weak self] model in
            guard let self else { return }
            DispatchQueue.main.async {
                self.viewModel.model = model
                self.tableView.reloadData()
            }
        }
    }
    
    func didDismissSearchController(_ searchController: UISearchController) {
        reloadScreen()
    }
}

extension TaskController: TaskCellDelegate  {
    func taskCell(_ cell: TaskCell, didToggleCompleted isCompleted: Bool) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        let id = viewModel.model[indexPath.row].id
        TaskDataManager.shared.update(with: id, on: [.completed(isCompleted)])
        tableView.reloadRows(at: [indexPath], with: .fade)
    }
}

extension TaskController: TaskTableDelegateProtocol {
    func didUpdateCount(at count: Int) {
        countTask = count
    }
}
