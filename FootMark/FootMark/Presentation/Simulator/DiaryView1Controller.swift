//
//  DiaryView1Controller.swift
//  FootMark
//
//  Created by 박신영 on 3/26/24.
//

import UIKit
import SnapKit
import Then


class DiaryView1Controller: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    let sdieBar: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .white
        imageView.image = UIImage(named: "Diary2")
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
    
   
}


