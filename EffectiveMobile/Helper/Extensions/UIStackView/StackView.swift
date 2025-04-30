//
//  StackView.swift
//  EffectiveMobile
//
//  Created by Алексей on 29.04.2025.
//

import UIKit

extension UIStackView {
    func addArrangedSubviews(_ views: [UIView]) {
        views.forEach { self.addArrangedSubview($0) }
    }
}
