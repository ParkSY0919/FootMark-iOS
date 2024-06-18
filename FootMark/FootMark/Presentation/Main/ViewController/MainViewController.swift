//
//  ViewController.swift
//  FootMark
//
//  Created by 박신영 on 3/21/24.
//

import UIKit
import FSCalendar
import SnapKit
import Then


class MainViewController: BaseViewController {
   
   let sidebarButton = UIButton()
   let calContainer = UIView()
   var events = [Date]()
   var sidebarVC: SidebarViewController?
   var isSidebarPresented = false
   let dimmingView = UIView()
   let nickNameLabel = UILabel()
   let messageLabel = UILabel()
   
   let studyContainer = UIView()
   var percentLabel = UILabel()
   var isalreadyLoadToday = false
   var categoryContainer = UIView()
   var categoryCount = UserDefaults.standard.integer(forKey: "categoryCount")
   var categoryName1 = ""
   var categoryName2 = ""
   var allCategoryCount = 0
   
   let emojiLabel = UILabel().then {
      $0.font = UIFont.pretendard(size: 40, weight: .semibold)
      $0.text = "🫥"
      $0.isUserInteractionEnabled = true
   }
   var emojiLabelTap: (() -> Void)?
   var goal1Btn = UIButton()
   var goal1TitleTextLabel = UILabel()
   var goal2Btn = UIButton()
   var goal2TitleTextLabel = UILabel()
   let checkboxView1 = CheckboxView()
   let checkboxView2 = CheckboxView()
   
   // 현재 캘린더가 보여주고 있는 Page 트래킹
   lazy var currentPage = calendarView.currentPage
   
   let categoryLabel = UILabel().then {
      $0.setPretendardFont(text: "Category", size: 20, weight: .bold, letterSpacing: 1.25)
      $0.textColor = .white
   }
   
   let emojiLabel2 = UILabel().then {
      $0.text = "🥺"
      $0.font = UIFont.pretendard(size: 40, weight: .semibold)
      $0.textAlignment = .center
   }
   
   let noCategoryLabel = UILabel().then {
      $0.setPretendardFont(text: "등록된 목표와 Todo가 없어요!\n목표와 Todo를 등록해봐요!", size: 16, weight: .bold, letterSpacing: 1.25)
      $0.numberOfLines = 3
      $0.textAlignment = .center
      $0.textColor = .white1
   }
   
   let noCategoryContainer = UIView()
   
   let categoryPlusBtn = UIButton()
   
   // 이전 달로 이동 버튼
   private let prevButton = UIButton(type: .system).then {
      $0.setImage(UIImage(systemName: "chevron.left"), for: .normal)
      $0.tintColor = .white1
   }
   
   // 다음 달로 이동 버튼
   private let nextButton = UIButton(type: .system).then {
      $0.setImage(UIImage(systemName: "chevron.right"), for: .normal)
      $0.tintColor = .white1
   }
   
   private lazy var calendarView: FSCalendar = {
      let calendar = FSCalendar()
      calendar.dataSource = self
      calendar.delegate = self
      
      // 첫 열을 월요일로 설정
      calendar.firstWeekday = 2
      // week 또는 month 가능
      calendar.scope = .month
      
      calendar.scrollEnabled = false
      calendar.locale = Locale(identifier: "ko_KR")
      
      // 현재 달의 날짜들만 표기하도록 설정
      calendar.placeholderType = .none
      
      // 헤더뷰 설정
      calendar.headerHeight = 55
      calendar.appearance.headerDateFormat = "YYYY년 MM월"
      calendar.appearance.headerTitleColor = .white1
      calendar.appearance.headerTitleFont = .pretendard(size: 17, weight: .bold)
      
      // 요일 UI 설정
      calendar.appearance.weekdayFont = .pretendard(size: 12, weight: .black)
      calendar.appearance.weekdayTextColor = .white1
      
      // 날짜 UI 설정
      calendar.appearance.titleTodayColor = .white1
      calendar.appearance.titleFont = .pretendard(size: 16, weight: .medium)
      calendar.appearance.subtitleFont = .pretendard(size: 10, weight: .black)
      calendar.appearance.subtitleTodayColor = .SWprimary
      calendar.appearance.todayColor = .orange
      
      return calendar
   }()
   
