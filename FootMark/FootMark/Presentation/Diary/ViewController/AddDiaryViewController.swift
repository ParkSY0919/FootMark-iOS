//
//  AddDiaryViewController.swift
//  FootMark
//
//  Created by 윤성은 on 6/9/24.
//

import UIKit
import ElegantEmojiPicker
import DropDown

class AddDiaryViewController: BaseViewController {
    var addDiaryView = AddDiaryView()
    let dropDown = DropDown()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(resource: .black1)
        
        navigationController?.navigationBar.isHidden = true

        setupDropDown()
        
        self.addDiaryView.FtodoLabel.isHidden = false
        self.addDiaryView.FtodoTextView.isHidden = false
        self.addDiaryView.StodoLabel.isHidden = true
        self.addDiaryView.StodoTextView.isHidden = true
    }
    
    override func setLayout() {
        view.addSubviews(addDiaryView)
        
        addDiaryView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    override func setAddTarget() {
        addDiaryView.categoryButton.addTarget(self, action: #selector(categoryButtonTapped), for: .touchUpInside)

    }
    
    @objc func categoryButtonTapped() {
        dropDown.show()
    }
    
    func setupDropDown() {
        dropDown.anchorView = addDiaryView.categoryButton
        dropDown.bottomOffset = CGPoint(x: 0, y: addDiaryView.categoryButton.bounds.height + 80)
        dropDown.dataSource = ["운동", "공부"]
        dropDown.backgroundColor = .white
        
        dropDown.textFont = UIFont.pretendard(size: 18, weight: .regular)
        
        if let firstCategory = dropDown.dataSource.first {
            addDiaryView.categoryButton.setTitle(firstCategory, for: .normal)
            addDiaryView.categoryLabel.text = firstCategory
        }
        
        dropDown.selectionAction = { [weak self] (index: Int, item: String) in
            guard let self = self else { return }

            self.addDiaryView.categoryButton.setTitle(item, for: .normal)
            self.addDiaryView.categoryLabel.text = item

            // 운동 카테고리를 선택했을 때
            if item == "운동" {
                self.addDiaryView.FtodoLabel.isHidden = false
                self.addDiaryView.FtodoTextView.isHidden = false
                self.addDiaryView.StodoLabel.isHidden = true
                self.addDiaryView.StodoTextView.isHidden = true
            }
            // 공부 카테고리를 선택했을 때
            else if item == "공부" {
                self.addDiaryView.FtodoLabel.isHidden = true
                self.addDiaryView.FtodoTextView.isHidden = true
                self.addDiaryView.StodoLabel.isHidden = false
                self.addDiaryView.StodoTextView.isHidden = false
            }
            // 다른 카테고리를 선택했을 때는 모두 숨김 처리
            else {
                self.addDiaryView.FtodoLabel.isHidden = true
                self.addDiaryView.FtodoTextView.isHidden = true
                self.addDiaryView.StodoLabel.isHidden = true
                self.addDiaryView.StodoTextView.isHidden = true
            }
        }
    }
}
