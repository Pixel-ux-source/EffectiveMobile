//
//  checkBox.swift
//  EffectiveMobile
//
//  Created by Алексей on 29.04.2025.
//

import UIKit

final class CheckBoxBtn: UIButton {
    // MARK: – Variables
    var isCompleted: Bool = false {
        didSet {
            let imageName = isCompleted ? "checkmark.circle" : "circle"
            setImage(UIImage(systemName: imageName), for: .normal)
            tintColor = isCompleted ? UIColor.yellowCustom : UIColor.stroke
        }
    }
    
    var onToggle: ((Bool) -> ())?
    
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
        clipsToBounds = true
        imageView?.contentMode = .scaleAspectFit
        contentVerticalAlignment = .fill
        contentHorizontalAlignment = .fill
        isUserInteractionEnabled = true
        isExclusiveTouch = true

        addAction(UIAction(handler: { [weak self] _ in
            guard let self else { return }
            self.onToggle?(self.isCompleted)
        }), for: .touchUpInside)
    }
}
