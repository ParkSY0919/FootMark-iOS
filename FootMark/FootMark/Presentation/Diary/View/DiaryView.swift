//
//  DiaryView.swift
//  FootMark
//
//  Created by 윤성은 on 3/24/24.
//

import UIKit
import DropDown

protocol diaryViewDelegate: AnyObject {
    func saveButtonTapped()
}

class DiaryView: BaseView {
    
    weak var delegate: diaryViewDelegate?
    
    var emojiPickerHandler: (() -> Void)?
    
    let scrollView = UIScrollView().then {
        $0.layer.borderColor = UIColor.red.cgColor
        $0.isScrollEnabled = true
        $0.clipsToBounds = true
    }
    
    let contentView = UIView()
    
    let emojiLabel = UILabel().then {
        $0.setPretendardFont(text: "🫥", size: 50, weight: .bold, letterSpacing: 1.25)
        $0.isUserInteractionEnabled = true
    }
    
    let container = UIView()
    
    let dateLabel = UILabel().then {
        $0.setPretendardFont(text: "2023.03.24 (일)", size: 20, weight: .regular, letterSpacing: 1.25)
    }
    
    let categoryButton = UIButton().then {
        $0.setTitle("카테고리", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        
        $0.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        $0.semanticContentAttribute = .forceRightToLeft
        //        $0.imageEdgeInsets = UIEdgeInsets(top: 0, left: categoryButton.bounds.width - 24, bottom: 0, right: 0)
        
        $0.layer.borderColor = UIColor.gray.cgColor
        $0.layer.borderWidth = 1.0
        $0.layer.cornerRadius = 5.0
    }
    
    let dropDown = DropDown()
    
    let cateogryView = UIView().then {
        $0.layer.borderColor = UIColor.gray.cgColor
        $0.layer.borderWidth = 1.0
        $0.layer.cornerRadius = 5.0
    }
    
    let categoryLabel = UILabel().then {
        $0.setPretendardFont(text: "운동", size: 30, weight: .regular, letterSpacing: 1.25)
    }
    
    let todoLabel = UILabel().then {
        $0.setPretendardFont(text: "수영, 산책, 천국의 계단", size: 17, weight: .regular, letterSpacing: 1.25)
    }
    
    let todoTextView = UITextView().then {
        $0.font = UIFont.systemFont(ofSize: 16)
        $0.isScrollEnabled = true
        
        $0.autocorrectionType = .no
        $0.spellCheckingType = .no
        
        $0.layer.borderColor = UIColor.gray.cgColor
        $0.layer.borderWidth = 1.0
        $0.layer.cornerRadius = 5.0
    }
    
    let thankfulLabel = UILabel().then {
        $0.setPretendardFont(text: "감사한 일", size: 30, weight: .regular, letterSpacing: 1.25)
    }
    
    let thankfulTextView = UITextView().then {
        $0.font = UIFont.systemFont(ofSize: 16)
        $0.isScrollEnabled = true
        
        $0.autocorrectionType = .no
        $0.spellCheckingType = .no
        
        $0.layer.borderColor = UIColor.gray.cgColor
        $0.layer.borderWidth = 1.0
        $0.layer.cornerRadius = 5.0
    }
    
    let bestLabel = UILabel().then {
        $0.setPretendardFont(text: "가장 좋았던 일", size: 30, weight: .regular, letterSpacing: 1.25)
    }
    
    let bestTextView = UITextView().then {
        $0.font = UIFont.systemFont(ofSize: 16)
        $0.isScrollEnabled = true
        $0.layer.borderColor = UIColor.gray.cgColor
        $0.layer.borderWidth = 1.0
        $0.layer.cornerRadius = 5.0
    }
    
    let saveButton = UIButton().then {
        $0.setTitle("저장", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        $0.layer.borderColor = UIColor.gray.cgColor
        $0.layer.borderWidth = 1.0
        $0.layer.cornerRadius = 5.0
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
        
        contentView.addSubview(saveButton)
        
        emojiLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(30)
            $0.centerX.equalToSuperview()
        }
        
        dateLabel.snp.makeConstraints {
            $0.top.equalTo(self.emojiLabel.snp.bottom).offset(40)
            $0.leading.equalToSuperview().inset(30)
        }
        
        categoryButton.snp.makeConstraints {
            $0.top.equalTo(self.emojiLabel.snp.bottom).offset(30)
            $0.leading.equalTo(dateLabel.snp.trailing).offset(40)
            $0.width.equalTo(150)
            $0.height.equalTo(50)
        }
        
        categoryLabel.snp.makeConstraints {
            $0.top.equalTo(self.dateLabel.snp.bottom).offset(30)
            $0.leading.equalToSuperview().inset(30)
        }
        
        todoLabel.snp.makeConstraints {
            $0.top.equalTo(self.categoryLabel.snp.bottom).offset(10)
            $0.leading.equalToSuperview().inset(30)
        }
        
        todoTextView.snp.makeConstraints {
            $0.top.equalTo(self.todoLabel.snp.bottom).offset(20)
            $0.centerX.equalToSuperview().inset(30)
            $0.width.equalTo(350)
            $0.height.equalTo(300)
        }
        
        thankfulLabel.snp.makeConstraints {
            $0.top.equalTo(self.todoTextView.snp.bottom).offset(30)
            $0.leading.equalToSuperview().inset(30)
        }
        
        thankfulTextView.snp.makeConstraints {
            $0.top.equalTo(self.thankfulLabel.snp.bottom).offset(20)
            $0.centerX.equalToSuperview().inset(30)
            $0.width.equalTo(350)
            $0.height.equalTo(200)
        }
        
        bestLabel.snp.makeConstraints {
            $0.top.equalTo(self.thankfulTextView.snp.bottom).offset(30)
            $0.leading.equalToSuperview().inset(30)
        }
        
        bestTextView.snp.makeConstraints {
            $0.top.equalTo(self.bestLabel.snp.bottom).offset(20)
            $0.centerX.equalToSuperview().inset(30)
            $0.width.equalTo(350)
            $0.height.equalTo(200)
        }
        
        saveButton.snp.makeConstraints {
            $0.top.equalTo(self.bestTextView.snp.bottom).offset(100)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(350)
            $0.height.equalTo(50)
        }
        
        contentView.snp.makeConstraints {
            $0.edges.equalTo(scrollView)
            $0.width.equalTo(scrollView)
            $0.bottom.equalTo(saveButton.snp.bottom).offset(50)
        }
        
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
