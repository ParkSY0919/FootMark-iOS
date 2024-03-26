//
//  Main2ViewController.swift
//  FootMark
//
//  Created by 박신영 on 3/26/24.
//

import UIKit
import SnapKit
import Then


class Main2ViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupGesture()
    }
   var count = 0
    
    let mainView: UIImageView = {
        let imageView = UIImageView()
       imageView.backgroundColor = .white
        imageView.image = UIImage(named: "Main")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    
    override func setUI() {
        self.view.addSubview(mainView)
    }
    
    override func setLayout() {
        mainView.snp.makeConstraints {
            $0.top.bottom.leading.trailing.equalToSuperview()
        }
        
    }
    
    private func setupGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        mainView.addGestureRecognizer(tapGesture)
        mainView.isUserInteractionEnabled = true
    }
    
    @objc private func handleTap(_ sender: UITapGestureRecognizer) {
       if count == 0 {
          let diary = DiaryView1Controller()
          diary.navigationItem.hidesBackButton = false
          navigationController?.pushViewController(diary, animated: true)
       } else {
          let sideBar = SideBarViewController()
          sideBar.navigationItem.hidesBackButton = true
          navigationController?.pushViewController(sideBar, animated: true)
       }
       
       count += 1
    }
   
}
