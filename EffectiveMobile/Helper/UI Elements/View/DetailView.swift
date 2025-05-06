//
//  DetailView.swift
//  EffectiveMobile
//
//  Created by Алексей on 05.05.2025.
//

import UIKit
import SnapKit

final class DetailView: UIView, UITextViewDelegate {
    // MARK: – UI Element's
    private lazy var titleTextView: TitleTextView = {
        let tv = TitleTextView()
        tv.delegate = self
        return tv
    }()
    
    private lazy var descTextView: DescTextView = {
        let tv = DescTextView()
        tv.delegate = self
        return tv
    }()

    private lazy var dateLabel: DateLabel = DateLabel()
    private lazy var vStackTitle: VerticalStack = VerticalStack(spacing: 8) { [titleTextView, dateLabel] }
    private lazy var vStackDesc: VerticalStack = VerticalStack(spacing: 16) { [vStackTitle, descTextView] }
    
    // MARK: – Model
    var model: TaskDetailModel? {
        didSet {
            updateUI()
        }
    }
    
    // MARK: – Lifecycle
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        configureView()
        setupVStackDesc()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToWindow() {
        super.didMoveToWindow()
        if window != nil {
            titleTextView.becomeFirstResponder()
        }
    }
    
    // MARK: – Update UI
    private func updateUI() {
        DispatchQueue.main.async {
            guard let model = self.model else { return }
            self.titleTextView.configure(with: model.todoTitle)
            self.descTextView.configure(with: model.todoDesc)
            self.dateLabel.text = model.todoDate
        }
    }
    
    // MARK: – Text View Delegate
    func textViewDidChange(_ textView: UITextView) {
        if textView === titleTextView {
            guard let newValue = titleTextView.text else { return }
            self.model?.todoTitle = newValue
        } else if textView === descTextView {
            guard let newValue = descTextView.text else { return }
            self.model?.todoDesc = newValue
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n", textView === titleTextView {
            descTextView.becomeFirstResponder()
            return false
        }
        return true
    }
    
    // MARK: – Configuration's
    private func configureView() {
        backgroundColor = .clear
    }
    
    // MARK: – Setup's
    private func setupVStackDesc() {
        addSubview(vStackDesc)
        
        vStackDesc.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(20)
            make.verticalEdges.equalToSuperview().inset(8)
        }
    }
}
