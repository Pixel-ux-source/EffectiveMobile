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
        countTask = dataSource.model.count
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
        
        tableView.tableHeaderView = UIView()
        tableView.tableFooterView = UIView()
                
        tableView.dataSource = dataSource
        tableView.delegate = tableDelegate
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
        
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
    }
    
    private func configureSearchController() {
        navigationItem.searchController = SearchConfiguration.make(for: self)
        definesPresentationContext = true
    }
    
    private func configureTabBar() {
        let tabBar = coordinator.tabBar
        tabBar.tabBar.backgroundColor = .grayCustom

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
    
    // MARK: – @OBJC Func
    @objc private func createTask() {
        print("Create task")
    }
}

extension TaskController: TaskViewProtocol {
    func setData(_ model: [Todos]) {
        print("Change data success")
    }
}

extension TaskController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
    }
}
