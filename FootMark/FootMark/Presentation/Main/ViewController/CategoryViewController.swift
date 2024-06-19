//
//  CategoryViewController.swift
//  FootMark
//
//  Created by 박신영 on 6/18/24.
//


import UIKit
import Then
import SnapKit
import KeychainSwift

class CategoryViewController: BaseViewController {
   
   var categoryClosure: (() -> Void)?
   var mainVC: MainViewController?
   
   let container = UIView()
   let cancelBtn = UIButton()
   
   var categoryName = ""
   var categoryCount = UserDefaults.standard.integer(forKey: "categoryCount")
   
   
   let emojiLabel = UILabel().then {
      $0.text = "🥺"
      $0.font = UIFont.pretendard(size: 40, weight: .semibold)
      $0.textAlignment = .center
   }
   
   let noCategoryLabel = UILabel().then {
      $0.setPretendardFont(text: "등록된 카테고리가 없어요!\n카테고리를 등록해봐요!", size: 18, weight: .bold, letterSpacing: 1.25)
      $0.numberOfLines = 3
      $0.textAlignment = .center
      $0.textColor = .white1
   }
   
   let titleLabel = UILabel().then {
      $0.setPretendardFont(text: "Category", size: 18, weight: .bold, letterSpacing: 1.25)
      $0.textColor = .white
   }
   
   let plusView1 = UIView()
   let plusImage1 = UIImageView(image: UIImage(systemName: "plus.circle"))
   let categoryLabel1 = UILabel().then {
      $0.setPretendardFont(text: "미정", size: 22, weight: .bold, letterSpacing: 1.25)
      $0.textColor = .white
      $0.isHidden = true
   }
   
   let plusView2 = UIView()
   let plusImage2 = UIImageView(image: UIImage(systemName: "plus.circle"))
   let categoryLabel2 = UILabel().then {
      $0.setPretendardFont(text: "미정", size: 22, weight: .bold, letterSpacing: 1.25)
      $0.textColor = .white
      $0.isHidden = true
   }
   
   let textFieldContainer = UIView().then {
      $0.layer.backgroundColor = UIColor.blue1.cgColor
      $0.layer.cornerRadius = 10
   }
   
   lazy var doneButton = UIButton().then {
      $0.setTitle("확인", for: .normal)
      $0.titleLabel?.setPretendardFont(text: "확인", size: 17, weight: .bold, letterSpacing: 1.25)
      $0.titleLabel?.textColor = UIColor.White()
      $0.layer.backgroundColor = UIColor(.gray).cgColor
      $0.layer.cornerRadius = 10
   }
   
   let githubURLtextFieldLabel = UITextField().then {
      $0.placeholder = "Github Profile URL을 입력해주세요"
      $0.clearButtonMode = .always
      $0.keyboardType = .URL
      $0.autocapitalizationType = .none
      $0.spellCheckingType = .no
   }
   
   override func viewDidLoad() {
      super.viewDidLoad()
      view.backgroundColor = .black1
   }
   
   override func setAddTarget() {
      let tapGesture = UITapGestureRecognizer(target: self, action: #selector(plusView1Tapped))
      plusView1.addGestureRecognizer(tapGesture)
      
      let tapGesture2 = UITapGestureRecognizer(target: self, action: #selector(plusView2Tapped))
      plusView2.addGestureRecognizer(tapGesture2)
   }
   
   override func setUI() {
      if let sheetPresentationController = sheetPresentationController {
         sheetPresentationController.preferredCornerRadius = 15
         sheetPresentationController.prefersGrabberVisible = true
         self.isModalInPresentation = true
         sheetPresentationController.detents = [.custom {context in
            return 360
         }]
      }
      cancelBtn.do {
         $0.setImage(UIImage(resource: .backBtn), for: .normal)
         $0.addTarget(self, action: #selector(didTapCancelBtn), for: .touchUpInside)
      }
      
      plusView1.do {
         $0.layer.borderWidth = 1
         $0.layer.cornerRadius = 10
         $0.layer.borderColor = UIColor.white1.cgColor
         $0.backgroundColor = .black1
      }
      
      plusImage1.do {
         $0.tintColor = .white1
      }
      
      plusView2.do {
         $0.layer.borderWidth = 1
         $0.layer.cornerRadius = 10
         $0.layer.borderColor = UIColor.white1.cgColor
         $0.backgroundColor = .black1
      }
      
      plusImage2.do {
         $0.tintColor = .white1
      }
      
   }
   
   override func setLayout() {
      view.addSubview(container)
      
      if categoryCount < 10 {
         container.addSubviews(titleLabel, emojiLabel, noCategoryLabel, plusView1, plusView2, cancelBtn)
         plusView1.addSubviews(plusImage1, categoryLabel1)
         plusView2.addSubviews(plusImage2, categoryLabel2)
         
         container.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.top.equalToSuperview().offset(24)
            $0.bottom.equalToSuperview().offset(-12)
         }
         
         titleLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(10)
            $0.height.equalTo(21)
         }
         
         cancelBtn.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(10)
            $0.centerY.equalTo(titleLabel).offset(3)
            $0.size.equalTo(20)
         }
         
         plusView1.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(10)
            $0.top.equalTo(titleLabel.snp.bottom).offset(40)
            $0.height.equalTo(80)
         }
         
         plusImage1.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(50)
         }
         
