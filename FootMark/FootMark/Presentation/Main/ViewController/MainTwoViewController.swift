//
//  MainTwoViewController.swift
//  FootMark
//
//  Created by 박신영 on 6/14/24.
//

import UIKit
import FSCalendar
import SnapKit
import Then


class MainTwoViewController: BaseViewController {
   
   let sidebarButton = UIButton()
   let calContainer = UIView()
   var events = [Date]()
   var sidebarVC: SidebarViewController2?
   var isSidebarPresented = false
   let dimmingView = UIView()
   let nickNameLabel = UILabel()
   
   let studyContainer = UIView()
   
   var percentLabel = UILabel()
   
   let emojiLabel = UILabel().then {
      $0.font = UIFont.pretendard(size: 40, weight: .semibold)
      $0.text = "🫥"
      $0.isUserInteractionEnabled = true
   }
   var emojiLabelTap: (() -> Void)?
   var goal1Btn = UIButton()
   var goal1TitleTextLabel = UITextField()
   var goal2Btn = UIButton()
   var goal2TitleTextLabel = UITextField()
   let checkboxView1 = CheckboxView()
   let checkboxView2 = CheckboxView()
   
   // 현재 캘린더가 보여주고 있는 Page 트래킹
   lazy var currentPage = calendarView.currentPage
   
   // 이전 달로 이동 버튼
   private let prevButton = UIButton(type: .system).then {
      $0.setImage(UIImage(systemName: "chevron.left"), for: .normal)
      $0.tintColor = .black1
   }
   
   // 다음 달로 이동 버튼
   private let nextButton = UIButton(type: .system).then {
      $0.setImage(UIImage(systemName: "chevron.right"), for: .normal)
      $0.tintColor = .black1
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
      calendar.appearance.headerTitleColor = .black1
      calendar.appearance.headerTitleFont = .pretendard(size: 17, weight: .bold)
      
      // 요일 UI 설정
      calendar.appearance.weekdayFont = .pretendard(size: 12, weight: .black)
      calendar.appearance.weekdayTextColor = .black
      
      // 날짜 UI 설정
      calendar.appearance.titleTodayColor = .black
      calendar.appearance.titleFont = .pretendard(size: 16, weight: .medium)
      calendar.appearance.subtitleFont = .pretendard(size: 10, weight: .black)
      calendar.appearance.subtitleTodayColor = .SWprimary
      calendar.appearance.todayColor = .white
      
      return calendar
   }()
   
   override func viewDidLoad() {
      super.viewDidLoad()
      self.navigationItem.hidesBackButton = true
      setAction()
      setEvents()
      calendarView.appearance.eventDefaultColor = UIColor.green
      calendarView.appearance.eventSelectionColor = UIColor.green
      setupDimmingView()
      
      DispatchQueue.main.async {
         self.calendarView.calendarWeekdayView.weekdayLabels[5].textColor = .blue
         self.calendarView.calendarWeekdayView.weekdayLabels[6].textColor = .red
      }
   }
   
