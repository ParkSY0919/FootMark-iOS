//
//  DiaryView.swift
//  FootMark
//
//  Created by 윤성은 on 3/24/24.
//

import UIKit
import SnapKit

class DiaryView: BaseView {
    
    let emojiLabel = UILabel().then {
        $0.setPretendardFont(text: "🫥", size: 50, weight: .bold, letterSpacing: 1.25)
        $0.isUserInteractionEnabled = true
    }
    
    var emojiPickerHandler: (() -> Void)?
    
    let container = UIView()
    
    let dateLabel = UILabel().then {
        $0.setPretendardFont(text: "2023.03.24 (일)", size: 20, weight: .regular, letterSpacing: 1.25)
    }
    
    lazy var categoryButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("카테고리 선택", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 30, weight: .bold)
        button.tintColor = .label
        return button
    }()
    
    let todoLabel = UILabel().then {
        $0.setPretendardFont(text: "수영, 산책, 천국의 계단", size: 17, weight: .regular, letterSpacing: 1.25)
    }
    
    override func setUI() {
//        addSubviews(emojiLabel)
        
        container.addSubview(emojiLabel)
        container.addSubview(dateLabel)
        container.addSubview(categoryButton)
        container.addSubview(todoLabel)
        
        addSubview(container)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(emojiLabelTapped))
        emojiLabel.addGestureRecognizer(tapGesture)
    }
    
    override func setLayout() {
        emojiLabel.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(30)
            $0.centerX.equalToSuperview()
        }
        
        dateLabel.snp.makeConstraints {
            $0.top.equalTo(self.emojiLabel.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
        }
        
        categoryButton.snp.makeConstraints {
            $0.top.equalTo(self.dateLabel.snp.bottom).offset(50)
            $0.leading.equalToSuperview().inset(10)
        }
        
        todoLabel.snp.makeConstraints {
            $0.top.equalTo(self.categoryButton.snp.bottom).offset(10)
            $0.leading.equalToSuperview().inset(10)
        }
        
        container.snp.makeConstraints {
            $0.top.equalTo(emojiLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(20)
        }
        
//        let labelsStackView = UIStackView(arrangedSubviews: [dateLabel, categoryButton])
//        labelsStackView.axis = .horizontal
//        labelsStackView.spacing = 8
//        labelsStackView.alignment = .center
//        container.addSubview(labelsStackView)
//        
//        labelsStackView.snp.makeConstraints {
//            $0.top.equalToSuperview().offset(16)
//            $0.leading.trailing.equalToSuperview().inset(16)
//        }
    }
    
    @objc func emojiLabelTapped() {
        emojiPickerHandler?()
    }
}

