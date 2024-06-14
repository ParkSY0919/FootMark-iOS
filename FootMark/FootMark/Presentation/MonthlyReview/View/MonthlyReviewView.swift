import UIKit
import SnapKit
import Then

class MonthlyReviewView: BaseView {
    
    let navigationContainer = UIView()
    let navigationBackBtn = UIButton()
    var didTapBackBtn: (() -> Void)?
    
    let dropDownButton = UIButton().then {
        $0.setTitle("Select Month", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.backgroundColor = .lightGray
        $0.layer.cornerRadius = 5
       $0.isUserInteractionEnabled = true
    }
    
    let months = ["January 2024", "February 2024", "March 2024", "April 2024", "May 2024", "June 2024"]
    var selectedMonth: String?
   
   private let dropDownButton1 = UIButton().then {
           $0.setTitle("Select Fruit", for: .normal)
           $0.setTitleColor(.black, for: .normal)
       }
       
       private let dropDownTableView = UITableView().then {
           $0.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
           $0.isHidden = true
       }
       
       private let dataSource = ["Apple", "Mango", "Orange", "Banana", "Kiwi", "Watermelon"]
       
       private let containerView = UIView()
    
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
        navigationContainer.addSubviews(navigationBackBtn, dropDownButton)
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
    }
   
}

