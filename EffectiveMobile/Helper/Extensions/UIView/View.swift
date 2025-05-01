//
//  View.swift
//  EffectiveMobile
//
//  Created by Алексей on 29.04.2025.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach { self.addSubview($0) } 
    }
}
