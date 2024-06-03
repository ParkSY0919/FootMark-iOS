//
//  MonthlyReviewViewController.swift
//  FootMark
//
//  Created by 박신영 on 6/3/24.
//

import UIKit
import SnapKit
import Then

//#Preview() {
//   MonthlyReviewViewController()
//}

class MonthlyReviewViewController: BaseViewController {
   
   private let monthlyReview = MonthlyReviewView()
   
   override func setUI() {
      self.navigationController?.isNavigationBarHidden = true
      monthlyReview.do {
         $0.isUserInteractionEnabled = true
      }
   }
   
   override func setHierarchy() {
      view.addSubview(monthlyReview)
   }
   
   override func setLayout() {
      monthlyReview.snp.makeConstraints {
         $0.edges.equalToSuperview()
      }
   }
   
   override func viewDidLoad() {
      super.viewDidLoad()
      print("현재 MonthlyReviewViewController 입니다.")
      
      //BackBtn의 Action이 실행되지 않고 있음.
      monthlyReview.didTapBackBtn = {
         print("현재 monthlyReview.didTapBackBtn 눌림")
         self.navigationController?.popViewController(animated: true)
      }
   }
}
