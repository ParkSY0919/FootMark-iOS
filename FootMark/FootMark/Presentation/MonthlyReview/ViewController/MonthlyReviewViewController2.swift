//
//  MonthlyReviewViewController2.swift
//  FootMark
//
//  Created by 박신영 on 6/11/24.
//

import UIKit
import SnapKit
import Then

//#Preview() {
//   MonthlyReviewViewController()
//}

class MonthlyReviewViewController2: BaseViewController {
   
   private let monthlyReview = MonthlyReviewView2()
   private let tabView = TabView()
   private var selectedIndex = 0
   private let items = [
      "전체",
      "감사의 말",
      "오늘 가장 좋았던 일",
      "운동",
      "약속"
   ]
   private let tableView = UITableView()
       private var data = [String]() // 테이블뷰에 표시할 데이터 배열
   
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
      
      tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
          tableView.dataSource = self
          tableView.delegate = self
   }
   
   override func setHierarchy() {
      view.addSubviews(monthlyReview, tabView, tableView)
   }
   
   override func setLayout() {
      monthlyReview.snp.makeConstraints {
//         $0.top.equalTo(self.safeAreaLayoutGuide.snp.top)
         $0.top.horizontalEdges.equalToSuperview()
         $0.height.equalTo(100)
      }
      
      tabView.snp.makeConstraints {
         $0.top.equalTo(monthlyReview.snp.bottom).offset(30)
         $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
         $0.height.equalTo(48)
      }
      tableView.snp.makeConstraints {
             $0.top.equalTo(tabView.snp.bottom).offset(16)
             $0.leading.trailing.equalToSuperview().inset(16)
             $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
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
      
      data = ["첫 번째 데이터", "두 번째 데이터", "세 번째 데이터"]
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

extension MonthlyReviewViewController2: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = data[indexPath.row]
        return cell
    }
}

