//
//  DiaryView.swift
//  FootMark
//
//  Created by 윤성은 on 3/24/24.
//

import UIKit
import DropDown

class DiaryView: BaseView {
    
    let topContainer = UIView()
    let todoContainer = UIView()
    
    let emojiLabel = UILabel().then {
        $0.setPretendardFont(text: "🫥", size: 50, weight: .bold, letterSpacing: 1.25)
        $0.isUserInteractionEnabled = true
    }
    
    var emojiPickerHandler: (() -> Void)?
    
    let container = UIView()
    
    let dateLabel = UILabel().then {
        $0.setPretendardFont(text: "2023.03.24 (일)", size: 20, weight: .regular, letterSpacing: 1.25)
    }
    
    let categoryLabel = UILabel().then {
        $0.setPretendardFont(text: "운동하기", size: 30, weight: .regular, letterSpacing: 1.25)
    }
    
    let categoryButton = UIButton().then {
        $0.setTitle("카테고리", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        
//        $0.setImage(UIImage(systemName: "chevron.down"), for: .normal)
//        $0.semanticContentAttribute = .forceRightToLeft // 이미지를 텍스트 오른쪽으로 이동
//        $0.imageEdgeInsets = UIEdgeInsets(top: 0, left: categoryButton.bounds.width - 24, bottom: 0, right: 0) // 이미지 위치 조정

    }
    
    let dropDown = DropDown()
    
    let todoLabel = UILabel().then {
        $0.setPretendardFont(text: "수영, 산책, 천국의 계단", size: 17, weight: .regular, letterSpacing: 1.25)
    }
    
    let todoTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.isScrollEnabled = false
        textView.layer.borderColor = UIColor.gray.cgColor // 테두리 색상 설정
        textView.layer.borderWidth = 1.0 // 테두리 두께 설정
        textView.layer.cornerRadius = 5.0 // 모서리 둥글기 설정
        return textView
    }()
    
//    var todoTextField = UITextField().then {
//        $0.placeholder = "여기에 입력하세요"
//        $0.keyboardType = .default
//        $0.borderStyle = .roundedRect
//        $0.autocorrectionType = .no
//        $0.spellCheckingType = .no
//        $0.autocapitalizationType = .none
//        
//        $0.returnKeyType = .done
//        $0.becomeFirstResponder()
//        $0.resignFirstResponder()
//    }

    override func setUI() {
        super.setUI()
        
        topContainer.addSubview(emojiLabel)
        topContainer.addSubview(dateLabel)
        topContainer.addSubview(categoryButton)
        
        todoContainer.addSubview(categoryLabel)
        todoContainer.addSubview(todoLabel)
//        todoContainer.addSubview(todoTextField)
        todoContainer.addSubview(todoTextView)
        
        addSubview(topContainer)
        addSubview(todoContainer)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(emojiLabelTapped))
        emojiLabel.addGestureRecognizer(tapGesture)
        
        categoryButton.addTarget(self, action: #selector(categoryButtonTapped), for: .touchUpInside)
        
        setupDropDown()
    }
    
    override func setLayout() {
        
        emojiLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.centerX.equalToSuperview()
        }
        
        dateLabel.snp.makeConstraints {
            $0.top.equalTo(self.emojiLabel.snp.bottom).offset(40)
            $0.leading.equalToSuperview().inset(10)
        }
    
        categoryButton.snp.makeConstraints {
            $0.top.equalTo(self.emojiLabel.snp.bottom).offset(30)
            $0.leading.equalTo(dateLabel.snp.trailing).offset(50)
            $0.width.equalTo(100)
            $0.height.equalTo(50)
        }
        
        topContainer.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(20)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalTo(categoryButton.snp.bottom)
        }
        
        categoryLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().inset(10)
        }
        
        todoLabel.snp.makeConstraints {
            $0.top.equalTo(self.categoryLabel.snp.bottom).offset(10)
            $0.leading.equalToSuperview().inset(10)
        }
        
        todoTextView.snp.makeConstraints {
            $0.top.equalTo(self.todoLabel.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(350)
            $0.height.equalTo(400)
        }
        
//        todoTextField.snp.makeConstraints {
//            $0.top.equalTo(self.todoLabel.snp.bottom).offset(20)
//            $0.centerX.equalToSuperview()
//            $0.width.equalTo(350)
//            $0.height.equalTo(400)
//        }
        
        todoContainer.snp.makeConstraints {
            $0.top.equalTo(topContainer.snp.bottom).offset(30)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalTo(todoTextView.snp.bottom).offset(20)
        }
    }

    @objc func emojiLabelTapped() {
        emojiPickerHandler?()
    }
    
    func setupDropDown() {
        dropDown.anchorView = categoryButton
        dropDown.topOffset = CGPoint(x: 0, y: categoryButton.bounds.height)
        dropDown.dataSource = ["운동", "약속", "공부"]
        
        dropDown.selectionAction = { [weak self] (index: Int, item: String) in
            self?.categoryButton.setTitle(item, for: .normal)
            self?.categoryLabel.text = item
        }
    }
    
    @objc func categoryButtonTapped() {
        dropDown.show()
        print("😀😀😀😀😀😀😀")
    }
}
