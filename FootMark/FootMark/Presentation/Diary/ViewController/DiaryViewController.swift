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
        
//        let categorySource: [String] = ["운동하기", "약속", "공부하기"]
        let actionClosure: (UIAction) -> Void = { [weak self] action in
            print(action.title)
            self?.diaryView.categoryLabel.text = action.title
        }
        
//        diaryView.categoryButton.menu = UIMenu(children: categorySource.map { category in
//            UIAction(title: category, handler: actionClosure)
//        })
//        diaryView.categoryButton.showsMenuAsPrimaryAction = true
//        diaryView.categoryButton.changesSelectionAsPrimaryAction = true
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
