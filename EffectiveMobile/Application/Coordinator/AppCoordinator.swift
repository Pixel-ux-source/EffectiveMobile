//
//  AppCoordinator.swift
//  EffectiveMobile
//
//  Created by Алексей on 29.04.2025.
//

import UIKit

final class AppCoordinator: CoordinatorProtocol {
    var tabBar: UITabBarController
    var navigator: UINavigationController
    
    init(tabBar: UITabBarController, navigator: UINavigationController) {
        self.tabBar = tabBar
        self.navigator = navigator
    }
    
    func start() {
        let vc = TaskBuilder.build()
        vc.coordinator = self
        vc.view.backgroundColor = .blackCustom
        navigator.pushViewController(vc, animated: false)
    }
    
    func openToTaskDetailScreen(_ id: Int64, _ title: String, _ desc: String, _ date: String) {
        let vc = TaskDetailBuilder.build(id, title, desc, date)
        vc.hidesBottomBarWhenPushed = true
        vc.coordinator = self
        vc.view.backgroundColor = .blackCustom
        navigator.pushViewController(vc, animated: true)
    }
}
