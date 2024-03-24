//
//  DiaryView.swift
//  FootMark
//
//  Created by 윤성은 on 3/24/24.
//

import UIKit
import ElegantEmojiPicker

class DiaryView: BaseView {
    
    let emojiLabel = UILabel().then {
        $0.setPretendardFont(text: "🫥", size: 50, weight: .bold, letterSpacing: 1.25)
        $0.isUserInteractionEnabled = true
    }
    
    var emojiPickerHandler: (() -> Void)?
    
    override func setUI() {
        addSubviews(emojiLabel)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(emojiLabelTapped))
        emojiLabel.addGestureRecognizer(tapGesture)
    }
    
    override func setLayout() {
        
        emojiLabel.snp.makeConstraints {
            $0.top.equalTo(70)
            $0.centerX.equalToSuperview()
        }
    }
    
    @objc func emojiLabelTapped() {
        emojiPickerHandler?()
    }
}
