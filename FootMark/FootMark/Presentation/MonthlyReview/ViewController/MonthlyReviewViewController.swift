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
   private let tabView = TabView()
   private var selectedIndex = 0
   private let items = [
      "전체",
      "감사의 말",
      "오늘 가장 좋았던 일",
      "운동",
      "약속",
      "공부"
   ]
   
   override func setUI() {
      self.navigationController?.isNavigationBarHidden = true
      
      monthlyReview.do {
         $0.isUserInteractionEnabled = true
      }
      
      tabView.didTap = { [weak self] index in
         guard let self else { return }
         self.selectedIndex = index // 선택된 인덱스 할당
         self.tabView.scroll(to: index)
         self.tabView.syncUnderlineView(index: index, underlineView: self.tabView.highlightView)
         self.toggleScrollView(index: index) // 선택된 인덱스에 따라 ScrollView 토글
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
      tabView.dataSource = items
      handleScroll()
      //BackBtn의 Action이 실행되지 않고 있음.
      monthlyReview.didTapBackBtn = {
         print("현재 monthlyReview.didTapBackBtn 눌림")
         self.navigationController?.popViewController(animated: true)
      }
   }
   
   private func handleScroll() {
      tabView.syncUnderlineView(index: 0, underlineView: tabView.highlightView)
      
      tabView.didTap = { [weak self] index in
         guard let self else { return }
         tabView.scroll(to: index)
         tabView.syncUnderlineView(index: index, underlineView: tabView.highlightView)
      }
   }
   
   private func toggleScrollView(index: Int) {
      if index == 1 {
         print("index 값 1이 클릭 됐을 때")
      } else {
         print("index 1 아닐 때")
      }
   }
   
}
