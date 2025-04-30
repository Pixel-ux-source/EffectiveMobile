//
//  File.swift
//  EffectiveMobile
//
//  Created by Алексей on 29.04.2025.
//

import UIKit

final class HorizontalStack: UIStackView {
    // MARK: – Lifecycle
    init(frame: CGRect = .zero, spacing: CGFloat, aligment: UIStackView.Alignment = .fill, distribution: UIStackView.Distribution = .fill,  _ completion: () -> ([UIView])) {
        super.init(frame: frame)
        
        self.addArrangedSubviews(completion())
        self.spacing = spacing
        self.alignment = aligment
        self.distribution = distribution
        setupSettings()
    }
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: – Setup Settings
    private func setupSettings() {
        axis = .horizontal
    }
}