   override func viewDidLoad() {
      super.viewDidLoad()
      //      self.navigationController?.navigationBar.isHidden = true
      self.navigationItem.hidesBackButton = true
      setAction()
      setEvents()
      calendarView.appearance.eventDefaultColor = UIColor.green
      calendarView.appearance.eventSelectionColor = UIColor.green
      setupDimmingView()
      
      DispatchQueue.main.async {
         for i in 0...4 {
            self.calendarView.calendarWeekdayView.weekdayLabels[i].textColor = .white
         }
         self.calendarView.calendarWeekdayView.weekdayLabels[5].textColor = .blue
         self.calendarView.calendarWeekdayView.weekdayLabels[6].textColor = .red
      }
      getTodos()
   }
   
   override func setAddTarget() {
      sidebarButton.addTarget(self, action: #selector(sidebarButtonTapped), for: .touchUpInside)
      let tapGesture = UITapGestureRecognizer(target: self, action: #selector(emojiLabelTapped))
      emojiLabel.addGestureRecognizer(tapGesture)
      categoryPlusBtn.addTarget(self, action: #selector(didTapCategoryPlusBtn), for: .touchUpInside)
   }
   
   override func setUI() {
      view.backgroundColor = .black1
      
      studyContainer.do {
         $0.isHidden = false
      }
      
      sidebarButton.do {
         $0.setImage(UIImage(systemName: "line.3.horizontal"), for: .normal)
         $0.tintColor = .white1
         $0.imageView?.contentMode = .scaleAspectFit
         $0.contentMode = .center
      }
      
      calContainer.do {
         $0.layer.cornerRadius = 10
         $0.backgroundColor = .black1
         $0.layer.borderColor = UIColor.white.cgColor
      }
      
      categoryPlusBtn.do {
         $0.setImage(UIImage(systemName: "plus.circle"), for: .normal)
         $0.tintColor = .white
         $0.imageView?.snp.makeConstraints {
            $0.edges.equalToSuperview()
         }
      }
      
      goal1Btn.do {
         $0.setImage(UIImage(systemName: "trophy"), for: .normal)
         $0.tintColor = .SWprimary2
         $0.imageView?.snp.makeConstraints {
            $0.edges.equalToSuperview()
         }
      }
      
      goal1TitleTextLabel.do {
         $0.text = "운동"
         $0.font = .pretendard(size: 25, weight: .bold)
         $0.textColor = .white
      }
      
      nickNameLabel.do {
         let userdefaultsNickName = UserDefaults.standard.string(forKey: "userNickname")
         $0.text = userdefaultsNickName
         $0.font = .pretendard(size: 25, weight: .black)
         $0.textColor = .white
      }
      
      messageLabel.do {
         let messageText = UserDefaults.standard.string(forKey: "messageText") ?? ""
         
         if messageText.count <= 1 {
            $0.text = "상태메세지를 설정해주세요"
            $0.font = .pretendard(size: 12, weight: .black)
         } else {
            $0.text = UserDefaults.standard.string(forKey: "messageText")
            $0.font = .pretendard(size: 16, weight: .black)
         }
         
         $0.textColor = .white1
      }
      
      goal2Btn.do {
         var config = UIButton.Configuration.filled()
         config.image = UIImage(systemName: "plus.circle")
         config.imagePlacement = .leading
         config.imagePadding = 8
         config.imageColorTransformer = UIConfigurationColorTransformer {_ in
            return UIColor.blue
         }
         
         $0.configuration = config
         $0.clipsToBounds = true
         $0.layer.cornerRadius = 12
      }
      
      goal2TitleTextLabel.do {
         $0.text = "공부"
         $0.font = .pretendard(size: 25, weight: .bold)
         $0.textColor = .white
      }
      
      checkboxView1.do {
         $0.isUserInteractionEnabled = true
         $0.title = "수영, 산책, 달리기"
         $0.isChecked = true
      }
      
      checkboxView2.do {
         $0.isUserInteractionEnabled = true
         $0.title = "Swift, 알고리즘"
         $0.isChecked = true
      }
      
      percentLabel.do {
         $0.font = .pretendard(size: 15, weight: .heavy)
         $0.textColor = .white
         $0.text = "Today Mood"
      }
   }
   
   override func setLayout() {
      
      view.addSubviews(sidebarButton, nickNameLabel, messageLabel, emojiLabel, percentLabel, calContainer, categoryContainer)
      calContainer.addSubviews(calendarView, prevButton, nextButton)
      categoryContainer.addSubviews(categoryLabel, categoryPlusBtn, noCategoryContainer)
      noCategoryContainer.addSubviews(emojiLabel2, noCategoryLabel)
      
      sidebarButton.snp.makeConstraints {
         $0.top.equalToSuperview().offset(80)
         $0.leading.equalToSuperview().inset(10)
         $0.size.equalTo(50)
      }
      
      nickNameLabel.snp.makeConstraints {
         $0.centerY.equalTo(sidebarButton)
         $0.leading.equalTo(sidebarButton.snp.trailing).offset(10)
      }
      
      messageLabel.snp.makeConstraints {
         $0.top.equalTo(nickNameLabel.snp.bottom).offset(10)
         $0.leading.equalTo(nickNameLabel)
      }
      
      emojiLabel.snp.makeConstraints {
         $0.centerY.equalTo(sidebarButton)
         $0.centerX.equalTo(percentLabel)
      }
      
      percentLabel.snp.makeConstraints {
         $0.trailing.equalToSuperview().inset(15)
         $0.top.equalTo(emojiLabel.snp.bottom).offset(5)
      }
      
      calContainer.snp.makeConstraints {
         $0.top.equalTo(sidebarButton.snp.bottom).offset(30)
         $0.horizontalEdges.equalToSuperview().inset(20)
         $0.height.equalTo(350)
      }
      
      calendarView.snp.makeConstraints {
         $0.center.equalToSuperview()
         $0.height.equalTo(330)
         $0.width.equalTo(356)
      }
      
      prevButton.snp.makeConstraints {
         $0.centerY.equalTo(calendarView.calendarHeaderView).multipliedBy(1.1)
         $0.leading.equalTo(calendarView.calendarHeaderView.snp.leading).inset(80)
      }
      
      nextButton.snp.makeConstraints {
         $0.centerY.equalTo(calendarView.calendarHeaderView).multipliedBy(1.1)
         $0.trailing.equalTo(calendarView.calendarHeaderView.snp.trailing).inset(80)
      }
      
      categoryContainer.snp.makeConstraints {
         $0.top.equalTo(calContainer.snp.bottom).offset(5)
         $0.horizontalEdges.equalToSuperview().inset(20)
         $0.bottom.equalToSuperview().inset(10)
      }
      
      categoryLabel.snp.makeConstraints {
         $0.top.leading.equalToSuperview().inset(10)
         $0.height.equalTo(21)
      }
      
      categoryPlusBtn.snp.makeConstraints {
         $0.top.trailing.equalToSuperview().inset(10)
         $0.size.equalTo(30)
      }
      
      noCategoryContainer.snp.makeConstraints {
         $0.top.equalTo(categoryPlusBtn.snp.bottom).offset(10)
         $0.horizontalEdges.bottom.equalToSuperview().inset(10)
      }
      
      emojiLabel2.snp.makeConstraints {
         $0.centerX.equalTo(noCategoryLabel)
         $0.bottom.equalTo(noCategoryLabel.snp.top).offset(-10)
      }
      
      noCategoryLabel.snp.makeConstraints {
         $0.center.equalToSuperview()
      }
      //      else {
      //         view.addSubviews(sidebarButton, nickNameLabel, messageLabel, emojiLabel, percentLabel, calContainer, goal1Btn, goal1TitleTextLabel, checkboxView1, studyContainer)
      //         calContainer.addSubviews(calendarView, prevButton, nextButton)
      //         studyContainer.addSubviews(goal2Btn, goal2TitleTextLabel, checkboxView2, categoryPlusBtn)
      //
      //         sidebarButton.snp.makeConstraints {
      //            $0.top.equalToSuperview().offset(80)
      //            $0.leading.equalToSuperview().inset(10)
      //            $0.size.equalTo(50)
      //         }
      //
      //         nickNameLabel.snp.makeConstraints {
      //            $0.centerY.equalTo(sidebarButton)
      //            $0.leading.equalTo(sidebarButton.snp.trailing).offset(10)
      //         }
      //
      //         messageLabel.snp.makeConstraints {
      //            $0.top.equalTo(nickNameLabel.snp.bottom).offset(10)
      //            $0.leading.equalTo(nickNameLabel)
      //         }
      //
      //         emojiLabel.snp.makeConstraints {
      //            $0.centerY.equalTo(sidebarButton)
      //            $0.centerX.equalTo(percentLabel)
      //         }
      //
      //         percentLabel.snp.makeConstraints {
      //            $0.trailing.equalToSuperview().inset(15)
      //            $0.top.equalTo(emojiLabel.snp.bottom).offset(5)
      //         }
      //
      //         calContainer.snp.makeConstraints {
      //            $0.top.equalTo(sidebarButton.snp.bottom).offset(30)
      //            $0.horizontalEdges.equalToSuperview().inset(20)
      //            $0.height.equalTo(380)
      //         }
      //
      //         calendarView.snp.makeConstraints {
      //            $0.center.equalToSuperview()
      //            $0.height.equalTo(330)
      //            $0.width.equalTo(356)
      //         }
      //
      //         prevButton.snp.makeConstraints {
      //            $0.centerY.equalTo(calendarView.calendarHeaderView).multipliedBy(1.1)
      //            $0.leading.equalTo(calendarView.calendarHeaderView.snp.leading).inset(80)
      //         }
      //
      //         nextButton.snp.makeConstraints {
      //            $0.centerY.equalTo(calendarView.calendarHeaderView).multipliedBy(1.1)
      //            $0.trailing.equalTo(calendarView.calendarHeaderView.snp.trailing).inset(80)
      //         }
      //
      //         goal1Btn.snp.makeConstraints {
      //            $0.top.equalTo(calContainer.snp.bottom).offset(30)
      //            $0.leading.equalToSuperview().offset(20)
      //            $0.size.equalTo(24)
      //         }
      //
      //         goal1TitleTextLabel.snp.makeConstraints {
      //            $0.centerY.equalTo(goal1Btn)
      //            $0.leading.equalTo(goal1Btn.snp.trailing).offset(15)
      //         }
      //
      //         checkboxView1.snp.makeConstraints {
      //            $0.top.equalTo(goal1Btn.snp.bottom).offset(10)
      //            $0.leading.equalToSuperview().inset(50)
      //            $0.height.equalTo(40)
      //            $0.trailing.equalToSuperview()
      //         }
      //
      //         studyContainer.snp.makeConstraints {
      //            $0.horizontalEdges.equalToSuperview().inset(20)
      //            $0.top.equalTo(checkboxView1.snp.bottom).offset(20)
      //            $0.height.equalTo(200)
      //         }
      //
      //         goal2Btn.snp.makeConstraints {
      //            $0.top.equalToSuperview()
      //            $0.leading.equalTo(goal1Btn)
      //            $0.size.equalTo(24)
      //         }
      //
      //         goal2TitleTextLabel.snp.makeConstraints {
      //            $0.centerY.equalTo(goal2Btn)
      //            $0.leading.equalTo(goal2Btn.snp.trailing).offset(15)
      //         }
      //
      //         checkboxView2.snp.makeConstraints {
      //            $0.top.equalTo(goal2Btn.snp.bottom).offset(10)
      //            $0.leading.equalToSuperview().inset(30)
      //            $0.height.equalTo(40)
      //            $0.trailing.equalToSuperview()
      //         }
      //
      //         categoryPlusBtn.snp.makeConstraints {
      //            $0.top.trailing.equalToSuperview().inset(10)
      //            $0.size.equalTo(30)
      //         }
      //      }
   }
   
   func getTodos(for date: String? = nil) {
      let todayString: String
      if let date = date {
         todayString = date
      } else {
         let today = Date()
         let dateFormatter = DateFormatter()
         dateFormatter.locale = Locale(identifier: "ko_KR")
         dateFormatter.timeZone = TimeZone(abbreviation: "KST")
         dateFormatter.dateFormat = "yyyy-MM-dd"
         todayString = dateFormatter.string(from: today)
      }
      
      if isalreadyLoadToday == false || date != nil {
         NetworkService.shared.mainService.getTodos(createAt: todayString) {
            result in
            switch result {
            case .success(let data):
               print(data)
               self.isalreadyLoadToday = true
            case .tokenExpired(_):
               print("refresh 토큰 만료입니다")
            case .requestErr:
               print("요청 오류입니다")
            case .decodedErr:
               print("디코딩 오류입니다")
            case .pathErr:
               print("경로 오류입니다")
            case .serverErr:
               print("서버 오류입니다")
            case .networkFail:
               print("네트워크 오류입니다")
            }
         }
      } else {
         NetworkService.shared.mainService.getTodos(createAt: todayString) {
            result in
            switch result {
            case .success(let data):
               print(data)
               self.isalreadyLoadToday = true
            case .tokenExpired(_):
               print("refresh 토큰 만료입니다")
            case .requestErr:
               print("요청 오류입니다")
            case .decodedErr:
               print("디코딩 오류입니다")
            case .pathErr:
               print("경로 오류입니다")
            case .serverErr:
               print("서버 오류입니다")
            case .networkFail:
               print("네트워크 오류입니다")
            }
         }
      }
   }
   
   func setEvents() {
      let dfMatter = DateFormatter()
      dfMatter.locale = Locale(identifier: "ko_KR")
      dfMatter.dateFormat = "yyyy-MM-dd"
      
      // events
//      let mayEvent12 = dfMatter.date(from: "2024-05-05")
      
      events = []
   }
   
   func showSidebar() {
      guard !isSidebarPresented else { return }
      sidebarVC = SidebarViewController()
      guard let sidebarVC = sidebarVC else { return }
      
      self.addChild(sidebarVC)
      self.view.addSubview(sidebarVC.view)
      
      let sidebarWidth = self.view.frame.width * 2 / 3
      sidebarVC.view.frame = CGRect(x: -sidebarWidth, y: 0, width: sidebarWidth, height: self.view.frame.height)
      
      UIView.animate(withDuration: 0.5, animations: {
         sidebarVC.view.frame = CGRect(x: 0, y: 0, width: sidebarWidth, height: self.view.frame.height)
         self.dimmingView.alpha = 1.0
      }) { (finished) in
         if finished {
            self.isSidebarPresented = true
         }
      }
   }
   
   func setupDimmingView() {
      dimmingView.backgroundColor = UIColor.black.withAlphaComponent(0.0)
      dimmingView.alpha = 0.0
      view.addSubview(dimmingView)
      
      dimmingView.snp.makeConstraints {
         $0.top.equalToSuperview()
         $0.bottom.equalToSuperview()
         $0.leading.equalToSuperview()
         $0.trailing.equalToSuperview()
      }
      
      let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideSidebar))
      dimmingView.addGestureRecognizer(tapGesture)
   }
   
   
   @objc func handleTap(_ gesture: UITapGestureRecognizer) {
      hideSidebar()
   }
   
   @objc func sidebarButtonTapped() {
      if isSidebarPresented {
         hideSidebar()
      } else {
         showSidebar()
      }
   }
   
   @objc func hideSidebar() {
      guard let sidebarVC = sidebarVC else { return }
      
      UIView.animate(withDuration: 0.5, animations: {
         sidebarVC.view.frame = CGRect(x: -self.view.frame.width, y: 0, width: self.view.frame.width, height: self.view.frame.height)
         self.dimmingView.alpha = 0.0
      }) { (finished) in
         sidebarVC.willMove(toParent: nil)
         sidebarVC.view.removeFromSuperview()
         sidebarVC.removeFromParent()
         self.isSidebarPresented = false
      }
   }
   
   @objc private func emojiLabelTapped() {
      let alertVC = CategoryViewController()
      alertVC.isModalInPresentation = false
      present(alertVC, animated: true, completion: nil)
      
      //Diary 파트
      //      if self.emojiLabel.text == "😂" {
      //         let diaryVC = BFDiaryViewController()
      //         self.navigationController?.pushViewController(diaryVC, animated: true)
      //      } else if self.emojiLabel.text == "😎" {
      //         let diaryVC = TTDiaryViewController()
      //         self.navigationController?.pushViewController(diaryVC, animated: true)
      //      }
      
   }
   
   func updateView(count: Int) {
      if count == 0 {
         view.addSubviews(sidebarButton, nickNameLabel, messageLabel, emojiLabel, percentLabel, calContainer, categoryContainer)
         calContainer.addSubviews(calendarView, prevButton, nextButton)
         categoryContainer.addSubviews(categoryLabel, categoryPlusBtn, noCategoryContainer)
         noCategoryContainer.addSubviews(emojiLabel2, noCategoryLabel)
         
         sidebarButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(80)
            $0.leading.equalToSuperview().inset(10)
            $0.size.equalTo(50)
         }
         
         nickNameLabel.snp.makeConstraints {
            $0.centerY.equalTo(sidebarButton)
            $0.leading.equalTo(sidebarButton.snp.trailing).offset(10)
         }
         
         messageLabel.snp.makeConstraints {
            $0.top.equalTo(nickNameLabel.snp.bottom).offset(10)
            $0.leading.equalTo(nickNameLabel)
         }
         
         emojiLabel.snp.makeConstraints {
            $0.centerY.equalTo(sidebarButton)
            $0.centerX.equalTo(percentLabel)
         }
         
         percentLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(15)
            $0.top.equalTo(emojiLabel.snp.bottom).offset(5)
         }
         
         calContainer.snp.makeConstraints {
            $0.top.equalTo(sidebarButton.snp.bottom).offset(30)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(350)
         }
         
         calendarView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.height.equalTo(330)
            $0.width.equalTo(356)
         }
         
