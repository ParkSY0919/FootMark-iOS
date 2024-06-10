//
//  DiaryViewController.swift
//  FootMark
//
//  Created by 윤성은 on 3/24/24.
//

import UIKit
import ElegantEmojiPicker
import DropDown

class DiaryViewController: BaseViewController {
    var diaryView = DiaryView()
    let dropDown = DropDown()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(resource: .black1)
        navigationController?.navigationBar.isHidden = true
        
        setUpDelegates()
        setUpClosures()
        setupDropDown()
        
        self.diaryView.FtodoLabel.isHidden = false
        self.diaryView.FtodoTextView.isHidden = false
        self.diaryView.FtodoTextView.isEditable = false
        self.diaryView.FtodoTextView.isUserInteractionEnabled = false
        
        self.diaryView.StodoLabel.isHidden = true
        self.diaryView.StodoTextView.isHidden = true
        self.diaryView.StodoTextView.isEditable = false
        self.diaryView.StodoTextView.isUserInteractionEnabled = false
        
        self.diaryView.thankfulTextView.isEditable = false
        self.diaryView.bestTextView.isEditable = false
        
        diaryView.saveButton.isHidden = true
        diaryView.editButton.isHidden = false
    }
    
    override func setLayout() {
        view.addSubviews(diaryView)
        
        diaryView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    override func setAddTarget() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(emojiLabelTapped))
        diaryView.emojiLabel.addGestureRecognizer(tapGesture)
        
        diaryView.categoryButton.addTarget(self, action: #selector(categoryButtonTapped), for: .touchUpInside)
        
        diaryView.editButton.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
        
        diaryView.saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
    }
    
    func setUpDelegates() {
        diaryView.FtodoTextView.delegate = self
        diaryView.thankfulTextView.delegate = self
        diaryView.bestTextView.delegate = self
    }
    
    func setUpClosures() {
        diaryView.emojiPickerHandler = { [weak self] in
            self?.PresentEmojiPicker()
        }
        
        let actionClosure: (UIAction) -> Void = { [weak self] action in
            self?.diaryView.categoryLabel.text = action.title
        }
    }
    
    @objc func categoryButtonTapped() {
        dropDown.show()
    }
    
    func setupDropDown() {
        dropDown.anchorView = diaryView.categoryButton
        dropDown.bottomOffset = CGPoint(x: 0, y: diaryView.categoryButton.bounds.height + 80)
        dropDown.dataSource = ["운동", "공부"]
        dropDown.backgroundColor = .white
        
        dropDown.textFont = UIFont.pretendard(size: 18, weight: .regular)
        
        if let firstCategory = dropDown.dataSource.first {
            diaryView.categoryButton.setTitle(firstCategory, for: .normal)
            diaryView.categoryLabel.text = firstCategory
        }
        
        dropDown.selectionAction = { [weak self] (index: Int, item: String) in
            guard let self = self else { return }
            
            self.diaryView.categoryButton.setTitle(item, for: .normal)
            self.diaryView.categoryLabel.text = item
            
            // 운동 카테고리를 선택했을 때
            if item == "운동" {
                self.diaryView.FtodoLabel.isHidden = false
                self.diaryView.FtodoTextView.isHidden = false
                self.diaryView.StodoLabel.isHidden = true
                self.diaryView.StodoTextView.isHidden = true
            }
            // 공부 카테고리를 선택했을 때
            else if item == "공부" {
                self.diaryView.FtodoLabel.isHidden = true
                self.diaryView.FtodoTextView.isHidden = true
                self.diaryView.StodoLabel.isHidden = false
                self.diaryView.StodoTextView.isHidden = false
            }
            // 다른 카테고리를 선택했을 때는 모두 숨김 처리
            else {
                self.diaryView.FtodoLabel.isHidden = true
                self.diaryView.FtodoTextView.isHidden = true
                self.diaryView.StodoLabel.isHidden = true
                self.diaryView.StodoTextView.isHidden = true
            }
        }
    }
    
    @objc func editButtonTapped() {
        // StodoTextView 제거
        diaryView.StodoTextView.removeFromSuperview()
        
        // emojiLabel 활성화
        diaryView.emojiLabel.isHidden = false
        diaryView.emojiLabel.isUserInteractionEnabled = true
        
        // FtodoTextView 활성화
        diaryView.FtodoTextView.isHidden = false
        diaryView.FtodoTextView.isEditable = true
        diaryView.FtodoTextView.isUserInteractionEnabled = true
        diaryView.FtodoTextView.becomeFirstResponder()
        
        diaryView.thankfulTextView.isEditable = true
        diaryView.bestTextView.isEditable = true
        
        // 레이아웃 갱신
        diaryView.setNeedsLayout()
        diaryView.layoutIfNeeded()
        
        // 버튼 상태 변경
        diaryView.saveButton.isHidden = false
        diaryView.editButton.isHidden = true
    }
    
    @objc func saveButtonTapped() {
        // FtodoTextView 비활성화
        diaryView.FtodoTextView.isEditable = false
        diaryView.FtodoTextView.isUserInteractionEnabled = false
        
        // StodoTextView 비활성화
        diaryView.StodoTextView.isEditable = false
        diaryView.StodoTextView.isUserInteractionEnabled = false
        
        diaryView.thankfulTextView.isEditable = false
        diaryView.bestTextView.isEditable = false
        
        // 버튼 상태 변경
        diaryView.saveButton.isHidden = true
        diaryView.editButton.isHidden = false
        
        diaryView.scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }
}

extension DiaryViewController: ElegantEmojiPickerDelegate {
    func PresentEmojiPicker() {
        let picker = ElegantEmojiPicker(delegate: self)
        self.present(picker, animated: true)
    }
    
    func emojiPicker(_ picker: ElegantEmojiPicker, didSelectEmoji emoji: Emoji?) {
        guard let emoji = emoji else { return }
        diaryView.emojiLabel.text = emoji.emoji
    }
    
    @objc func emojiLabelTapped() {
        diaryView.emojiPickerHandler?()
    }
}

extension DiaryViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        print("텍스트 필드 편집 시작")
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        print("텍스트 필드 편집 종료")
    }
}
