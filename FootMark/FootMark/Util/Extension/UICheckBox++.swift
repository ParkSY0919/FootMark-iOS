//
//  UICheckBox++.swift
//  FootMark
//
//  Created by 박신영 on 6/14/24.
//

import UIKit
import SnapKit
import Then

class CheckboxView: UIView {
    private let containerView = UIView()
    private let checkboxButton = UIButton(type: .custom)
   let label = UITextField().then {
      $0.textColor = .white1
      $0.font = .pretendard(size: 20, weight: .medium)
      $0.attributedPlaceholder = NSAttributedString(
         string: "Todo를 등록해주세요!",
         attributes: [NSAttributedString.Key.foregroundColor: UIColor.white1]
      )
      $0.clearButtonMode = .whileEditing
   }
    
    var isChecked: Bool = false {
        didSet {
            updateCheckboxState()
        }
    }
    
    var title: String? {
        get {
            return label.text
        }
        set {
            label.text = newValue
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI() {
        addSubview(containerView)
        containerView.addSubviews(checkboxButton, label)
        
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        checkboxButton.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.height.equalTo(24)
        }
        
        label.snp.makeConstraints { make in
            make.leading.equalTo(checkboxButton.snp.trailing).offset(8)
            make.centerY.equalTo(checkboxButton)
            make.trailing.equalToSuperview()
        }
        
        checkboxButton.addTarget(self, action: #selector(toggleCheckbox), for: .touchUpInside)
        updateCheckboxState()
    }
    
    @objc private func toggleCheckbox() {
        isChecked.toggle()
    }
    
    private func updateCheckboxState() {
        checkboxButton.setImage(isChecked ? UIImage(systemName: "checkmark.square.fill") : UIImage(systemName: "square"), for: .normal)
        checkboxButton.tintColor = isChecked ? .systemBlue : .lightGray
    }
}
