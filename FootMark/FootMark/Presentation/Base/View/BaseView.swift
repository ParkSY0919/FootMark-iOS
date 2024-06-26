//
//  BaseView.swift
//  FootMark
//
//  Created by 박신영 on 3/21/24.
//

import UIKit
import Then
import SnapKit

class BaseView: UIView {
   // MARK: - Initializer
   init() {
      super.init(frame: .zero)
      setHierarchy()
      setLayout()
      setDelegate()
      setUI()
      
//      setUI()
//      setHierarchy()
//      setLayout()
//      setDelegate()
   }
   required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
   // MARK: - UI Components Property
   func setUI(){}
   // MARK: - set View Hierarchy
   func setHierarchy() {}
   // MARK: - Layout Helper
   func setLayout(){}
   // MARK: - Delegate Helper
   func setDelegate(){}
}
