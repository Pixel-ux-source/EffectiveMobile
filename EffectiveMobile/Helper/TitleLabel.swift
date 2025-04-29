//
//  TitleLabel.swift
//  EffectiveMobile
//
//  Created by Алексей on 29.04.2025.
//

import UIKit

final class TitleLabel: UILabel {
    // MARK: – Lifecycle
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setupSettings()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: – Setup Settings
    private func setupSettings() {
        
    }
}
