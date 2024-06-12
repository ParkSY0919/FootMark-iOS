//
//  MonthlyReviewView2.swift
//  FootMark
//
//  Created by 박신영 on 6/11/24.
//

import UIKit
import SnapKit
import Then

class MonthlyReviewView2: BaseView {
   
    
    let navigationContainer = UIView()
    let navigationBackBtn = UIButton()
    var didTapBackBtn: (() -> Void)?
    
    let dropDownButton = UIButton().then {
        $0.setTitle("June 2024", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.backgroundColor = .lightGray
        $0.layer.cornerRadius = 5
       $0.isUserInteractionEnabled = true
    }
    
    let dropDownTableView = UITableView().then {
        $0.isHidden = true
        $0.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        $0.layer.cornerRadius = 5
        $0.backgroundColor = .lightGray
       $0.isUserInteractionEnabled = true
    }
    
    let months = ["January 2024", "February 2024", "March 2024", "April 2024", "May 2024", "June 2024"]
    var selectedMonth: String?
    
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
    }
    
    override func setHierarchy() {
        addSubview(navigationContainer)
        navigationContainer.addSubviews(navigationBackBtn, dropDownButton, dropDownTableView)
    }
    
    override func setLayout() {
        navigationContainer.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(80)
        }
        
        navigationBackBtn.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(24)
            $0.centerY.equalToSuperview()
            $0.width.equalTo(30)
            $0.height.equalTo(26)
        }
        
        dropDownButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.width.equalTo(150)
            $0.height.equalTo(40)
        }
        
        dropDownTableView.snp.makeConstraints {
            $0.top.equalTo(dropDownButton.snp.bottom).offset(5)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(270)
        }
    }
   
    override func setDelegate() {
        super.setDelegate()
        dropDownButton.addTarget(self, action: #selector(toggleDropDown), for: .touchUpInside)
        dropDownTableView.dataSource = self
        dropDownTableView.delegate = self
    }
    
    @objc private func toggleDropDown() {
        dropDownTableView.isHidden = !dropDownTableView.isHidden
        dropDownTableView.reloadData()
    }
}

extension MonthlyReviewView2: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return months.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = months[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedMonth = months[indexPath.row]
        dropDownButton.setTitle(selectedMonth, for: .normal)
        dropDownTableView.isHidden = true
        
        // 셀의 선택 상태를 업데이트합니다.
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
