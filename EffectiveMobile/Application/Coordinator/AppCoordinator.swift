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
    private var loaderVC: LoaderController?
    
    init(tabBar: UITabBarController, navigator: UINavigationController) {
        self.tabBar = tabBar
        self.navigator = navigator
    }
    
    func start() {
        TaskBuilder.build { vc in
            vc.coordinator = self
            vc.view.backgroundColor = .blackCustom
            self.navigator.pushViewController(vc, animated: false)
        }
    }
    
    func startLoader(over viewController: UIViewController) {
        LoaderBuilder.build { vc in
            vc.view.backgroundColor = .blackCustom
            vc.view.alpha = 0.9
            vc.modalPresentationStyle = .overFullScreen
            self.loaderVC = vc
            viewController.present(vc, animated: false)
        }
    }
    
    func hideLoader() {
        loaderVC?.stopAnimation()
        loaderVC = nil
    }
    
    func openToTaskDetailScreen(_ id: Int64, _ title: String, _ desc: String, _ date: String) {
        let vc = TaskDetailBuilder.build(id, title, desc, date)
        vc.hidesBottomBarWhenPushed = true
        vc.coordinator = self
        vc.view.backgroundColor = .blackCustom
        navigator.pushViewController(vc, animated: true)
    }
}

extension AppCoordinator {
    func reloadTaskController() {
        if let taskController = navigator.viewControllers.first(where: { $0 is TaskController }) as? TaskController {
            taskController.reloadScreen()
        }
    }
}
