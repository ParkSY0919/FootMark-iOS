//
//  MonthlyReviewView.swift
//  FootMark
//
//  Created by 박신영 on 6/3/24.
//

import UIKit
import SnapKit
import Then

class MonthlyReviewView: BaseView {
   
   let navigationContainer = UIView()
   let navigationBackBtn = UIButton()
   var didTapBackBtn: (() -> Void)?
   
   override func setUI() {
      navigationContainer.do {
         $0.backgroundColor = .red
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
   }
   
   override func setHierarchy() {
      addSubview(navigationContainer)
      navigationContainer.addSubview(navigationBackBtn)
   }
   
   override func setLayout() {
      navigationContainer.snp.makeConstraints {
         $0.top.equalTo(self.safeAreaLayoutGuide.snp.top)
         //         $0.top.horizontalEdges.equalToSuperview()
         $0.height.equalTo(80)
      }
      
      navigationBackBtn.snp.makeConstraints {
         $0.leading.equalToSuperview().inset(24)
         $0.centerY.equalToSuperview()
         $0.width.equalTo(30)
         $0.height.equalTo(26)
      }
   }
   
}
