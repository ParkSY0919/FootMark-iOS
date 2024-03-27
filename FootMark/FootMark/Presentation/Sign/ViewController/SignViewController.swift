//
//  SignViewController.swift
//  FootMark
//
//  Created by 박신영 on 3/27/24.
//

import UIKit
import SnapKit
import Then

class SignViewController: BaseViewController {
    
    // MARK: - Properties
    
    private let segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["Login", "Sign Up"])
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged(_:)), for: .valueChanged)
        return segmentedControl
    }()
    
    private let loginView = LoginView()
    private let signUpView = SignUpView()
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
       print("뷰 로드")
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
            $0.height.equalTo(30)
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
}
