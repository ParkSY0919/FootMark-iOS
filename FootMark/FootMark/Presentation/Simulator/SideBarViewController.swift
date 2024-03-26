//
//  SideBarViewController.swift
//  FootMark
//
//  Created by 박신영 on 3/26/24.
//

import UIKit
import SnapKit
import Then


class SideBarViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupGesture()
    }
    
   var count = 1
    let sdieBar: UIImageView = {
        let imageView = UIImageView()
       imageView.backgroundColor = .white
        imageView.image = UIImage(named: "SideBar2")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    
    override func setUI() {
        self.view.addSubview(sdieBar)
    }
    
    override func setLayout() {
        sdieBar.snp.makeConstraints {
            $0.top.bottom.leading.trailing.equalToSuperview()
        }
    }
    
    private func setupGesture() {
       
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        sdieBar.addGestureRecognizer(tapGesture)
        sdieBar.isUserInteractionEnabled = true
    }
    
    @objc private func handleTap(_ sender: UITapGestureRecognizer) {
       print("현재 count = \(count)")
       if count == 1 {
          let myProfile = MyProfileViewController()
          myProfile.navigationItem.hidesBackButton = false
          navigationController?.pushViewController(myProfile, animated: true)
       } else if count == 2 {
          let monthlyReview = MonthlyReviewViewController()
          monthlyReview.navigationItem.hidesBackButton = false
          navigationController?.pushViewController(monthlyReview, animated: true)
       } else if count == 3 {
          let category = CategoryViewController()
          category.navigationItem.hidesBackButton = false
          navigationController?.pushViewController(category, animated: true)
       } else {
          print("아 다 둘러봤다!")
       }
       
       count += 1
       print("count 숫자 증가~")
       
    }
   
}


