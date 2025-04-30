//
//  TabBarLabel.swift
//  EffectiveMobile
//
//  Created by Алексей on 30.04.2025.
//

import UIKit

final class TabBarLabel: UILabel {
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
        textColor = .whiteCustom
        font = UIFont(name: "SFPro-Regular", size: 12)!
        textAlignment = .center
    }
}
