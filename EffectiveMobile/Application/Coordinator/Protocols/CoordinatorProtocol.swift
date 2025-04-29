//
//  CoordinatorProtocol.swift
//  EffectiveMobile
//
//  Created by Алексей on 29.04.2025.
//

import UIKit

protocol CoordinatorProtocol: AnyObject {
    var navigator: UINavigationController { get }
    
    func start()
}