         prevButton.snp.makeConstraints {
            $0.centerY.equalTo(calendarView.calendarHeaderView).multipliedBy(1.1)
            $0.leading.equalTo(calendarView.calendarHeaderView.snp.leading).inset(80)
         }
         
         nextButton.snp.makeConstraints {
            $0.centerY.equalTo(calendarView.calendarHeaderView).multipliedBy(1.1)
            $0.trailing.equalTo(calendarView.calendarHeaderView.snp.trailing).inset(80)
         }
         
         categoryContainer.snp.makeConstraints {
            $0.top.equalTo(calContainer.snp.bottom).offset(5)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().inset(10)
         }
         
         categoryLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(10)
            $0.height.equalTo(21)
         }
         
         categoryPlusBtn.snp.makeConstraints {
            $0.top.trailing.equalToSuperview().inset(10)
            $0.size.equalTo(30)
         }
         
         noCategoryContainer.snp.makeConstraints {
            $0.top.equalTo(categoryPlusBtn.snp.bottom).offset(10)
            $0.horizontalEdges.bottom.equalToSuperview().inset(10)
         }
         
         emojiLabel2.snp.makeConstraints {
            $0.centerX.equalTo(noCategoryLabel)
            $0.bottom.equalTo(noCategoryLabel.snp.top).offset(-10)
         }
         
         noCategoryLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
         }
      } else if count == 1 {
         goal1TitleTextLabel.text = categoryName1
         
         view.addSubviews(sidebarButton, nickNameLabel, messageLabel, emojiLabel, percentLabel, calContainer, categoryContainer)
         
         calContainer.addSubviews(calendarView, prevButton, nextButton)
         categoryContainer.addSubviews(categoryLabel, categoryPlusBtn, noCategoryContainer)
         
         noCategoryContainer.addSubviews(emojiLabel2, noCategoryLabel)
         
         sidebarButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(80)
            $0.leading.equalToSuperview().inset(10)
            $0.size.equalTo(50)
         }
         
         nickNameLabel.snp.makeConstraints {
            $0.centerY.equalTo(sidebarButton)
            $0.leading.equalTo(sidebarButton.snp.trailing).offset(10)
         }
         
         messageLabel.snp.makeConstraints {
            $0.top.equalTo(nickNameLabel.snp.bottom).offset(10)
            $0.leading.equalTo(nickNameLabel)
         }
         
         emojiLabel.snp.makeConstraints {
            $0.centerY.equalTo(sidebarButton)
            $0.centerX.equalTo(percentLabel)
         }
         
         percentLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(15)
            $0.top.equalTo(emojiLabel.snp.bottom).offset(5)
         }
         
         calContainer.snp.makeConstraints {
            $0.top.equalTo(sidebarButton.snp.bottom).offset(30)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(350)
         }
         
         calendarView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.height.equalTo(330)
            $0.width.equalTo(356)
         }
         
         prevButton.snp.makeConstraints {
            $0.centerY.equalTo(calendarView.calendarHeaderView).multipliedBy(1.1)
            $0.leading.equalTo(calendarView.calendarHeaderView.snp.leading).inset(80)
         }
         
         nextButton.snp.makeConstraints {
            $0.centerY.equalTo(calendarView.calendarHeaderView).multipliedBy(1.1)
            $0.trailing.equalTo(calendarView.calendarHeaderView.snp.trailing).inset(80)
         }
         
         categoryContainer.snp.makeConstraints {
            $0.top.equalTo(calContainer.snp.bottom).offset(5)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().inset(10)
         }
         
         categoryLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(10)
            $0.height.equalTo(21)
         }
         
         categoryPlusBtn.snp.makeConstraints {
            $0.top.trailing.equalToSuperview().inset(10)
            $0.size.equalTo(30)
         }
         
         noCategoryContainer.snp.makeConstraints {
            $0.top.equalTo(categoryPlusBtn.snp.bottom).offset(10)
            $0.horizontalEdges.bottom.equalToSuperview().inset(10)
         }
         
         emojiLabel2.snp.removeConstraints()
         noCategoryLabel.snp.removeConstraints()
         
         
         noCategoryContainer.addSubviews(goal1Btn, goal1TitleTextLabel)
         goal1Btn.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.size.equalTo(40)
         }
         goal1TitleTextLabel.snp.makeConstraints {
            $0.leading.equalTo(goal1Btn.snp.trailing).offset(5)
            $0.centerY.equalTo(goal1Btn)
         }
         
      }
   }
   
   @objc private func didTapCategoryPlusBtn() {
      let alertVC = CategoryViewController()
      alertVC.isModalInPresentation = false
      alertVC.mainVC = self // self를 전달합니다.
      alertVC.categoryClosure = {
         self.updateView(count: self.allCategoryCount)
      }
      present(alertVC, animated: true, completion: nil)
      
   }
}

