//
//  CustomNavigationController.swift
//  FootMark
//
//  Created by 박신영 on 6/14/24.
//


import UIKit
import SnapKit
import Then
import DropDown

class CustomNavigationController: BaseViewController {
   
   let navigationContainer = UIView()
   let navigationBackBtn = UIButton()
   var didTapBackBtn: (() -> Void)?
   let dropDownBtn = UIButton()
   let dropDown = DropDown()
   var didTapDropDownBtn: (() -> Void)?
   var cnt = 3
   
   var onCntChanged: (() -> Void)?
   
   override func setUI() {
      navigationContainer.do {
         $0.isUserInteractionEnabled = true
      }
      
      navigationBackBtn.do {
         $0.setImage(UIImage(resource: .backBtn), for: .normal)
         $0.isEnabled = true
         $0.isUserInteractionEnabled = true
         $0.addAction(UIAction { _ in
            self.didTapBackBtn?()
         }, for: .touchUpInside)
      }
      
      dropDownBtn.do {
         $0.setTitle("June 2024", for: .normal)
         $0.isEnabled = true
         $0.isUserInteractionEnabled = true
         $0.addAction(UIAction { _ in
            self.didTapDropDownBtn?()
         }, for: .touchUpInside)
      }
      
      dropDown.dataSource = ["March 2024", "April 2024", "May 2024", "June 2024"]
      
      dropDown.do {
         $0.anchorView = dropDownBtn
         $0.bottomOffset = CGPoint(x: -10, y:(dropDown.anchorView?.plainView.bounds.height)!+40)
         $0.width = 150
         $0.textColor = UIColor.black
         $0.selectedTextColor = UIColor.red
         $0.cornerRadius = 15
      }
      
      didTapDropDownBtn = {
         print("~~~")
         self.dropDown.show()
      }
   }
   
   override func setHierarchy() {
      view.addSubview(navigationContainer)
      navigationContainer.addSubviews(navigationBackBtn, dropDownBtn)
   }
   
   override func setLayout() {
      self.view.snp.makeConstraints {
         $0.height.equalTo(80)
      }
      navigationContainer.snp.makeConstraints {
         $0.top.bottom.horizontalEdges.equalToSuperview()
      }
      
      navigationBackBtn.snp.makeConstraints {
         $0.leading.equalToSuperview().inset(24)
         $0.centerY.equalToSuperview()
         $0.width.equalTo(30)
         $0.height.equalTo(26)
      }
      
      dropDownBtn.snp.makeConstraints {
         $0.centerX.centerY.equalToSuperview()
         $0.width.equalTo(140)
         $0.height.equalTo(30)
      }
   }
   
   override func setAddTarget() {
      dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
         print("선택한 아이템 : \(item)")
         print("인덱스 : \(index)")
         dropDownBtn.setTitle(item, for: .normal)
         self.dropDown.clearSelection()
         self.onCntChanged?()
      }
   }
}
