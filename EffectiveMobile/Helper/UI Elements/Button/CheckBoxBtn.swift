//
//  checkBox.swift
//  EffectiveMobile
//
//  Created by Алексей on 29.04.2025.
//

import UIKit

final class CheckBoxBtn: UIButton {
    // MARK: – Variables
    var isCompleted: Bool
    var completion: () -> ()
    
    // MARK: – Lifecycle
    init(frame: CGRect = .zero, _ isCompleted: Bool, _ completion: @escaping () -> ()) {
        self.completion = completion
        self.isCompleted = isCompleted
        super.init(frame: frame)
        setupSettings()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: – Setup Settings
    private func setupSettings() {
        let imageName = isCompleted ? "checkmark.circle" : "circle"
        setImage(UIImage(systemName: imageName), for: .normal)
        clipsToBounds = true
        tintColor = isCompleted ? UIColor.yellowCustom : UIColor.stroke
        imageView?.contentMode = .scaleAspectFit
        contentVerticalAlignment = .fill
        contentHorizontalAlignment = .fill

        addAction(UIAction(handler: { [weak self] _ in
            guard let self else { return }
            self.completion()
        }), for: .touchUpInside)
    }
}
