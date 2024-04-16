//
//  DiaryViewController.swift
//  FootMark
//
//  Created by 윤성은 on 3/24/24.
//

import UIKit
import ElegantEmojiPicker

class DiaryViewController: BaseViewController, ElegantEmojiPickerDelegate, UITextFieldDelegate, UITextViewDelegate {
    
    var diaryView = DiaryView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.White()
        
        diaryView.emojiPickerHandler = { [weak self] in
            self?.PresentEmojiPicker()
        }
        
        let actionClosure: (UIAction) -> Void = { [weak self] action in
            print(action.title)
            self?.diaryView.categoryLabel.text = action.title
        }
        
        diaryView.todoTextView.delegate = self
//        diaryView.onSaveButtonTapped = {
//            self.saveButtonTapped()
//        }
    }
    
    override func setUI() {
        view.addSubviews(diaryView)
    }
    
    override func setLayout() {
        
        diaryView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    override func setAddTarget() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(emojiLabelTapped))
        diaryView.emojiLabel.addGestureRecognizer(tapGesture)
        
        diaryView.categoryButton.addTarget(self, action: #selector(categoryButtonTapped), for: .touchUpInside)
        
        setupDropDown()
        
        diaryView.saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
    }
    
    func PresentEmojiPicker () {
        let picker = ElegantEmojiPicker(delegate: self)
        self.present(picker, animated: true)
    }
    
    func emojiPicker(_ picker: ElegantEmojiPicker, didSelectEmoji emoji: Emoji?) {
        guard let emoji = emoji else { return }
        
        diaryView.emojiLabel.text = emoji.emoji
    }
    
    func showEmojiPicker() {
        let picker = ElegantEmojiPicker(delegate: diaryView as! ElegantEmojiPickerDelegate)
        self.present(picker, animated: true)
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
            if text == "\n" {
                textView.resignFirstResponder()
                return false
            }
            return true
        }
    
    @objc func emojiLabelTapped() {
        diaryView.emojiPickerHandler?()
    }
    
    func setupDropDown() {
        diaryView.dropDown.anchorView = diaryView.categoryButton
        diaryView.dropDown.topOffset = CGPoint(x: 0, y: diaryView.categoryButton.bounds.height)
        diaryView.dropDown.dataSource = ["운동", "약속", "공부"]
        
        diaryView.dropDown.selectionAction = { [weak self] (index: Int, item: String) in
            self?.diaryView.categoryButton.setTitle(item, for: .normal)
            self?.diaryView.categoryLabel.text = item
        }
    }
    
    @objc func categoryButtonTapped() {
        diaryView.dropDown.show()
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        print("텍스트 필드 편집 시작")
    }

    func textViewDidEndEditing(_ textField: UITextView) {
        print("텍스트 필드 편집 종료")
    }

    @objc func saveButtonTapped() {
        print("save")
        }
}
