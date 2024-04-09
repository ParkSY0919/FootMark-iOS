//
//  SignViewController.swift
//  FootMark
//
//  Created by 박신영 on 3/27/24.
//

import UIKit
import SnapKit
import Then

class SignViewController: BaseViewController, UITextFieldDelegate {
    
    // MARK: - Properties
    
   private lazy var segmentedControl: UISegmentedControl = {
       let segmentedControl = UISegmentedControl(items: ["Sign In", "Sign Up"])
       segmentedControl.selectedSegmentIndex = 0
       segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged(_:)), for: .valueChanged)

       // 선택된 아이템 속성 설정
       segmentedControl.setTitleTextAttributes([
           .foregroundColor: UIColor.black,
           .font: UIFont.systemFont(ofSize: 16, weight: .bold)
       ], for: .selected)

       // 선택되지 않은 아이템 속성 설정
       segmentedControl.setTitleTextAttributes([
           .foregroundColor: UIColor.white,
           .font: UIFont.systemFont(ofSize: 16),
       ], for: .normal)
      
      let appearance = UISegmentedControl.appearance()
          appearance.setContentPositionAdjustment(UIOffset(horizontal: 5.0, vertical: 5.0), forSegmentType: .any, barMetrics: .default)
          appearance.layer.cornerRadius = 30
          appearance.layer.masksToBounds = true

       return segmentedControl
   }()
   
    
    private let loginView = LoginView()
    private let signUpView = SignUpView()
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
       print("뷰 로드")
       loginView.idTextField.delegate = self
    }
    
    // MARK: - Private Methods
    
    private func setupViews() {
        view.addSubview(segmentedControl)
        view.addSubview(loginView)
        view.addSubview(signUpView)
        
       segmentedControl.snp.makeConstraints {
          $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(16)
          $0.leading.equalToSuperview().offset(16)
          $0.trailing.equalToSuperview().offset(-16)
          $0.height.equalTo(60) // 높이를 40으로 설정
       }
        
        loginView.snp.makeConstraints {
            $0.top.equalTo(segmentedControl.snp.bottom).offset(16)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-16)
        }
        
        signUpView.snp.makeConstraints {
            $0.edges.equalTo(loginView.snp.edges)
        }
        
        signUpView.isHidden = true
    }
    
    @objc private func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        loginView.isHidden = sender.selectedSegmentIndex != 0
        signUpView.isHidden = sender.selectedSegmentIndex != 1
    }
   
   
   func textFieldDidChangeSelection(_ textField: UITextField) {
           if textField == loginView.idTextField {
               print("idTextField 텍스트 변경: \(textField.text ?? "")")
           }
       }
}
