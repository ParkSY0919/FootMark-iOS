//
//  SignViewController.swift
//  FootMark
//
//  Created by 박신영 on 3/26/24.
//

import UIKit
import SnapKit
import Then


class SignViewController: BaseViewController {
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      setupGesture()
   }
   
   let signInView: UIImageView = {
      let imageView = UIImageView()
      imageView.backgroundColor = .white
      imageView.image = UIImage(named: "Login")
      imageView.translatesAutoresizingMaskIntoConstraints = false
      return imageView
   }()
   
   let signUpView: UIImageView = {
      let imageView = UIImageView()
      imageView.backgroundColor = .white
      imageView.image = UIImage(named: "Login2")
      imageView.translatesAutoresizingMaskIntoConstraints = false
      return imageView
   }()
   
   override func setUI() {
      self.view.addSubview(signInView)
      self.view.addSubview(signUpView)
   }
   
   override func setLayout() {
      signInView.snp.makeConstraints {
         $0.top.bottom.leading.trailing.equalToSuperview()
      }
      
      signUpView.snp.makeConstraints {
         $0.top.bottom.leading.trailing.equalToSuperview()
      }
      
      signUpView.isHidden = true
   }
   
   private func setupGesture() {
      let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
      signInView.addGestureRecognizer(tapGesture)
      signInView.isUserInteractionEnabled = true
      
      let tapGesture1 = UITapGestureRecognizer(target: self, action: #selector(handleTap1(_:)))
      signUpView.addGestureRecognizer(tapGesture1)
      signUpView.isUserInteractionEnabled = true
   }
   
   @objc private func handleTap(_ sender: UITapGestureRecognizer) {
      UIView.transition(from: signInView,
                        to: signUpView,
                        duration: 0.5,
                        options: .transitionFlipFromRight) { _ in
         self.signInView.isHidden = true
         self.signUpView.isHidden = false
      }
   }
   
   @objc private func handleTap1(_ sender: UITapGestureRecognizer) {
       let main2VC = Main2ViewController()
      main2VC.navigationItem.hidesBackButton = true
       navigationController?.pushViewController(main2VC, animated: true)
      
   }
   
}
