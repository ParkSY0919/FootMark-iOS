//
//  ProfileImageViewController.swift
//  FootMark
//
//  Created by 윤성은 on 6/5/24.
//

import UIKit

class ProfileImageViewController: BaseViewController {
    var image: UIImage?
    
    let imageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
    }
    
    let backButton = UIButton().then {
        $0.setTitle("X", for: .normal)
        $0.setTitleColor(UIColor(resource: .white2), for: .normal)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.black
        
        imageView.image = image
    }
    
    override func setLayout() {
        view.addSubview(imageView)
        view.addSubview(backButton)
        
        imageView.snp.makeConstraints() {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        backButton.snp.makeConstraints() {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(10)
        }
    }
    
    override func setAddTarget() {
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
    }
    
    @objc private func backButtonTapped() {
        print("back")
        self.dismiss(animated: true, completion: nil)
    }
}
