//
//  ProfileViewController.swift
//  FootMark
//
//  Created by 윤성은 on 6/5/24.
//

import UIKit
import KeychainSwift

class ProfileViewController: BaseViewController {
   var profileView = ProfileView()
   
   let editButton = UIButton().then {
      $0.setTitle("편집", for: .normal)
      $0.setTitleColor(UIColor(resource: .white2), for: .normal)
   }
   
   let backButton = UIButton().then {
      $0.setTitle("취소", for: .normal)
      $0.setTitleColor(UIColor(resource: .white2), for: .normal)
   }
   
   let confirmButton = UIButton().then {
      $0.setTitle("확인", for: .normal)
      $0.setTitleColor(UIColor(resource: .white2), for: .normal)
      $0.layer.cornerRadius = 10
      $0.backgroundColor = UIColor(resource: .blue1)
   }
   
   override func viewDidLoad() {
      super.viewDidLoad()
      view.backgroundColor = UIColor(resource: .black1)
      
      setUpDelegate()
      
      backButton.isHidden = true
      confirmButton.isHidden = true
      navigationController?.navigationBar.isHidden = false
      loadData()
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
   
   func loadData() {
      let keychain = KeychainSwift()
      let kingFisher = KingFisher()
      let image = profileView.profileImage
      let url = keychain.get("userImage")
      let userdefaultsNickName = UserDefaults.standard.string(forKey: "nickName")
      profileView.nicknameTextField.text = userdefaultsNickName
      kingFisher.loadProfileImage(url: url ?? "", image: image)
      print("Profile loadImage 끝~")
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
      profileView.profileImage.isUserInteractionEnabled = !profileView.isEditingMode
      
      if profileView.isEditingMode {
         profileView.nicknameTextField.becomeFirstResponder()
      }
   }
   
   @objc private func backButtonTapped() {
      profileView.isEditingMode = false
      
      backButton.isHidden = true
      confirmButton.isHidden = true
      editButton.isHidden = false
      profileView.profileImage.isUserInteractionEnabled = true
   }
   
   @objc private func confirmButtonTapped() {
      let nickRegEx = "^[^\\s][가-힣A-Za-z0-9\\s]{0,5}[^\\s]$"
      let nickTest = NSPredicate(format: "SELF MATCHES %@", nickRegEx)
      
      let messageRegEx = "^[^\\s][가-힣A-Za-z0-9!@#$%^&*(),.?\":{}|<>~]{2,8}[^\\s]$"
      let messageTest = NSPredicate(format: "SELF MATCHES %@", messageRegEx)
      
      if nickTest.evaluate(with: profileView.nicknameTextField.text) && messageTest.evaluate(with: profileView.messageTextField.text) {
         UserDefaults.standard.set(profileView.nicknameTextField.text, forKey: "nickName")
         UserDefaults.standard.set(profileView.messageTextField.text, forKey: "messageText")
         profileView.isEditingMode = false
         
         backButton.isHidden = true
         confirmButton.isHidden = true
         editButton.isHidden = false
         profileView.profileImage.isUserInteractionEnabled = true
         DispatchQueue.main.async {
            if let navigationController = self.navigationController,
               let mainVC = navigationController.viewControllers.first(where: { $0 is MainViewController }) as? MainViewController {
               mainVC.nickNameLabel.text = self.profileView.nicknameTextField.text
               mainVC.messageLabel.text = self.profileView.messageTextField.text
            }
            self.showAlert(title: "수정 완료",
                           message: "성공적으로 수정되었습니다.",
                           confirmButtonName: "확인")
         }
      } else if !nickTest.evaluate(with: profileView.nicknameTextField.text) {
         profileView.isEditingMode = true
         
         backButton.isHidden = false
         confirmButton.isHidden = false
         editButton.isHidden = true
         profileView.profileImage.isUserInteractionEnabled = true
         // nickRegEx를 어긴 경우 처리 (예: 경고 메시지 표시)
         DispatchQueue.main.async {
            self.showAlert(title: "닉네임 변경 불가능",
                           message: "1. 특수문자는 입력이 불가능합니다.\n2. 닉네임 길이 규정은 2글자 이상 7글자 이하입니다.\n3. 'ㅍㅜㅅㅁㅏㅋㅡ'와 글 자소 입력은 불가능합니다.\n4. 첫 자와 마지막 글자는 공백이 불가능합니다.",
                           confirmButtonName: "확인")
         }
      } else if !messageTest.evaluate(with: profileView.messageTextField.text) {
         profileView.isEditingMode = true
         
         backButton.isHidden = false
         confirmButton.isHidden = false
         editButton.isHidden = true
         profileView.profileImage.isUserInteractionEnabled = true
         // nickRegEx를 어긴 경우 처리 (예: 경고 메시지 표시)
         DispatchQueue.main.async {
            self.showAlert(title: "상태메세지 변경 불가능",
                           message: "1. '' or ' '와 같이 미입력 혹은 공백 시작 및 단독 입력은 불가합니다.\n2. 메세지 길이 규정은 2글자 이상 8글자 이하입니다.\n3. 'ㅍㅜㅅㅁㅏㅋㅡ'와 글 자소 입력은 불가능합니다.",
                           confirmButtonName: "확인")
         }
      }
      
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
         profileView.nicknameUnderlineView.backgroundColor = UIColor(resource: .white2)
      } else if textField == profileView.messageTextField {
         profileView.messageUnderlineView.backgroundColor = UIColor(resource: .white2)
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