         categoryLabel1.snp.makeConstraints {
            $0.center.equalToSuperview()
         }
         
         plusView2.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(10)
            $0.top.equalTo(plusView1.snp.bottom).offset(30)
            $0.height.equalTo(80)
         }
         
         plusImage2.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(50)
         }
         
         categoryLabel2.snp.makeConstraints {
            $0.center.equalToSuperview()
         }
         
      } else {
         container.addSubviews(titleLabel, textFieldContainer, doneButton)
         textFieldContainer.addSubview(githubURLtextFieldLabel)
         
         container.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.top.equalToSuperview().offset(24)
            $0.bottom.equalToSuperview().offset(-12)
         }
         
         titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().offset(0)
            $0.height.equalTo(21)
         }
         
         textFieldContainer.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(titleLabel.snp.bottom).offset(12)
            $0.height.equalTo(41)
         }
         
         githubURLtextFieldLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(8)
            $0.trailing.equalToSuperview().offset(-6)
         }
         
         doneButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(textFieldContainer.snp.bottom).offset(15)
            $0.height.equalTo(textFieldContainer.snp.height)
         }
      }
   }
   
   func reloadView1(categoryCount: Int, categoryName: String) {
      print("reloadView 시작")
      print("카테고리 1개째")
      plusImage1.isHidden = true
      categoryLabel1.isHidden = false
      categoryLabel1.text = categoryName
      plusView1.isUserInteractionEnabled = false
   }
   
   func reloadView2(categoryCount: Int, categoryName: String) {
      print("reloadView 시작")
      print("카테고리 2개째")
      plusImage2.isHidden = true
      categoryLabel2.isHidden = false
      categoryLabel2.text = categoryName
      plusView2.isUserInteractionEnabled = false
      
   }
   
   @objc func didTapCancelBtn() {
      if let mainVC = self.mainVC {
         mainVC.categoryCount = categoryCount
         mainVC.categoryName1 = categoryLabel1.text ?? ""
         mainVC.categoryName2 = categoryLabel2.text ?? ""
         
         if categoryLabel1.text != "미정" {
            mainVC.allCategoryCount += 1
         } else if categoryLabel2.text != "미정" {
            mainVC.allCategoryCount += 1
         }
      }
      self.categoryClosure?()
      self.dismiss(animated: true)
   }
   
   @objc func plusView1Tapped() {
      print("plusView1 was tapped!")
      let alertVC = AddCategoryViewController()
      alertVC.modalPresentationStyle = .formSheet
      alertVC.categoryVC = self // self를 전달합니다.
      alertVC.addCategoryClosure = {
         self.reloadView1(categoryCount: self.categoryCount, categoryName: self.categoryName)
      }
      self.present(alertVC, animated: true)
   }
   
   @objc func plusView2Tapped() {
      print("plusView1 was tapped!")
      let alertVC = AddCategoryViewController()
      alertVC.modalPresentationStyle = .formSheet
      alertVC.categoryVC = self // self를 전달합니다.
      alertVC.addCategoryClosure = {
         self.reloadView2(categoryCount: self.categoryCount, categoryName: self.categoryName)
      }
      self.present(alertVC, animated: true)
      
   }
   
}



