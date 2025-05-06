//
//  TitleTextView.swift
//  EffectiveMobile
//
//  Created by Алексей on 04.05.2025.
//

import UIKit

final class TitleTextView: UITextView {
    // MARK: – Lifecycle
    override init(frame: CGRect = .zero, textContainer: NSTextContainer? = nil) {
        super.init(frame: frame, textContainer: textContainer)
        setupSettings()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: – Configure Attr Text
    func configure(with text: String) {
        let attrText: [NSAttributedString.Key:Any] = [
            .foregroundColor: UIColor.whiteCustom,
            .font: UIFont(name: "SFPro-Bold", size: 34)!,
            .kern: 0.4
        ]
        typingAttributes = attrText
        
        if !text.isEmpty {
            attributedText = NSAttributedString(string: text, attributes: attrText)
        }
    }
    
    // MARK: – Setup Settings
    private func setupSettings() {
        isEditable = true
        isScrollEnabled = false
        backgroundColor = .clear
        textContainerInset = .zero
        textContainer.lineFragmentPadding = 0
        
        keyboardAppearance = .dark
        returnKeyType = .done
        
        layer.cornerRadius = 0
        layer.borderWidth = 0
    }
}
