//
//  AddCategoryViewController.swift
//  FootMark
//
//  Created by 박신영 on 6/18/24.
//

import UIKit
import SnapKit
import Then

class AddCategoryViewController: UIViewController {
   
   // MARK: - UI Components
   
   private let container = UIView()
   
   private let goalImageView = UIImageView()
   
   private let titleLabel = UILabel()
   
   private let cancelBtn = UIButton()
   
   let categoryPlusBtn = UIButton()
   
   var addCategoryClosure: (() -> Void)?
   var isEmpty = true
   var goalText = ""
   var categoryVC: CategoryViewController?
   
   let textFieldContainer = UIView().then {
      $0.layer.borderColor = UIColor.white1.cgColor
      $0.layer.cornerRadius = 10
      $0.layer.borderWidth = 1
   }
   
   let githubURLtextFieldLabel = UITextField().then {
      $0.clearButtonMode = .always
      $0.keyboardType = .URL
      $0.autocapitalizationType = .none
      $0.spellCheckingType = .no
      $0.autocorrectionType = .no
      $0.attributedPlaceholder = NSAttributedString(
         string: "목표를 입력해주세요!",
         attributes: [NSAttributedString.Key.foregroundColor: UIColor.white1]
      )
      $0.clearButtonMode = .whileEditing
      $0.textColor = .white
   }
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      setHierachy()
      setStyle()
      setLayout()
      view.backgroundColor = .black1
   }
   
   deinit {
      NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
      NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
   }
   
   // MARK: setHierachy
   
   private func setHierachy() {
      container.addSubviews(
         cancelBtn,
         goalImageView,
         titleLabel,
         categoryPlusBtn,
         textFieldContainer
      )
      textFieldContainer.addSubview(githubURLtextFieldLabel)
      
      if let sheetPresentationController = sheetPresentationController {
         sheetPresentationController.preferredCornerRadius = 15
         sheetPresentationController.prefersGrabberVisible = false
         sheetPresentationController.detents = [.custom {context in
            return UIScreen.main.bounds.height * 0.68}]
      }
      
      view.addSubview(container)
      githubURLtextFieldLabel.delegate = self
      githubURLtextFieldLabel.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
   }
   
   // MARK: setStyle
   
   private func setStyle() {
      container.do {
         $0.layer.cornerRadius = 12
         $0.layer.borderColor = UIColor.white1.cgColor
         $0.layer.borderWidth = 1
         $0.backgroundColor = .black1
      }
      
      goalImageView.do {
         $0.image = UIImage(resource: .goal)
         $0.layer.borderWidth = 0
         $0.layer.cornerRadius = 10
         $0.clipsToBounds = true
      }
      
      titleLabel.do {
         $0.text = "목표 카테고리 등록"
         $0.font = .pretendard(size: 20, weight: .bold)
         $0.textAlignment = .center
         $0.textColor = .white
      }
      
      cancelBtn.do {
         $0.setImage(UIImage(resource: .backBtn), for: .normal)
         $0.addTarget(self, action: #selector(didTapCancelBtn), for: .touchUpInside)
      }
      
      categoryPlusBtn.do {
         $0.setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
         $0.tintColor = .white
         $0.imageView?.snp.makeConstraints {
            $0.edges.equalToSuperview()
         }
         $0.addTarget(self, action: #selector(didTapPlusBtn), for: .touchUpInside)
      }
   }
   
   // MARK: setLayout
   
   private func setLayout() {
      container.snp.makeConstraints {
         $0.top.equalToSuperview()
         $0.leading.trailing.equalToSuperview().inset(16)
         $0.height.equalTo(337)
      }
      
      cancelBtn.snp.makeConstraints {
         $0.width.height.equalTo(20)
         $0.leading.equalToSuperview().inset(20)
         $0.centerY.equalTo(titleLabel).offset(3)
      }
      
      categoryPlusBtn.snp.makeConstraints {
         $0.width.height.equalTo(30)
         $0.trailing.equalToSuperview().inset(20)
         $0.centerY.equalTo(titleLabel).offset(5)
      }
      
      titleLabel.snp.makeConstraints {
         $0.top.equalToSuperview().inset(10)
         $0.horizontalEdges.equalToSuperview().inset(10)
      }
      
      goalImageView.snp.makeConstraints {
         $0.top.equalTo(titleLabel.snp.bottom).offset(20)
         $0.horizontalEdges.equalToSuperview().inset(20)
         $0.height.equalTo(200)
      }
      
      textFieldContainer.snp.makeConstraints {
         $0.top.equalTo(goalImageView.snp.bottom).offset(20)
         $0.horizontalEdges.equalToSuperview().inset(20)
         $0.height.equalTo(41)
      }
      
      githubURLtextFieldLabel.snp.makeConstraints {
         $0.centerY.equalToSuperview()
         $0.leading.equalToSuperview().inset(10)
         $0.trailing.equalToSuperview().inset(5)
         $0.height.equalTo(40)
      }
   }
   
   func postCategory() {
      NetworkService.shared.mainService.postCategory(request: PostCategoryRequestModel(categoryName: goalText, color: "black")) { result in
         switch result {
         case .success(let data):
            let categoryCount = UserDefaults.standard.integer(forKey: "categoryCount")
            if categoryCount == 0 {
               print("category 1개째 등록 시작")
               UserDefaults.standard.set(self.goalText, forKey: "category1Name")
               UserDefaults.standard.set(data.data.categoryID, forKey: "category1ID")
               UserDefaults.standard.set(1, forKey: "categoryCount")
               
               DispatchQueue.main.async {
                  self.showAlert(title: "등록 성공", message: "1번 목표에 성공적으로 등록하였습니다!", confirmButtonName: "확인", confirmButtonCompletion: {
                     let categoryName = UserDefaults.standard.string(forKey: "category1Name")
                     if let categoryVC = self.categoryVC {
                        categoryVC.categoryCount = UserDefaults.standard.integer(forKey: "categoryCount")
                        categoryVC.categoryName = categoryName ?? ""
                     }
                     self.addCategoryClosure?()
                     self.dismiss(animated: true)
                  })
               }
            } else if categoryCount == 1 {
               print("category 2개째 등록 시작")
               UserDefaults.standard.set(self.goalText, forKey: "category2Name")
               UserDefaults.standard.set(data.data.categoryID, forKey: "category2ID")
               UserDefaults.standard.set(2, forKey: "categoryCount")
               
               DispatchQueue.main.async {
                  self.showAlert(title: "등록 성공", message: "2번 목표에 성공적으로 등록하였습니다!", confirmButtonName: "확인", confirmButtonCompletion: {
                     let categoryName = UserDefaults.standard.string(forKey: "category2Name")
                     if let categoryVC = self.categoryVC {
                        categoryVC.categoryCount = UserDefaults.standard.integer(forKey: "categoryCount")
                        categoryVC.categoryName = categoryName ?? ""
                     }
                     self.addCategoryClosure?()
                     self.dismiss(animated: true)
                  })
               }
            }
            
            
         case .tokenExpired(_):
            print("refresh 토큰 만료입니다")
         case .requestErr:
            print("요청 오류입니다")
         case .decodedErr:
            print("디코딩 오류입니다")
         case .pathErr:
            print("경로 오류입니다")
         case .serverErr:
            print("서버 오류입니다")
         case .networkFail:
            print("네트워크 오류입니다")
         }
      }
   }
   
   func showAlert(title: String? = nil,
                  message: String? = nil,
                  preferredStyle: UIAlertController.Style = .alert,
                  cancelButtonName: String? = nil,
                  confirmButtonName: String? = nil,
                  isExistsTextField: Bool = false,
                  cancelButtonCompletion: (() -> Void)? = nil,
                  confirmButtonCompletion: (() -> Void)? = nil) {
      let alertViewController = UIAlertController(title: title,
                                                  message: message,
                                                  preferredStyle: preferredStyle)
      
      if let cancelButtonName = cancelButtonName {
         let cancelAction = UIAlertAction(title: cancelButtonName,
                                          style: .cancel) { _ in
            cancelButtonCompletion?()
         }
         alertViewController.addAction(cancelAction)
      }
      
      if let confirmButtonName = confirmButtonName {
         let confirmAction = UIAlertAction(title: confirmButtonName,
                                           style: .default) { _ in
            confirmButtonCompletion?()
         }
         alertViewController.addAction(confirmAction)
      }
      
      if isExistsTextField {
         alertViewController.addTextField { textField in
            textField.enablesReturnKeyAutomatically = true
            textField.autocapitalizationType = .words
            textField.clearButtonMode = .whileEditing
            textField.placeholder = "Channel name"
            textField.returnKeyType = .done
            textField.tintColor = .SWprimary
         }
      }
      present(alertViewController, animated: true)
   }
   
   // MARK: @objc func
   
   @objc func didTapCancelBtn() {
      self.dismiss(animated: true)
   }
   
   @objc func didTapPlusBtn() {
      print("didTapPlusBtn")
      if isEmpty == true {
         showAlert(title: "등록 실패", message: "목표 카테고리를 입력해주세요!", confirmButtonName: "확인")
      } else {
         postCategory()
      }
      
   }
   
}


extension AddCategoryViewController: UITextFieldDelegate {
   
   // 확인 or return 버튼으로 키보드 내리기
   internal func textFieldShouldReturn(_ textField: UITextField) -> Bool {
      textField.resignFirstResponder()
      return true
   }
   
   //MARK: - @objc func
   
   @objc func textFieldDidChange(_ textField: UITextField) {
      DispatchQueue.main.async { [weak self] in
         guard let self = self else { return }
         if textField.text?.count == 0 {
            self.categoryPlusBtn.tintColor = .white1
            isEmpty = true
         } else {
            self.categoryPlusBtn.tintColor = .blue
            isEmpty = false
            goalText = textField.text ?? ""
         }
      }
   }
   
   @objc override func dismissKeyboard() {
      view.endEditing(true)
   }
   
   @objc func keyboardWillShow(notification: NSNotification) {
       guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
           return
       }
       
       UIView.animate(withDuration: 0.3) {
           self.view.layoutIfNeeded()
       }
   }
   
   @objc func keyboardWillHide(notification: NSNotification) {
      UIView.animate(withDuration: 0.3) {
         self.view.layoutIfNeeded()
      }
   }
   
   func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
      let currentText = textField.text ?? ""
      let updatedText = (currentText as NSString).replacingCharacters(in: range, with: string)
      
      return true
   }
}
