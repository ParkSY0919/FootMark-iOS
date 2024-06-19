//
//  DiaryView.controller.swift
//  FootMark
//
//  Created by 윤성은 on 6/18/24.
//

import UIKit

protocol DiaryViewDelegate: AnyObject {
    func deleteButtonTapped()
    func saveButtonTapped()
    func editButtonTapped()
    func backButtonTapped()
}

class DiaryView: BaseView {
    weak var delegate: DiaryViewDelegate?
    
    var emojiPickerHandler: (() -> Void)?
    
    let scrollView = UIScrollView().then {
        $0.isScrollEnabled = true
        $0.clipsToBounds = true
    }
    
    let contentView = UIView()
   var todo2Content = ""
    
    let emojiLabel = UILabel().then {
        $0.font = UIFont.pretendard(size: 50, weight: .semibold)
        $0.text = "🤣"
        $0.isUserInteractionEnabled = true
    }
    
    let dateLabel = UILabel().then {
        $0.font = UIFont.pretendard(size: 20, weight: .regular)
        $0.text = "2023-04-22"
        $0.textColor = UIColor(resource: .white2)
    }
    
    let categoryButton = UIButton().then {
        $0.backgroundColor = UIColor.white
        $0.setTitleColor(UIColor.black, for: .normal)
        $0.titleLabel?.font = UIFont.pretendard(size: 20, weight: .semibold)
        
        $0.layer.borderColor = UIColor.gray.cgColor
        $0.layer.borderWidth = 1.0
        $0.layer.cornerRadius = 5.0
        
        var config = UIButton.Configuration.plain()
        config.image = UIImage(systemName: "chevron.up")
        config.imagePlacement = .trailing
        config.imagePadding = 15
        config.imageColorTransformer = UIConfigurationColorTransformer { _ in
            return UIColor(resource: .blue1)
        }
        
        $0.configuration = config
    }
    
    let cateogryView = UIView().then {
        $0.layer.borderColor = UIColor.gray.cgColor
        $0.layer.borderWidth = 1.0
        $0.layer.cornerRadius = 5.0
    }
    
    let categoryLabel = UILabel().then {
        $0.font = UIFont.pretendard(size: 25, weight: .regular)
        $0.text = "운동"
        $0.textColor = UIColor(resource: .white2)
    }
    
    let todoLabel = UILabel().then {
        $0.font = UIFont.pretendard(size: 17, weight: .regular)
        $0.text = "수영, 산책, 달리기"
        $0.textColor = UIColor(resource: .white2)
    }
    
    var todoTextView = UITextView().then {
        $0.font = UIFont.pretendard(size: 16, weight: .regular)
        $0.isScrollEnabled = true
        $0.autocorrectionType = .no
        $0.spellCheckingType = .no
        $0.layer.borderColor = UIColor.gray.cgColor
        $0.layer.borderWidth = 1.0
        $0.layer.cornerRadius = 5.0
       $0.text = "오늘 하루 달리기로 부족한 유산소를 채웠다."
    }
    
    let thankfulLabel = UILabel().then {
        $0.font = UIFont.pretendard(size: 25, weight: .regular)
        $0.text = "감사한 일"
        $0.textColor = UIColor(resource: .white2)
    }
    
    var thankfulTextView = UITextView().then {
        $0.font = UIFont.pretendard(size: 16, weight: .regular)
        $0.isScrollEnabled = true
        $0.autocorrectionType = .no
        $0.spellCheckingType = .no
        $0.layer.borderColor = UIColor.gray.cgColor
        $0.layer.borderWidth = 1.0
        $0.layer.cornerRadius = 5.0
       $0.text = "성공적으로 캡스톤 디자인 프로젝트를 마무리할 수 있었음에 감사합니다."
    }
    
    let bestLabel = UILabel().then {
        $0.font = UIFont.pretendard(size: 25, weight: .regular)
        $0.text = "가장 좋았던 일"
        $0.textColor = UIColor(resource: .white2)
    }
    
    var bestTextView = UITextView().then {
        $0.font = UIFont.pretendard(size: 16, weight: .regular)
        $0.isScrollEnabled = true
        $0.autocorrectionType = .no
        $0.spellCheckingType = .no
        $0.layer.borderColor = UIColor.gray.cgColor
        $0.layer.borderWidth = 1.0
        $0.layer.cornerRadius = 5.0
       $0.text = "프로젝트를 끝내고 맛있는 것을 먹으니 너무 좋았습니다."
    }
    
    let saveButton = UIButton().then {
        $0.setTitle("저장", for: .normal)
        $0.setTitleColor(UIColor(resource: .white2), for: .normal)
        $0.backgroundColor = UIColor(resource: .blue1)
        $0.titleLabel?.font = UIFont.pretendard(size: 20, weight: .regular)
        $0.layer.borderColor = UIColor.gray.cgColor
        $0.layer.borderWidth = 1.0
        $0.layer.cornerRadius = 5.0
    }
    
    let editButton = UIButton().then {
        $0.backgroundColor = UIColor.white
        $0.setTitleColor(UIColor.black, for: .normal)
        $0.titleLabel?.font = UIFont.pretendard(size: 20, weight: .semibold)
        
        $0.layer.borderColor = UIColor.gray.cgColor
        $0.layer.borderWidth = 1.0
        $0.layer.cornerRadius = 5.0
        
        var config = UIButton.Configuration.plain()
        config.image = UIImage(systemName: "pencil")
        config.imagePlacement = .trailing
        config.imagePadding = 15
        config.imageColorTransformer = UIConfigurationColorTransformer { _ in
            return UIColor(resource: .blue1)
        }
        
        $0.configuration = config
    }
    
