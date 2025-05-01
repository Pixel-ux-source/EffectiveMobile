//
//  TaskCell.swift
//  EffectiveMobile
//
//  Created by Алексей on 29.04.2025.
//

import UIKit
import SnapKit

final class TaskCell: UITableViewCell {
    // MARK: – Cell ID
    static var id: String {
        String(describing: self)
    }
    
    // MARK: – UI Elements
    private lazy var titleLabel: TitleLabel = TitleLabel()
    private lazy var descLabel: DescLabel = DescLabel()
    private lazy var dateLabel: DateLabel = DateLabel()
    private lazy var checkBoxBtn: CheckBoxBtn = CheckBoxBtn()
    
    private lazy var stackViewVertical: UIStackView = VerticalStack(spacing: 6, aligment: .leading) {
        [titleLabel,descLabel,dateLabel]
    }
    private lazy var stackViewHorizontal: UIStackView = HorizontalStack(spacing: 8, aligment: .top) {
        [checkBoxBtn,stackViewVertical]
    }
    
    // MARK: – Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureView()
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: – Configuration
    private func configureView() {
        contentView.backgroundColor = .clear
        backgroundColor = .clear
        selectionStyle = .none
    }
    
    // MARK: – Setup's
    private func setupUI() {
        contentView.addSubview(stackViewHorizontal)
        setupStackViewHorizontal()
    }
    
    private func setupStackViewHorizontal() {
        checkBoxBtn.snp.makeConstraints { make in
            make.width.height.equalTo(24)
        }
        
        stackViewHorizontal.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.height.lessThanOrEqualTo(106)
            make.horizontalEdges.equalToSuperview().inset(20)
        }
    }
    
    // MARK: – Set UI
    func setUI(title: String?, desc: String?, date: Date?, completed: Bool) {
        titleLabel.text = title
        descLabel.text = desc
        dateLabel.text = String(describing: date)
        
        titleLabel.isCompleted = completed
        descLabel.isCompleted = completed
        checkBoxBtn.isCompleted = completed
    }
}
