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

   // Logo & Label
   let footMarkLogo = UIImageView(image: .swLogo)
   let footMarkLabel = UILabel().then{
      $0.setVigaFont(text: "FootMark", size: 35, weight: .bold, letterSpacing: 1.37)
      $0.textColor = .SWprimary
      $0.textAlignment = .center
   }
   
   //apple SignIn Button
   let appleSignInButton = UIButton()
   let appleLogo = UIImageView(image: .appleSignInButton)
   let appleSignInTitle = UILabel().then{
      $0.setPretendardFont(text: "Sign in with Apple", size: 17.0, weight: .regular, letterSpacing: 1.23)
      $0.textAlignment = .center
      $0.textColor = UIColor.White()
   }
   
   //Google SignIn Button
   let googleSignInButton = UIButton()
   let googleLogo = UIImageView(image: .googleSignInButton)
   let googleLogoBackGround = UIView()
   let googleSignInTitle = UILabel().then{
      $0.setPretendardFont(text: "Sign in with Google", size: 17.0, weight: .regular, letterSpacing: 1.23)
      $0.textAlignment = .center
      $0.textColor = UIColor.White()
   }
   
   override func setUI() {
      addSubviews(footMarkLogo, footMarkLabel)
      addSubviews(googleSignInButton, appleSignInButton)
      
      //AppleSignInButton
      appleSignInButton.addSubviews(appleLogo, appleSignInTitle)
      
      appleSignInButton.do {
         $0.backgroundColor = .black
         $0.layer.cornerRadius = 12
         $0.layer.borderWidth = 2
         $0.layer.borderColor = UIColor.white1.cgColor
      }
      
      googleLogoBackGround.do {
         $0.backgroundColor = .blue1
         $0.layer.cornerRadius = 10
         $0.layer.borderWidth = 0.5
         $0.layer.borderColor = UIColor.white.cgColor
      }
      
      googleSignInButton.do {
         $0.backgroundColor = .blue1
         $0.layer.cornerRadius = 12
         $0.layer.borderWidth = 2
         $0.layer.borderColor = UIColor.white1.cgColor
      }
      
      //GoogleSignInButton
      googleSignInButton.addSubviews(googleLogoBackGround, googleSignInTitle)
      googleLogoBackGround.addSubview(googleLogo)
   }
   
   override func setLayout() {
      //Logo Design
      footMarkLogo.snp.makeConstraints{
         $0.centerX.equalTo(self.safeAreaLayoutGuide.snp.centerX)
         $0.centerY.equalToSuperview().offset(-100)
         $0.width.equalTo(192)
         $0.height.equalTo(177)
      }
      
      footMarkLabel.snp.makeConstraints {
         $0.centerX.equalTo(self.safeAreaLayoutGuide.snp.centerX)
         $0.top.equalTo(footMarkLogo.snp.bottom).offset(20)
      }
      
      appleSignInButton.snp.makeConstraints {
         $0.top.equalTo(footMarkLabel.snp.bottom).offset(70)
         $0.leading.equalTo(self.safeAreaLayoutGuide.snp.leading).offset(20)
         $0.trailing.equalTo(self.safeAreaLayoutGuide.snp.trailing).offset(-20)
         $0.height.equalTo(48)
      }
      
      appleLogo.snp.makeConstraints {
         $0.centerY.equalToSuperview()
         $0.leading.equalToSuperview().offset(24)
         $0.width.equalTo(17)
         $0.height.equalTo(20)
      }
      
      appleSignInTitle.snp.makeConstraints {
         $0.centerY.equalToSuperview()
         $0.centerX.equalToSuperview()
      }
      
      googleLogo.snp.makeConstraints {
         $0.width.height.equalTo(17)
         $0.centerX.centerY.equalToSuperview()
      }
      
      googleLogoBackGround.snp.makeConstraints{
         $0.centerY.equalToSuperview()
         $0.leading.equalToSuperview().offset(24)
         $0.width.height.equalTo(20)
      }
      
      googleSignInTitle.snp.makeConstraints {
         $0.centerY.equalToSuperview()
         $0.centerX.equalToSuperview()
      }
      
      googleSignInButton.snp.makeConstraints {
         $0.top.equalTo(appleSignInButton.snp.bottom).offset(30)
         $0.leading.trailing.height.equalTo(appleSignInButton)
      }
   }
   
}
