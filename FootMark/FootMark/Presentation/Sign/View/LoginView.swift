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
   let footMarkLogo = UIImageView(image: Image.footMarkLogo)
   let footMarkLabel = UILabel().then{
      $0.setVigaFont(text: "FootMark", size: 25.0, weight: .black, letterSpacing: 1.37)
      $0.textAlignment = .center
   }
   
   //apple SignIn Button
   let appleSignInButton = UIButton()
   let appleLogo = UIImageView(image:Image.apple_SignInButton)
   let appleSignInTitle = UILabel().then{
      $0.setPretendardFont(text: "Sign in with Apple", size: 17.0, weight: .regular, letterSpacing: 1.23)
      $0.textAlignment = .center
      $0.textColor = UIColor.White()
   }
   //Google SignIn Button
   let googleSignInButton = UIButton()
   let googleLogo = UIImageView(image:Image.google_SignInButton)
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
      
      
      //GoogleSignInButton
      googleSignInButton.addSubviews(googleLogoBackGround, googleSignInTitle)
      googleLogoBackGround.addSubview(googleLogo)
      
      
   }
   
   
   
   override func setLayout() {
      //Logo Design
      footMarkLogo.snp.makeConstraints{
         $0.centerX.equalTo(self.safeAreaLayoutGuide.snp.centerX)
         $0.centerY.equalTo(self.safeAreaLayoutGuide.snp.centerY).offset(-82)
         $0.width.equalTo(192)
         $0.height.equalTo(177)
      }
      
      footMarkLabel.snp.makeConstraints {
         $0.centerX.equalTo(self.safeAreaLayoutGuide.snp.centerX)
         $0.bottom.equalTo(footMarkLogo.snp.top).offset(-20)  // logo 위에 위치
         $0.leading.equalTo(self.safeAreaLayoutGuide.snp.leading).offset(20)
         $0.trailing.equalTo(self.safeAreaLayoutGuide.snp.trailing).offset(-20)
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
      appleSignInButton.snp.makeConstraints {
         $0.centerX.equalTo(self.safeAreaLayoutGuide.snp.centerX)
         $0.top.equalTo(footMarkLogo.snp.bottom).offset(42)
         $0.leading.equalTo(self.safeAreaLayoutGuide.snp.leading).offset(20)
         $0.trailing.equalTo(self.safeAreaLayoutGuide.snp.trailing).offset(-20)
         $0.height.equalTo(48)
      }
      
      appleSignInButton.backgroundColor = UIColor.black
      appleSignInButton.layer.cornerRadius = 12
      googleLogo.snp.makeConstraints {
         $0.width.height.equalTo(17)
         $0.centerX.centerY.equalToSuperview()
      }
      googleLogoBackGround.snp.makeConstraints{
         $0.centerY.equalToSuperview()
         $0.leading.equalToSuperview().offset(24)
         $0.width.height.equalTo(20)
      }
      googleLogoBackGround.backgroundColor = .white
      googleLogoBackGround.layer.cornerRadius = 10
      googleLogoBackGround.clipsToBounds = true
      
      googleSignInTitle.snp.makeConstraints {
         $0.centerY.equalToSuperview()
         $0.centerX.equalToSuperview()
      }
      googleSignInButton.snp.makeConstraints {
         $0.centerX.equalTo(self.safeAreaLayoutGuide.snp.centerX)
         $0.top.equalTo(appleSignInButton.snp.bottom).offset(20)
         $0.leading.equalTo(self.safeAreaLayoutGuide.snp.leading).offset(20)
         $0.trailing.equalTo(self.safeAreaLayoutGuide.snp.trailing).offset(-20)
         $0.height.equalTo(48)
      }
      googleSignInButton.backgroundColor = UIColor(red: 0.25, green: 0.52, blue: 0.95, alpha: 1.0)
      googleSignInButton.layer.cornerRadius = 12
      
   }
}
