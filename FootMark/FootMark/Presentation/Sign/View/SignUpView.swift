//
//  SignUpView.swift
//  FootMark
//
//  Created by 박신영 on 3/27/24.
//

import UIKit
import SnapKit
import Then

class SignUpView: BaseView {

    // MARK: - Properties
    
    private let idTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "ID"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.borderStyle = .roundedRect
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private let confirmPasswordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Confirm Password"
        textField.borderStyle = .roundedRect
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private let locationTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Location"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
   
   override func setLayout() {
      addSubview(idTextField)
      addSubview(passwordTextField)
      addSubview(confirmPasswordTextField)
      addSubview(locationTextField)
      
      idTextField.snp.makeConstraints {
          $0.top.leading.trailing.equalToSuperview()
      }
      
      passwordTextField.snp.makeConstraints {
          $0.top.equalTo(idTextField.snp.bottom).offset(16)
          $0.leading.trailing.equalToSuperview()
      }
      
      confirmPasswordTextField.snp.makeConstraints {
          $0.top.equalTo(passwordTextField.snp.bottom).offset(16)
          $0.leading.trailing.equalToSuperview()
      }
      
      locationTextField.snp.makeConstraints {
          $0.top.equalTo(confirmPasswordTextField.snp.bottom).offset(16)
          $0.leading.trailing.equalToSuperview()
      }
   }
   
}