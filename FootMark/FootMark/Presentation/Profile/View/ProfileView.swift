//
//  ProfileView.swift
//  FootMark
//
//  Created by 윤성은 on 6/5/24.
//

import UIKit

class ProfileView: BaseView {
    var isEditingMode: Bool = false {
        didSet {
            updateViewMode()
        }
    }
    
    private func updateViewMode() {
        nicknameTextField.isUserInteractionEnabled = isEditingMode
        messageTextField.isUserInteractionEnabled = isEditingMode
    }
    
    let profileImage = UIImageView().then {
        $0.image = UIImage(named: "profile")?.resizeImageUsingCoreGraphics(targetSize: CGSize(width: 30, height: 30))
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 75
        $0.layer.borderColor = UIColor.gray.cgColor
        $0.layer.borderWidth = 1.0
        $0.isUserInteractionEnabled = true
    }
    
    let titleLabel = UILabel().then {
        $0.setPretendardFont(text: "기본프로필", size: 30, weight: .bold, letterSpacing: 1.25)
        $0.textAlignment = .center
    }
    
    let nicknameTextField = UITextField().then {
        $0.font = UIFont.systemFont(ofSize: 20)
        $0.borderStyle = .none
        $0.text = "사용자 닉네임"
        $0.clearButtonMode = .whileEditing
    }
    
    let nicknameUnderlineView = UIView().then {
        $0.backgroundColor = .gray
    }
    
    let messageTextField = UITextField().then {
        $0.font = UIFont.systemFont(ofSize: 20)
        $0.borderStyle = .none
        $0.text = "상태메세지"
        $0.clearButtonMode = .whileEditing
    }
    
    let messageUnderlineView = UIView().then {
        $0.backgroundColor = .gray
    }
    
    override func setLayout() {
        addSubview(titleLabel)
        addSubview(profileImage)
        addSubview(nicknameTextField)
        addSubview(nicknameUnderlineView)
        addSubview(messageTextField)
        addSubview(messageUnderlineView)
        
        titleLabel.snp.makeConstraints() {
            $0.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
        }
        
        profileImage.snp.makeConstraints() {
            $0.top.equalTo(self.titleLabel.snp.bottom).offset(50)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(CGSize(width: 150, height: 150))
        }
        
        nicknameTextField.snp.makeConstraints() {
            $0.top.equalTo(self.profileImage.snp.bottom).offset(50)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
        }
        
        nicknameUnderlineView.snp.makeConstraints() {
            $0.top.equalTo(self.nicknameTextField.snp.bottom).offset(4)
            $0.leading.equalTo(self.nicknameTextField.snp.leading)
            $0.trailing.equalTo(self.nicknameTextField.snp.trailing)
            $0.height.equalTo(1)
        }
        
        messageTextField.snp.makeConstraints() {
            $0.top.equalTo(self.nicknameUnderlineView.snp.bottom).offset(50)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
        }
        
        messageUnderlineView.snp.makeConstraints() {
            $0.top.equalTo(self.messageTextField.snp.bottom).offset(4)
            $0.leading.equalTo(self.nicknameTextField.snp.leading)
            $0.trailing.equalTo(self.nicknameTextField.snp.trailing)
            $0.height.equalTo(1)
        }
    }
}
