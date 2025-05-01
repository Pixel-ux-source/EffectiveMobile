//
//  TitleLabel.swift
//  EffectiveMobile
//
//  Created by Алексей on 29.04.2025.
//

import UIKit

final class TitleLabel: UILabel {
    // MARK: – Variables
    var isCompleted: Bool = false {
        didSet {
            let attributedString = NSMutableAttributedString(string: self.text ?? "")

            attributedString.addAttributes([
                .font: UIFont(name: "SFPro-Medium", size: 16)!,
                .kern: -0.43,
                .strikethroughStyle: isCompleted ? NSUnderlineStyle.single.rawValue : NSUnderlineStyle.self,
                .strikethroughColor: UIColor.whiteCustom
            ], range: NSRange(location: 0, length: attributedString.length))
            attributedText = attributedString
            
            alpha = isCompleted ? 0.5 : 1
        }
    }
    
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
        textAlignment = .left
        numberOfLines = 1
    }
}
