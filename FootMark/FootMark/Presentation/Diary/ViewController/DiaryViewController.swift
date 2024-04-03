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
    }
    
    override func setUI() {
        view.addSubviews(diaryView)
    }
    
    override func setLayout() {
        
        diaryView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
            $0.centerX.equalToSuperview()
        }
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
                textView.resignFirstResponder() // 키보드 숨김
                return false
            }
            return true
        }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        print("텍스트 필드 편집 시작")
    }

    func textViewDidEndEditing(_ textField: UITextView) {
        print("텍스트 필드 편집 종료")
    }

}