// MARK: - Methods
extension MainViewController {
   private func setAction() {
      [prevButton, nextButton].forEach {
         $0.addTarget(self, action: #selector(moveMonthButtonDidTap(sender:)), for: .touchUpInside)
      }
   }
   
   @objc func moveMonthButtonDidTap(sender: UIButton) {
      moveMonth(next: sender == nextButton)
   }
   
   // 달 이동 로직
   func moveMonth(next: Bool) {
      var dateComponents = DateComponents()
      dateComponents.month = next ? 1 : -1
      self.currentPage = Calendar.current.date(byAdding: dateComponents, to: self.currentPage)!
      calendarView.setCurrentPage(self.currentPage, animated: true)
   }
}

// MARK: - FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance
extension MainViewController: FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {
   
   // 공식 문서에서 레이아웃을 위해 아래의 코드 요구
   func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
      calendar.snp.updateConstraints { (make) in
         make.height.equalTo(bounds.height)
         // Do other updates
      }
      self.view.layoutIfNeeded()
   }
   
   func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
      if self.events.contains(date) {
         return 1
      } else {
         return 0
      }
   }
   
   // 오늘 cell에 subtitle 생성
   func calendar(_ calendar: FSCalendar, subtitleFor date: Date) -> String? {
      let dateFormatter = DateFormatter()
      dateFormatter.locale = Locale(identifier: "ko_KR")
      dateFormatter.timeZone = TimeZone(abbreviation: "KST")
      dateFormatter.dateFormat = "yyyy-MM-dd"
      
      switch dateFormatter.string(from: date) {
      case dateFormatter.string(from: Date()):
         return "오늘"
         
      default:
         return nil
         
      }
   }
   
   func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleDefaultColorFor date: Date) -> UIColor? {
      let weekday = Calendar.current.component(.weekday, from: date)
      
      if weekday == 1 { // 일요일
         return .red
      } else if weekday == 7 { // 토요일
         return .blue
      } else {
         return .white
      }
   }
   
   // 날짜 선택 시 호출되는 메서드
   func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
      let dateFormatter = DateFormatter()
      dateFormatter.locale = Locale(identifier: "ko_KR")
      dateFormatter.timeZone = TimeZone(abbreviation: "KST")
      dateFormatter.dateFormat = "yyyy-MM-dd"
      let day = dateFormatter.string(from: date)
      
      getTodos(for: day) // 선택된 날짜에 대해 getTodos 호출
      
      DispatchQueue.main.async {
         if day == "2024-06-05" {
            self.emojiLabel.text = "🥳"
            self.percentLabel.text = "100%"
            self.studyContainer.isHidden = true
            self.checkboxView1.title = "유산소 5km"
            self.goal1Btn.isHidden = false
            self.goal1TitleTextLabel.isHidden = false
            self.checkboxView1.isHidden = false
         } else if day == "2024-05-15" {
            self.emojiLabel.text = "🥸"
            self.percentLabel.text = "100%"
            self.studyContainer.isHidden = true
            self.checkboxView1.title = "웨이트 1시간"
            self.goal1Btn.isHidden = false
            self.goal1TitleTextLabel.isHidden = false
            self.checkboxView1.isHidden = false
         } else {
            self.emojiLabel.text = "🫥"
            self.percentLabel.text = "0%"
            self.studyContainer.isHidden = true
            self.goal1Btn.isHidden = true
            self.goal1TitleTextLabel.isHidden = true
            self.checkboxView1.isHidden = true
         }
      }
      
   }
   
}
