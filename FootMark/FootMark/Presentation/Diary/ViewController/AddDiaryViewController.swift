//
//  AddDiaryViewController.swift
//  FootMark
//
//  Created by 윤성은 on 6/9/24.
//

import UIKit
import ElegantEmojiPicker
import DropDown

class AddDiaryViewController: BaseViewController {
    var addDiaryView = AddDiaryView()
    let dropDown = DropDown()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(resource: .black1)
        
        navigationController?.navigationBar.isHidden = true
        
        setUpDelegates()
        setUpClosures()
        setupDropDown()
    }
    
    override func setLayout() {
        view.addSubviews(addDiaryView)
        
        addDiaryView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    override func setAddTarget() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(emojiLabelTapped))
        addDiaryView.emojiLabel.addGestureRecognizer(tapGesture)
        
        addDiaryView.categoryButton.addTarget(self, action: #selector(categoryButtonTapped), for: .touchUpInside)
        
        addDiaryView.saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
    }
    
    func setUpDelegates() {
        addDiaryView.todoTextView.delegate = self
        addDiaryView.thankfulTextView.delegate = self
        addDiaryView.bestTextView.delegate = self
    }
    
    func setUpClosures() {
        addDiaryView.emojiPickerHandler = { [weak self] in
            self?.PresentEmojiPicker()
        }
        
        let actionClosure: (UIAction) -> Void = { [weak self] action in
            self?.addDiaryView.categoryLabel.text = action.title
        }
    }
    
    @objc func categoryButtonTapped() {
        dropDown.show()
    }
    
    func setupDropDown() {
        let todoLabelContents = [
            "운동": "수영, 산책, 달리기",
            "공부": "Swift, 알고리즘"
        ]
        
        dropDown.anchorView = addDiaryView.categoryButton
        dropDown.bottomOffset = CGPoint(x: 0, y: addDiaryView.categoryButton.bounds.height + 80)
        dropDown.dataSource = ["운동", "공부"]
        dropDown.backgroundColor = .white
        
        dropDown.textFont = UIFont.pretendard(size: 18, weight: .regular)
        
        if let firstCategory = dropDown.dataSource.first {
            addDiaryView.categoryButton.setTitle(firstCategory, for: .normal)
            addDiaryView.categoryLabel.text = firstCategory
            addDiaryView.todoLabel.text = todoLabelContents[firstCategory]
        }
        
        dropDown.selectionAction = { [weak self] (index: Int, item: String) in
            self?.addDiaryView.categoryButton.setTitle(item, for: .normal)
            self?.addDiaryView.categoryLabel.text = item
            self?.addDiaryView.todoTextView.text = ""
            self?.addDiaryView.todoLabel.text = todoLabelContents[item]
        }
    }
    
    
    @objc func saveButtonTapped() {
        print("save")
    }
}

extension AddDiaryViewController: ElegantEmojiPickerDelegate {
    func PresentEmojiPicker() {
        let picker = ElegantEmojiPicker(delegate: self)
        self.present(picker, animated: true)
    }
    
    func emojiPicker(_ picker: ElegantEmojiPicker, didSelectEmoji emoji: Emoji?) {
        guard let emoji = emoji else { return }
        addDiaryView.emojiLabel.text = emoji.emoji
    }
    
    @objc func emojiLabelTapped() {
        addDiaryView.emojiPickerHandler?()
    }
}

extension AddDiaryViewController: UITextViewDelegate {
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
