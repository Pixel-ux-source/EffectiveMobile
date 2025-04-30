//
//  DescLabel.swift
//  EffectiveMobile
//
//  Created by Алексей on 29.04.2025.
//

import UIKit

final class DescLabel: UILabel {
    // MARK: – Variables
    var isCompleted: Bool
    
    // MARK: – Lifecycle
    init(frame: CGRect = .zero, _ competion: @escaping () -> Bool) {
        self.isCompleted = competion()
        super.init(frame: frame)
        setupSettings()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: – Setup Settings
    private func setupSettings() {
        text = "Составить список необходимых продуктов для ужина. Не забыть проверить, что уже есть в холодильнике."
        font = UIFont(name: "SFProText-Regular", size: 12)
        textColor = .whiteCustom
        alpha = isCompleted ? 0.5 : 1
        textAlignment = .left
        numberOfLines = 2
    }
}
