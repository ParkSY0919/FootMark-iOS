//
//  BFDiaryView.swift
//  FootMark
//
//  Created by 박신영 on 6/14/24.
//

import UIKit

class BFDiaryView: BaseView {
    var emojiPickerHandler: (() -> Void)?
    
    let scrollView = UIScrollView().then {
        $0.isScrollEnabled = true
        $0.clipsToBounds = true
    }
    
    let contentView = UIView()
   
    
    let emojiLabel = UILabel().then {
        $0.font = UIFont.pretendard(size: 50, weight: .semibold)
        $0.text = "😂"
        $0.isUserInteractionEnabled = true
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
    
    let dateLabel = UILabel().then {
        $0.font = UIFont.pretendard(size: 20, weight: .regular)
        $0.text = "2024.06.12 (수)"
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
    
    let container = UIView()
    
    let FtodoLabel = UILabel().then {
        $0.font = UIFont.pretendard(size: 17, weight: .regular)
        $0.text = "하체운동, 줄넘기, 유산소"
        $0.textColor = UIColor(resource: .white2)
    }
    
    let FtodoTextView = UITextView().then {
        $0.font = UIFont.pretendard(size: 16, weight: .regular)
        $0.text = "3분할 중 하체와 어깨를 운동하였습니다.\n줄넘기 목표치 2000개를 수행하였습니다.\n유산소 30분을 수행하였습니다."
        $0.isScrollEnabled = true
        $0.autocorrectionType = .no
        $0.spellCheckingType = .no
        $0.layer.borderColor = UIColor.gray.cgColor
        $0.layer.borderWidth = 1.0
        $0.layer.cornerRadius = 5.0
    }
    
    let StodoLabel = UILabel().then {
        $0.font = UIFont.pretendard(size: 17, weight: .regular)
        $0.text = "Swift, 알고리즘"
        $0.textColor = UIColor(resource: .white2)
    }
    
    let StodoTextView = UITextView().then {
        $0.font = UIFont.pretendard(size: 16, weight: .regular)
        $0.text = "Swift와 알고리즘 공부를 했다."
        $0.isScrollEnabled = true
        $0.autocorrectionType = .no
        $0.spellCheckingType = .no
        $0.layer.borderColor = UIColor.gray.cgColor
        $0.layer.borderWidth = 1.0
        $0.layer.cornerRadius = 5.0
    }
    
    let thankfulLabel = UILabel().then {
        $0.font = UIFont.pretendard(size: 25, weight: .regular)
        $0.text = "감사한 일"
        $0.textColor = UIColor(resource: .white2)
    }
    
    let thankfulTextView = UITextView().then {
        $0.font = UIFont.pretendard(size: 16, weight: .regular)
        $0.text = "오늘 하루 무사히 잘 지냈음에 감사합니다."
        $0.isScrollEnabled = true
        $0.autocorrectionType = .no
        $0.spellCheckingType = .no
        $0.layer.borderColor = UIColor.gray.cgColor
        $0.layer.borderWidth = 1.0
        $0.layer.cornerRadius = 5.0
    }
    
    let bestLabel = UILabel().then {
        $0.font = UIFont.pretendard(size: 25, weight: .regular)
        $0.text = "가장 좋았던 일"
        $0.textColor = UIColor(resource: .white2)
    }
    
    let bestTextView = UITextView().then {
        $0.font = UIFont.pretendard(size: 16, weight: .regular)
        $0.text = "동아리에서 알고리즘 스터디를 하였는데, 스터디 멤버들 중 과반수가 넘게 과제를 수행하지 않아 하루 벌금이 4만원이 모여 다 같이 웃었습니다!"
        $0.isScrollEnabled = true
        $0.autocorrectionType = .no
        $0.spellCheckingType = .no
        $0.layer.borderColor = UIColor.gray.cgColor
        $0.layer.borderWidth = 1.0
        $0.layer.cornerRadius = 5.0
    }
    
    let saveButton = UIButton().then {
        $0.backgroundColor = UIColor(resource: .blue1)
        $0.setTitle("저장", for: .normal)
        $0.setTitleColor(UIColor(resource: .white2), for: .normal)
        $0.titleLabel?.font = UIFont.pretendard(size: 20, weight: .semibold)
        
        $0.layer.borderColor = UIColor.gray.cgColor
        $0.layer.borderWidth = 1.0
        $0.layer.cornerRadius = 5.0
    }
    
    override func setLayout() {
        addSubview(scrollView)
        
        scrollView.addSubview(contentView)
        
        contentView.addSubview(emojiLabel)
        contentView.addSubview(editButton)
        contentView.addSubview(dateLabel)
        contentView.addSubview(categoryButton)
        
        contentView.addSubview(categoryLabel)
        
        contentView.addSubview(container)
        
        container.addSubview(FtodoLabel)
        container.addSubview(FtodoTextView)
        container.addSubview(StodoLabel)
        container.addSubview(StodoTextView)
        
        contentView.addSubview(thankfulLabel)
        contentView.addSubview(thankfulTextView)
        
        contentView.addSubview(bestLabel)
        contentView.addSubview(bestTextView)
        contentView.addSubview(saveButton)
        
        emojiLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(30)
            $0.centerX.equalToSuperview()
        }
        
        editButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(40)
            $0.leading.equalTo(self.emojiLabel.snp.trailing).offset(100)
            $0.width.equalTo(30)
            $0.height.equalTo(30)
        }
        
        dateLabel.snp.makeConstraints {
            $0.top.equalTo(self.emojiLabel.snp.bottom).offset(40)
            $0.leading.equalToSuperview().inset(30)
            $0.trailing.lessThanOrEqualToSuperview().offset(-30)
        }
        
        categoryButton.snp.makeConstraints {
            $0.top.equalTo(self.emojiLabel.snp.bottom).offset(30)
            $0.leading.equalTo(dateLabel.snp.trailing).offset(60)
            $0.width.equalTo(150)
            $0.height.equalTo(50)
        }
        
        categoryLabel.snp.makeConstraints {
            $0.top.equalTo(self.dateLabel.snp.bottom).offset(50)
            $0.leading.equalToSuperview().inset(30)
            $0.trailing.lessThanOrEqualToSuperview().offset(-30)
        }
        
        container.snp.makeConstraints {
            $0.top.equalTo(self.categoryLabel.snp.bottom).offset(20)
            $0.leading.equalToSuperview().inset(30)
            $0.trailing.equalToSuperview().offset(-30)
        }
        
        FtodoLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
        
        FtodoTextView.snp.makeConstraints {
            $0.top.equalTo(self.FtodoLabel.snp.bottom).offset(20)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.height.equalTo(300)
        }
        
        StodoLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
        
        StodoTextView.snp.makeConstraints {
            $0.top.equalTo(self.StodoLabel.snp.bottom).offset(20)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.height.equalTo(300)
        }
        
        thankfulLabel.snp.makeConstraints {
            $0.top.equalTo(self.container.snp.bottom).offset(400)
            $0.leading.equalToSuperview().inset(30)
            $0.trailing.lessThanOrEqualToSuperview().offset(-30)
        }
        
        thankfulTextView.snp.makeConstraints {
            $0.top.equalTo(self.thankfulLabel.snp.bottom).offset(20)
            $0.leading.equalToSuperview().inset(30)
            $0.trailing.equalToSuperview().offset(-30)
            $0.height.equalTo(200)
        }
        
        bestLabel.snp.makeConstraints {
            $0.top.equalTo(self.thankfulTextView.snp.bottom).offset(50)
            $0.leading.equalToSuperview().inset(30)
            $0.trailing.lessThanOrEqualToSuperview().offset(-30)
        }
        
        bestTextView.snp.makeConstraints {
            $0.top.equalTo(self.bestLabel.snp.bottom).offset(20)
            $0.leading.equalToSuperview().inset(30)
            $0.trailing.equalToSuperview().offset(-30)
            $0.height.equalTo(200)
        }
        
        saveButton.snp.makeConstraints {
            $0.top.equalTo(self.bestTextView.snp.bottom).offset(50)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(340)
            $0.height.equalTo(50)
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

}
