//
//  ViewController.swift
//  FootMark
//
//  Created by 박신영 on 3/21/24.
//

import UIKit
import SnapKit
import Then

class BaseViewController: UIViewController {
   // MARK: - Property
   
   weak var alertController: UIAlertController?
   
   override func loadView() {
      view = BaseView()
   }
   
   
   // MARK: - View Life Cycle
   override func viewDidLoad() {
      self.view.backgroundColor = .black1
      self.view.setNeedsUpdateConstraints()
      self.setUI()
      self.setHierarchy()
      self.setLayout()
      self.setAddTarget()
      self.setUpKeyboard()
      navigationController?.navigationBar.isHidden = false
   }
   
   
   // MARK: - UI Components
   func setUI() {}
   // MARK: - set View Hierarchy
   func setHierarchy() {}
   // MARK: - Layout Helper
   func setLayout() {}
   // MARK: - Add Target
   func setAddTarget() {}
   
   func setUpKeyboard() {}
   
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
            textField.addTarget(self, action: #selector(self.didInputTextField(field:)), for: .editingChanged)
            textField.enablesReturnKeyAutomatically = true
            textField.autocapitalizationType = .words
            textField.clearButtonMode = .whileEditing
            textField.placeholder = "Channel name"
            textField.returnKeyType = .done
            textField.tintColor = .SWprimary
         }
      }
      
      alertController = alertViewController
      present(alertViewController, animated: true)
   }
   
   @objc private func didInputTextField(field: UITextField) {
      if let alertController = alertController {
         alertController.preferredAction?.isEnabled = field.hasText
      }
   }
}

