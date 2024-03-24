//
//  DiaryViewController.swift
//  FootMark
//
//  Created by 윤성은 on 3/24/24.
//

import UIKit
import ElegantEmojiPicker

class DiaryViewController: BaseViewController, ElegantEmojiPickerDelegate {
    
    var diaryView = DiaryView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.White()
        
        diaryView.emojiPickerHandler = { [weak self] in
            self?.PresentEmojiPicker()
        }
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
    
}
