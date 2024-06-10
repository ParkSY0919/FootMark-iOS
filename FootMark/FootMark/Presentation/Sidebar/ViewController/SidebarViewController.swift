//
//  SidebarViewController.swift
//  FootMark
//
//  Created by 윤성은 on 6/4/24.
//

import UIKit

class SidebarViewController: BaseViewController {
    
    var sidebarView = SidebarView()
    let sidebarList = SidebarModel.dummy()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sidebarView.tableView.backgroundColor = UIColor(resource: .black1)
        
        sidebarView.tableView.dataSource = self
        sidebarView.tableView.delegate = self
        sidebarView.tableView.register(SidebarViewCell.self, forCellReuseIdentifier: "SidebarViewCell")
    }
    
    override func setLayout() {
        view.addSubview(sidebarView)
        
        sidebarView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
    }
}

extension SidebarViewController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sidebarList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sidebarList[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: SidebarViewCell.identifier,
            for: indexPath) as? SidebarViewCell else { return UITableViewCell() }
        cell.dataBind(sidebarList[indexPath.section][indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 20.0 // 첫 번째 섹션의 헤더 높이 (공백)
        } else {
            return 0.0 // 나머지 섹션의 헤더 높이
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        let averageCellHeight: CGFloat = 44.0
        let numberOfCellsInSection = tableView.numberOfRows(inSection: section)
        let totalCellHeight = averageCellHeight * CGFloat(numberOfCellsInSection)
        
        let tableViewHeight = tableView.frame.size.height
        let remainingHeight = tableViewHeight - totalCellHeight
        
        switch section {
        case 0:
            return remainingHeight * 0.08
        case 1:
            return remainingHeight * 0.1
        case 2:
            return remainingHeight * 0.3
        default:
            return 0.0
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section < sidebarList.count - 1 {
            let footerView = UIView()
            footerView.backgroundColor = .clear
            return footerView
        } else {
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedItem = sidebarList[indexPath.section][indexPath.row]
        print("\(selectedItem.title) 선택됨")
        
        switch selectedItem.title {
        case "Profile":
            let profileVC = ProfileViewController()
            navigationController?.pushViewController(profileVC, animated: true)
            
        case "Home":
            let profileVC = ProfileViewController()
            navigationController?.pushViewController(profileVC, animated: true)
            
        case "Monthly Review":
            let profileVC = ProfileViewController()
            navigationController?.pushViewController(profileVC, animated: true)
            
        case "Category":
            let profileVC = ProfileViewController()
            navigationController?.pushViewController(profileVC, animated: true)
            
        case "Logout":
            print("로그아웃 처리")
            
        default:
            break
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
