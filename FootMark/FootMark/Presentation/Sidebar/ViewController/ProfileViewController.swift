//
//  ProfileViewController.swift
//  FootMark
//
//  Created by 윤성은 on 6/5/24.
//

import UIKit

class ProfileViewController: BaseViewController {
    var profileView = ProfileView()
    
    let editButton = UIButton().then {
        $0.setTitle("편집", for: .normal)
        $0.setTitleColor(.black, for: .normal)
    }
    
    let backButton = UIButton().then {
        $0.setTitle("취소", for: .normal)
        $0.setTitleColor(.black, for: .normal)
    }
    
    let confirmButton = UIButton().then {
        $0.setTitle("확인", for: .normal)
        $0.layer.cornerRadius = 10
        $0.backgroundColor = .systemBlue
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setUpDelegate()
        
        backButton.isHidden = true
        confirmButton.isHidden = true
    }
    
    override func setAddTarget() {
        editButton.addTarget(self, action: #selector(didTapEditButton), for: .touchUpInside)
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        confirmButton.addTarget(self, action: #selector(confirmButtonTapped), for: .touchUpInside)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        profileView.profileImage.addGestureRecognizer(tapGestureRecognizer)
    }
    
    func setUpDelegate() {
        profileView.nicknameTextField.delegate = self
        profileView.messageTextField.delegate = self
    }
    
    override func setLayout() {
        view.addSubview(profileView)
        view.addSubview(editButton)
        view.addSubview(backButton)
        view.addSubview(confirmButton)
        
        profileView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
        
        editButton.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.trailing.equalToSuperview().inset(20)
        }
        
        backButton.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.equalToSuperview().offset(20)
            $0.size.equalTo(CGSize(width: 44, height: 44))
        }
        
        confirmButton.snp.makeConstraints {
            $0.top.equalTo(profileView.messageUnderlineView.snp.bottom).offset(100)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(CGSize(width: 350, height: 44))
        }
    }
    
    @objc func imageTapped() {
        let imageVC = ProfileImageViewController()
        imageVC.image = profileView.profileImage.image
        imageVC.modalPresentationStyle = .overCurrentContext
        imageVC.modalTransitionStyle = .crossDissolve
        present(imageVC, animated: true)
    }
    
    @objc func didTapEditButton() {
        profileView.isEditingMode.toggle()
        
        backButton.isHidden = !profileView.isEditingMode
        confirmButton.isHidden = !profileView.isEditingMode
        editButton.isHidden = profileView.isEditingMode
        
        if profileView.isEditingMode {
            profileView.nicknameTextField.becomeFirstResponder()
        }
    }
    
    @objc private func backButtonTapped() {
        profileView.isEditingMode = false
        
        backButton.isHidden = true
        confirmButton.isHidden = true
        editButton.isHidden = false
    }
    
    @objc private func confirmButtonTapped() {
        profileView.isEditingMode = false
        
        backButton.isHidden = true
        confirmButton.isHidden = true
        editButton.isHidden = false
    }
}

extension ProfileViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return profileView.isEditingMode
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == profileView.nicknameTextField {
            profileView.nicknameUnderlineView.backgroundColor = .black
        } else if textField == profileView.messageTextField {
            profileView.messageUnderlineView.backgroundColor = .black
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == profileView.nicknameTextField {
            profileView.nicknameUnderlineView.backgroundColor = .gray
        } else if textField == profileView.messageTextField {
            profileView.messageUnderlineView.backgroundColor = .gray
        }
    }
}
