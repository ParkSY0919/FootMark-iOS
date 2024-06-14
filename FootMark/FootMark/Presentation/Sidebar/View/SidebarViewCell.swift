//
//  SidebarViewCell.swift
//  FootMark
//
//  Created by 윤성은 on 6/4/24.
//

import UIKit
import SnapKit

class SidebarViewCell: UITableViewCell {
    
    static let identifier = "SidebarViewCell"
    
    var tableImageViewLeadingConstraint: Constraint?
    
    let tableImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.tintColor = UIColor(resource: .white2)
    }
    
    let tableLabel = UILabel().then {
        $0.textColor = UIColor(resource: .white2)
        $0.textAlignment = .center
        $0.font = UIFont.pretendard(size: 15, weight: .semibold)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setLayout()
        
        self.backgroundColor = UIColor(resource: .black1)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setLayout() {
        [tableImageView, tableLabel].forEach {
            contentView.addSubview($0)
        }
        
        tableImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8)
            self.tableImageViewLeadingConstraint = $0.leading.equalToSuperview().offset(16).constraint
            $0.size.equalTo(45)
        }
        
        tableLabel.snp.makeConstraints {
            $0.centerY.equalTo(tableImageView.snp.centerY)
            $0.leading.equalTo(tableImageView.snp.trailing).offset(16)
        }
    }
    
    func dataBind(_ sidebarData: SidebarModel) {
        if sidebarData.title == "MindTrack" {
            // "MindTrack" 항목은 원래 색상
            let originalImage = sidebarData.image?.withRenderingMode(.alwaysOriginal)
            tableImageView.image = originalImage
        } else {
            // 나머지 항목들은 템플릿 모드로 설정
            let templateImage = sidebarData.image?.withRenderingMode(.alwaysTemplate)
            tableImageView.image = templateImage
            tableImageView.tintColor = UIColor(resource: .white2)
        }
        
        tableLabel.text = sidebarData.title
        
        if sidebarData.title == "Logout" {
            tableImageViewLeadingConstraint?.update(offset: 20)
        } else {
            tableImageViewLeadingConstraint?.update(offset: 16)
        }
    }
}