    let deleteButton = UIButton().then {
        $0.backgroundColor = UIColor.white
        $0.setTitleColor(UIColor.black, for: .normal)
        $0.titleLabel?.font = UIFont.pretendard(size: 20, weight: .semibold)
        
        $0.layer.borderColor = UIColor.gray.cgColor
        $0.layer.borderWidth = 1.0
        $0.layer.cornerRadius = 5.0
        
        var config = UIButton.Configuration.plain()
        config.image = UIImage(systemName: "trash")
        config.imagePlacement = .trailing
        config.imagePadding = 15
        config.imageColorTransformer = UIConfigurationColorTransformer { _ in
            return UIColor(resource: .blue1)
        }
        
        $0.configuration = config
    }
    
    let backButton = UIButton().then {
        $0.setTitle("취소", for: .normal)
        $0.setTitleColor(UIColor(resource: .white2), for: .normal)
    }
    
    override func setLayout() {
        addSubview(scrollView)
        
        scrollView.addSubview(contentView)
        
        contentView.addSubview(emojiLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(categoryButton)
        
        contentView.addSubview(categoryLabel)
        contentView.addSubview(todoLabel)
        contentView.addSubview(todoTextView)
        
        contentView.addSubview(thankfulLabel)
        contentView.addSubview(thankfulTextView)
        
        contentView.addSubview(bestLabel)
        contentView.addSubview(bestTextView)
        
        contentView.addSubview(editButton)
        contentView.addSubview(deleteButton)
        contentView.addSubview(backButton)
        contentView.addSubview(saveButton)
        
        emojiLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.centerX.equalToSuperview()
        }
        
        dateLabel.snp.makeConstraints {
            $0.top.equalTo(self.emojiLabel.snp.bottom).offset(40)
            $0.leading.equalToSuperview().inset(30)
            $0.trailing.lessThanOrEqualToSuperview().offset(-30)
        }
        
        categoryButton.snp.makeConstraints {
            $0.top.equalTo(self.emojiLabel.snp.bottom).offset(30)
            $0.centerY.equalTo(self.dateLabel.snp.centerY)
            $0.trailing.equalToSuperview().offset(-30)
            $0.width.equalTo(150)
            $0.height.equalTo(50)
        }
        
        categoryLabel.snp.makeConstraints {
            $0.top.equalTo(self.dateLabel.snp.bottom).offset(50)
            $0.leading.equalToSuperview().inset(30)
            $0.trailing.lessThanOrEqualToSuperview().offset(-30)
        }
        
        todoLabel.snp.makeConstraints {
            $0.top.equalTo(self.categoryLabel.snp.bottom).offset(10)
            $0.leading.equalToSuperview().inset(30)
            $0.trailing.lessThanOrEqualToSuperview().offset(-30)
        }
        
        todoTextView.snp.makeConstraints {
            $0.top.equalTo(self.todoLabel.snp.bottom).offset(20)
            $0.centerX.equalToSuperview().inset(30)
            $0.width.equalTo(350)
            $0.height.equalTo(300)
        }
        
        thankfulLabel.snp.makeConstraints {
            $0.top.equalTo(self.todoTextView.snp.bottom).offset(50)
            $0.leading.equalToSuperview().inset(30)
            $0.trailing.lessThanOrEqualToSuperview().offset(-30)
        }
        
        thankfulTextView.snp.makeConstraints {
            $0.top.equalTo(self.thankfulLabel.snp.bottom).offset(20)
            $0.centerX.equalToSuperview().inset(30)
            $0.width.equalTo(350)
            $0.height.equalTo(200)
        }
        
        bestLabel.snp.makeConstraints {
            $0.top.equalTo(self.thankfulTextView.snp.bottom).offset(50)
            $0.leading.equalToSuperview().inset(30)
            $0.trailing.lessThanOrEqualToSuperview().offset(-30)
        }
        
        bestTextView.snp.makeConstraints {
            $0.top.equalTo(self.bestLabel.snp.bottom).offset(20)
            $0.centerX.equalToSuperview().inset(30)
            $0.width.equalTo(350)
            $0.height.equalTo(200)
        }
        
        deleteButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.leading.equalTo(emojiLabel.snp.trailing).offset(50)
            $0.size.equalTo(CGSize(width: 40, height: 40))
        }
        
        editButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.leading.equalTo(deleteButton.snp.trailing).offset(20)
            $0.size.equalTo(CGSize(width: 40, height: 40))
        }
        
        backButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.leading.equalToSuperview().offset(20)
            $0.size.equalTo(CGSize(width: 44, height: 44))
        }
        
        saveButton.snp.makeConstraints {
            $0.top.equalTo(self.bestTextView.snp.bottom).offset(100)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(CGSize(width: 350, height: 50))
        }
        
        contentView.snp.makeConstraints {
            $0.edges.equalTo(scrollView)
            $0.width.equalTo(scrollView)
            $0.bottom.equalTo(saveButton.snp.bottom).offset(50)
        }
        
        scrollView.snp.makeConstraints {
            $0.edges.equalTo(self.safeAreaLayoutGuide)
        }
    }
    
    @objc private func saveButtonTapped() {
        delegate?.saveButtonTapped()
    }
    
    @objc private func editButtonTapped() {
        delegate?.editButtonTapped()
    }
    
    @objc private func backButtonTapped() {
        delegate?.backButtonTapped()
    }
}
