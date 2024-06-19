//
//  MonthlyReviewViewController.swift
//  FootMark
//
//  Created by 박신영 on 6/3/24.
//

import UIKit
import SnapKit
import Then


class MonthlyReviewViewController: BaseViewController {
   
   //   private let monthlyReview = MonthlyReviewView()
   let customNavigationController = CustomNavigationController()
   private let tabView = TabView()
   private var selectedIndex = 0
   private let scrollView = UIScrollView()
   private let contentView = UIView()
   private let totalTableView = UIImageView(image: UIImage(resource: .swAllMonthly))
   //   private let
   let str1 = UserDefaults.standard.string(forKey: "category1Name")
   let str2 = UserDefaults.standard.string(forKey: "category2Name")
   private lazy var items = [
      "전체",
      "감사한 일",
      "가장 좋았던 일",
      str1 ?? "",
      str2 ?? ""
   ]
   
   private lazy var num = customNavigationController.cnt
   
   override func setUI() {
      self.navigationController?.isNavigationBarHidden = true
      
      customNavigationController.view.do {
         $0.isUserInteractionEnabled = true
      }
   }
   
   override func setHierarchy() {
      view.addSubviews(customNavigationController.navigationContainer, tabView, scrollView)
      scrollView.addSubview(contentView)
      contentView.addSubview(totalTableView)
   }
   
   override func setLayout() {
      
      customNavigationController.navigationContainer.snp.makeConstraints {
         $0.top.equalTo(view.safeAreaLayoutGuide)
         $0.horizontalEdges.equalToSuperview()
         $0.height.equalTo(50)
      }
      
      tabView.snp.makeConstraints {
         $0.top.equalTo(customNavigationController.navigationContainer.snp.bottom)
         $0.leading.trailing.equalToSuperview()
         $0.height.equalTo(48)
      }
      
      scrollView.snp.makeConstraints {
         $0.top.equalTo(tabView.snp.bottom).offset(10)
         $0.horizontalEdges.bottom.equalToSuperview()
      }
      
      contentView.snp.makeConstraints {
         $0.edges.equalTo(scrollView)
         $0.width.equalTo(scrollView)
         $0.height.greaterThanOrEqualToSuperview().priority(.low)
      }
      
      totalTableView.snp.makeConstraints {
         $0.edges.equalToSuperview()
      }
   }
   
   override func viewDidLoad() {
      super.viewDidLoad()
      tabView.dataSource = items
      handleScroll()
      customNavigationController.didTapBackBtn = {
         print("현재 monthlyReview.didTapBackBtn 눌림")
         self.navigationController?.popViewController(animated: true)
      }
      
      customNavigationController.onCntChanged = {
         DispatchQueue.main.async {
            self.totalTableView.image = UIImage(resource: .monthlyMayTotal)
         }
      }
   }
   private func handleScroll() {
      tabView.syncUnderlineView(index: 0, underlineView: tabView.highlightView)
      
      tabView.didTap = { [weak self] index in
         guard let self else { return }
         tabView.scroll(to: index)
         tabView.syncUnderlineView(index: index, underlineView: tabView.highlightView)
         self.toggleScrollView(index: index)
      }
   }
   
   private func toggleScrollView(index: Int) {
      switch index {
      case 0:
         totalTableView.image = UIImage(resource: .swAllMonthly)
      case 1:
         totalTableView.image = UIImage(resource: .swThanksMonthly)
      case 2:
         totalTableView.image = UIImage(resource: .swBestMonthly)
      case 3:
         totalTableView.image = UIImage(resource: .swHealthMonthly)
      case 4:
         totalTableView.image = UIImage(resource: .swStudyMonthly)
      default:
         break
      }
   }
   
}