   override func setAddTarget() {
      sidebarButton.addTarget(self, action: #selector(sidebarButtonTapped), for: .touchUpInside)
      let tapGesture = UITapGestureRecognizer(target: self, action: #selector(emojiLabelTapped))
      emojiLabel.addGestureRecognizer(tapGesture)
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
         $0.backgroundColor = .white1
      }
      
      goal1Btn.do {
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
      
      goal1TitleTextLabel.do {
         $0.text = "운동"
         $0.font = .pretendard(size: 25, weight: .bold)
         $0.textColor = .white
      }
      
      nickNameLabel.do {
         $0.text = "sy Park 님"
         $0.font = .pretendard(size: 25, weight: .black)
         $0.textColor = .white
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
         $0.text = "100%"
      }
   }
   
   override func setLayout() {
      view.addSubviews(sidebarButton, nickNameLabel, emojiLabel, percentLabel, calContainer, goal1Btn, goal1TitleTextLabel, checkboxView1, studyContainer)
      calContainer.addSubviews(calendarView, prevButton, nextButton)
      studyContainer.addSubviews(goal2Btn, goal2TitleTextLabel, checkboxView2)
      
      sidebarButton.snp.makeConstraints {
         $0.top.equalToSuperview().offset(80)
         $0.leading.equalToSuperview().inset(10)
         $0.size.equalTo(50)
      }
      
      nickNameLabel.snp.makeConstraints {
         $0.centerY.equalTo(sidebarButton)
         $0.leading.equalTo(sidebarButton.snp.trailing).offset(10)
      }
      
      emojiLabel.snp.makeConstraints {
         $0.centerY.equalTo(sidebarButton)
         $0.trailing.equalToSuperview().inset(20)
      }
      
      percentLabel.snp.makeConstraints {
         $0.trailing.equalToSuperview().inset(15)
         $0.top.equalTo(emojiLabel.snp.bottom).offset(5)
      }
      
      calContainer.snp.makeConstraints {
         $0.top.equalTo(sidebarButton.snp.bottom).offset(50)
         $0.horizontalEdges.equalToSuperview().inset(20)
         $0.height.equalTo(380)
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
      
      goal1Btn.snp.makeConstraints {
         $0.top.equalTo(calContainer.snp.bottom).offset(30)
         $0.leading.equalToSuperview().offset(20)
         $0.size.equalTo(24)
      }
      
      goal1TitleTextLabel.snp.makeConstraints {
         $0.centerY.equalTo(goal1Btn)
         $0.leading.equalTo(goal1Btn.snp.trailing).offset(15)
      }
      
      checkboxView1.snp.makeConstraints {
         $0.top.equalTo(goal1Btn.snp.bottom).offset(10)
         $0.leading.equalToSuperview().inset(50)
         $0.height.equalTo(40)
         $0.trailing.equalToSuperview()
      }
      
      studyContainer.snp.makeConstraints {
         $0.horizontalEdges.equalToSuperview().inset(20)
         $0.top.equalTo(checkboxView1.snp.bottom).offset(20)
         $0.height.equalTo(200)
      }
      
      goal2Btn.snp.makeConstraints {
         $0.top.equalToSuperview()
         $0.leading.equalTo(goal1Btn)
         $0.size.equalTo(24)
      }
      
      goal2TitleTextLabel.snp.makeConstraints {
         $0.centerY.equalTo(goal2Btn)
         $0.leading.equalTo(goal2Btn.snp.trailing).offset(15)
      }
      
      checkboxView2.snp.makeConstraints {
         $0.top.equalTo(goal2Btn.snp.bottom).offset(10)
         $0.leading.equalToSuperview().inset(30)
         $0.height.equalTo(40)
         $0.trailing.equalToSuperview()
      }
   }
   
   func setEvents() {
      let dfMatter = DateFormatter()
      dfMatter.locale = Locale(identifier: "ko_KR")
      dfMatter.dateFormat = "yyyy-MM-dd"
      
      // events
      let mayEvent12 = dfMatter.date(from: "2024-05-05")
      let mayEvent13 = dfMatter.date(from: "2024-05-15")
      
      let juneEvent12 = dfMatter.date(from: "2024-06-12")
      let juneEvent13 = dfMatter.date(from: "2024-06-13")
      let juneEvent14 = dfMatter.date(from: "2024-06-14")
      
      events = [mayEvent12!, mayEvent13!, juneEvent12!, juneEvent13!, juneEvent14!]
   }
   
   func showSidebar() {
      guard !isSidebarPresented else { return }
      sidebarVC = SidebarViewController2()
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
      if self.emojiLabel.text == "😂" {
         let diaryVC = BFDiaryViewController()
         self.navigationController?.pushViewController(diaryVC, animated: true)
      } else if self.emojiLabel.text == "😎" {
         let diaryVC = TTDiaryViewController()
         self.navigationController?.pushViewController(diaryVC, animated: true)
      } else if self.emojiLabel.text == "🥸" {
         let diaryVC = MayViewController()
         self.navigationController?.pushViewController(diaryVC, animated: true)
      } else if self.emojiLabel.text == "😀" {
         let diaryVC = DiaryViewController()
         self.navigationController?.pushViewController(diaryVC, animated: true)
      } else {
         let diaryVC = AddDiaryViewController()
         self.navigationController?.pushViewController(diaryVC, animated: true)
      }
      
   }
}

// MARK: - Methods
extension MainTwoViewController {
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
extension MainTwoViewController: FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {
   
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
         return .label
      }
   }
   
   // 날짜 선택 시 호출되는 메서드
   func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
      let dateFormatter = DateFormatter()
      dateFormatter.locale = Locale(identifier: "ko_KR")
      dateFormatter.timeZone = TimeZone(abbreviation: "KST")
      dateFormatter.dateFormat = "dd"
      
      let day = dateFormatter.string(from: date)
      DispatchQueue.main.async {
         if day == "05" {
            self.emojiLabel.text = "🥳"
            self.percentLabel.text = "100%"
            self.studyContainer.isHidden = true
            self.checkboxView1.title = "유산소 5km"
         } else if day == "15" {
            self.emojiLabel.text = "🥸"
            self.percentLabel.text = "100%"
            self.studyContainer.isHidden = true
            self.checkboxView1.title = "웨이트 1시간"
         } else if day == "12" {
            self.emojiLabel.text = "😂"
            self.checkboxView1.title = "하체운동, 줄넘기, 유산소"
            self.percentLabel.text = "100%"
            self.studyContainer.isHidden = true
         } else if day == "13" {
            self.emojiLabel.text = "😎"
            self.checkboxView1.title = "가슴+삼두운동, 줄넘기, 유산소"
            self.percentLabel.text = "100%"
            self.studyContainer.isHidden = true
         } else if day == "14" {
            self.emojiLabel.text = "😀"
            self.percentLabel.text = "100%"
            self.studyContainer.isHidden = false
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
