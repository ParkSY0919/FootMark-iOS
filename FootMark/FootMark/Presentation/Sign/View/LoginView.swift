//
//  LoginView.swift
//  FootMark
//
//  Created by 박신영 on 3/27/24.
//

import UIKit
import SnapKit
import Then

class LoginView: BaseView {
    
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
    
    // MARK: - Initialization
    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setupViews()
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    // MARK: - Private Methods
    
    private func setupViews() {
        addSubview(idTextField)
        addSubview(passwordTextField)
        
        idTextField.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
        }
        
        passwordTextField.snp.makeConstraints {
            $0.top.equalTo(idTextField.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview()
        }
    }
}
