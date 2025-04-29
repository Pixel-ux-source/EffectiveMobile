//
//  AppCoordinator.swift
//  EffectiveMobile
//
//  Created by Алексей on 29.04.2025.
//

import UIKit

final class AppCoordinator: CoordinatorProtocol {
    var navigator: UINavigationController
    
    init(navigator: UINavigationController) {
        self.navigator = navigator
    }
    
    func start() {
        let vc = TaskBuilder.build()
        vc.coordinator = self
        navigator.pushViewController(vc, animated: false)
    }
}
