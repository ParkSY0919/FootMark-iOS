//
//  ViewController.swift
//  FootMark
//
//  Created by 윤성은 on 3/26/24.
//

import UIKit
import SnapKit
import Then

class DiaryViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupGesture()
    }
    
    let imageView: UIImageView = {
        let aImageView = UIImageView()
        aImageView.backgroundColor = .white
        aImageView.image = UIImage(named: "Diary")
        return aImageView
    }()
    
    let secImageView: UIImageView = {
        let aImageView = UIImageView()
        aImageView.backgroundColor = .white
        aImageView.image = UIImage(named: "Diary (1)")
        return aImageView
    }()
    
    override func setUI() {
        self.view.addSubview(imageView)
        self.view.addSubview(secImageView)
    }
    
    override func setLayout() {
        imageView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
        secImageView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
        
        secImageView.isHidden = true
    }
    
    private func setupGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        imageView.addGestureRecognizer(tapGesture)
        imageView.isUserInteractionEnabled = true
    }
    
    @objc private func handleTap(_ sender: UITapGestureRecognizer) {
        UIView.transition(from: imageView,
                          to: secImageView,
                          duration: 0.5,
                          options: .transitionFlipFromRight) { _ in
            self.imageView.isHidden = true
            self.secImageView.isHidden = false
        }
    }
}
