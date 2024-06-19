//
//  DiaryViewController.swift
//  FootMark
//
//  Created by 윤성은 on 3/24/24.
//

import UIKit
import ElegantEmojiPicker
import DropDown

class AddDiaryViewController: BaseViewController {
    var addDiaryView = AddDiaryView()
    let dropDown = DropDown()
   var closure: (() -> Void)?
    
    var postReviewGoal1Content: String = ""
    var postReviewGoal2Content: String = ""
    var postReviewThankfulContent: String = ""
    var postReviewBestContent: String = ""
    
    var addDiaryViewInitialEmoji: String = ""
    
    var categoryTodos: [String: String] = [:]
    
    var categoryTag: Bool = true
    var dropdowncount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(resource: .black1)
        
        setUpDelegates()
        setUpClosures()

        addDiaryView.dateLabel.text = "2024-06-19"
        
        updateTodo()
        
        addDiaryViewInitialEmoji = addDiaryView.emojiLabel.text ?? ""
       self.navigationController?.isNavigationBarHidden = false
       self.navigationController?.navigationBar.tintColor = .white
    }
    
    override func setLayout() {
        print("\(dropdowncount)")

        addDiaryView.subviews.forEach { $0.removeFromSuperview() }
        addDiaryView.snp.removeConstraints()
        addDiaryView.scrollView.subviews.forEach { $0.removeFromSuperview() }
        addDiaryView.scrollView.snp.removeConstraints()
        addDiaryView.contentView.subviews.forEach { $0.removeFromSuperview() }
        addDiaryView.contentView.snp.removeConstraints()

        if addDiaryView.superview == nil {
            view.addSubview(addDiaryView)
        }
       
       addDiaryView.addSubview(addDiaryView.scrollView)
           addDiaryView.scrollView.addSubview(addDiaryView.contentView)
           addDiaryView.contentView.addSubviews(
               addDiaryView.emojiLabel,
               addDiaryView.dateLabel,
               addDiaryView.categoryButton,
               addDiaryView.categoryLabel,
               addDiaryView.todoLabel,
               addDiaryView.todoTextView,
               addDiaryView.thankfulLabel,
               addDiaryView.thankfulTextView,
               addDiaryView.bestLabel,
               addDiaryView.bestTextView,
               addDiaryView.saveButton
           )
           
           addDiaryView.snp.makeConstraints {
               $0.edges.equalToSuperview()
           }

           addDiaryView.emojiLabel.snp.makeConstraints {
               $0.top.equalToSuperview()
               $0.centerX.equalToSuperview()
           }
           
           addDiaryView.dateLabel.snp.makeConstraints {
               $0.top.equalTo(addDiaryView.emojiLabel.snp.bottom).offset(40)
               $0.leading.trailing.equalToSuperview().inset(30)
           }
           
           addDiaryView.categoryButton.snp.makeConstraints {
               $0.top.equalTo(self.addDiaryView.emojiLabel.snp.bottom).offset(30)
               $0.centerY.equalTo(self.addDiaryView.dateLabel.snp.centerY)
               $0.trailing.equalToSuperview().offset(-30)
               $0.width.equalTo(150)
               $0.height.equalTo(50)
           }
           
           addDiaryView.categoryLabel.snp.makeConstraints {
               $0.top.equalTo(addDiaryView.dateLabel.snp.bottom).offset(50)
               $0.leading.trailing.equalToSuperview().inset(30)
           }
           
           addDiaryView.todoLabel.snp.makeConstraints {
               $0.top.equalTo(addDiaryView.categoryLabel.snp.bottom).offset(10)
               $0.leading.trailing.equalToSuperview().inset(30)
           }
           
           addDiaryView.todoTextView.snp.makeConstraints {
               $0.top.equalTo(addDiaryView.todoLabel.snp.bottom).offset(20)
               $0.centerX.equalToSuperview().inset(30)
               $0.width.equalTo(350)
               $0.height.equalTo(300)
           }
           
           addDiaryView.thankfulLabel.snp.makeConstraints {
               $0.top.equalTo(addDiaryView.todoTextView.snp.bottom).offset(50)
               $0.leading.trailing.equalToSuperview().inset(30)
           }
           
           addDiaryView.thankfulTextView.snp.makeConstraints {
               $0.top.equalTo(addDiaryView.thankfulLabel.snp.bottom).offset(20)
               $0.centerX.equalToSuperview().inset(30)
               $0.width.equalTo(350)
               $0.height.equalTo(200)
           }
           
           addDiaryView.bestLabel.snp.makeConstraints {
               $0.top.equalTo(addDiaryView.thankfulTextView.snp.bottom).offset(50)
               $0.leading.trailing.equalToSuperview().inset(30)
           }
           
           addDiaryView.bestTextView.snp.makeConstraints {
               $0.top.equalTo(addDiaryView.bestLabel.snp.bottom).offset(20)
               $0.centerX.equalToSuperview().inset(30)
               $0.width.equalTo(350)
               $0.height.equalTo(200)
           }

           addDiaryView.saveButton.snp.makeConstraints {
               $0.top.equalTo(addDiaryView.bestTextView.snp.bottom).offset(100)
               $0.centerX.equalToSuperview()
               $0.size.equalTo(CGSize(width: 350, height: 50))
           }
           
           addDiaryView.contentView.snp.makeConstraints {
               $0.edges.equalTo(addDiaryView.scrollView)
               $0.width.equalTo(addDiaryView.scrollView)
               $0.bottom.equalTo(addDiaryView.saveButton.snp.bottom).offset(50)
           }
           
           addDiaryView.scrollView.snp.makeConstraints {
               $0.edges.equalToSuperview()
           }

//        if dropdowncount != 0 {
//            addDiaryView.addSubview(addDiaryView.scrollView)
//            addDiaryView.scrollView.addSubview(addDiaryView.contentView)
//            addDiaryView.contentView.addSubviews(
//                addDiaryView.emojiLabel,
//                addDiaryView.dateLabel,
//                addDiaryView.categoryButton,
//                addDiaryView.categoryLabel,
//                addDiaryView.todoLabel,
//                addDiaryView.todoTextView,
//                addDiaryView.thankfulLabel,
//                addDiaryView.thankfulTextView,
//                addDiaryView.bestLabel,
//                addDiaryView.bestTextView,
//                addDiaryView.saveButton
//            )
//            
//            addDiaryView.snp.makeConstraints {
//                $0.edges.equalToSuperview()
//            }
//
//            addDiaryView.emojiLabel.snp.makeConstraints {
//                $0.top.equalToSuperview()
//                $0.centerX.equalToSuperview()
//            }
//            
//            addDiaryView.dateLabel.snp.makeConstraints {
//                $0.top.equalTo(addDiaryView.emojiLabel.snp.bottom).offset(40)
//                $0.leading.trailing.equalToSuperview().inset(30)
//            }
//            
//            addDiaryView.categoryButton.snp.makeConstraints {
//                $0.top.equalTo(self.addDiaryView.emojiLabel.snp.bottom).offset(30)
//                $0.centerY.equalTo(self.addDiaryView.dateLabel.snp.centerY)
//                $0.trailing.equalToSuperview().offset(-30)
//                $0.width.equalTo(150)
//                $0.height.equalTo(50)
//            }
//            
//            addDiaryView.categoryLabel.snp.makeConstraints {
//                $0.top.equalTo(addDiaryView.dateLabel.snp.bottom).offset(50)
//                $0.leading.trailing.equalToSuperview().inset(30)
//            }
//            
//            addDiaryView.todoLabel.snp.makeConstraints {
//                $0.top.equalTo(addDiaryView.categoryLabel.snp.bottom).offset(10)
//                $0.leading.trailing.equalToSuperview().inset(30)
//            }
//            
//            addDiaryView.todoTextView.snp.makeConstraints {
//                $0.top.equalTo(addDiaryView.todoLabel.snp.bottom).offset(20)
//                $0.centerX.equalToSuperview().inset(30)
//                $0.width.equalTo(350)
//                $0.height.equalTo(300)
//            }
//            
//            addDiaryView.thankfulLabel.snp.makeConstraints {
//                $0.top.equalTo(addDiaryView.todoTextView.snp.bottom).offset(50)
//                $0.leading.trailing.equalToSuperview().inset(30)
//            }
//            
//            addDiaryView.thankfulTextView.snp.makeConstraints {
//                $0.top.equalTo(addDiaryView.thankfulLabel.snp.bottom).offset(20)
//                $0.centerX.equalToSuperview().inset(30)
//                $0.width.equalTo(350)
//                $0.height.equalTo(200)
//            }
//            
//            addDiaryView.bestLabel.snp.makeConstraints {
//                $0.top.equalTo(addDiaryView.thankfulTextView.snp.bottom).offset(50)
//                $0.leading.trailing.equalToSuperview().inset(30)
//            }
//            
//            addDiaryView.bestTextView.snp.makeConstraints {
//                $0.top.equalTo(addDiaryView.bestLabel.snp.bottom).offset(20)
//                $0.centerX.equalToSuperview().inset(30)
//                $0.width.equalTo(350)
//                $0.height.equalTo(200)
//            }
//
//            addDiaryView.saveButton.snp.makeConstraints {
//                $0.top.equalTo(addDiaryView.bestTextView.snp.bottom).offset(100)
//                $0.centerX.equalToSuperview()
//                $0.size.equalTo(CGSize(width: 350, height: 50))
//            }
//            
//            addDiaryView.contentView.snp.makeConstraints {
//                $0.edges.equalTo(addDiaryView.scrollView)
//                $0.width.equalTo(addDiaryView.scrollView)
//                $0.bottom.equalTo(addDiaryView.saveButton.snp.bottom).offset(50)
//            }
//            
//            addDiaryView.scrollView.snp.makeConstraints {
//                $0.edges.equalToSuperview()
//            }
//        }
//       else {
//            addDiaryView.addSubview(addDiaryView.scrollView)
//            addDiaryView.scrollView.addSubview(addDiaryView.contentView)
//            addDiaryView.contentView.addSubviews(
//                addDiaryView.emojiLabel,
//                addDiaryView.dateLabel,
//                addDiaryView.categoryButton,
//                addDiaryView.categoryLabel,
//                addDiaryView.todoLabel,
//                addDiaryView.todoTextView,
//                addDiaryView.thankfulLabel,
//                addDiaryView.thankfulTextView,
//                addDiaryView.bestLabel,
//                addDiaryView.bestTextView,
//                addDiaryView.saveButton
//            )
//            
//            addDiaryView.snp.makeConstraints {
//                $0.edges.equalToSuperview()
//            }
//            
//            addDiaryView.emojiLabel.snp.makeConstraints {
//                $0.top.equalToSuperview()
//                $0.centerX.equalToSuperview()
//            }
//            
//            addDiaryView.dateLabel.snp.makeConstraints {
//                $0.top.equalTo(self.addDiaryView.emojiLabel.snp.bottom).offset(40)
//                $0.leading.equalToSuperview().inset(30)
//                $0.trailing.lessThanOrEqualToSuperview().offset(-30)
//            }
//            
//            addDiaryView.thankfulLabel.snp.makeConstraints {
//                $0.top.equalTo(self.addDiaryView.dateLabel.snp.bottom).offset(50)
//                $0.leading.equalToSuperview().inset(30)
//                $0.trailing.lessThanOrEqualToSuperview().offset(-30)
//            }
//            
//            addDiaryView.thankfulTextView.snp.makeConstraints {
//                $0.top.equalTo(self.addDiaryView.thankfulLabel.snp.bottom).offset(20)
//                $0.centerX.equalToSuperview()
//                $0.width.equalTo(350)
//                $0.height.equalTo(200)
//            }
//            
//            addDiaryView.bestLabel.snp.makeConstraints {
//                $0.top.equalTo(self.addDiaryView.thankfulTextView.snp.bottom).offset(50)
//                $0.leading.equalToSuperview().inset(30)
//                $0.trailing.lessThanOrEqualToSuperview().offset(-30)
//            }
//            
//            addDiaryView.bestTextView.snp.makeConstraints {
//                $0.top.equalTo(self.addDiaryView.bestLabel.snp.bottom).offset(20)
//                $0.centerX.equalToSuperview()
//                $0.width.equalTo(350)
//                $0.height.equalTo(200)
//            }
//            
//            addDiaryView.saveButton.snp.makeConstraints {
//                $0.top.equalTo(self.addDiaryView.bestTextView.snp.bottom).offset(100)
//                $0.centerX.equalToSuperview()
//                $0.size.equalTo(CGSize(width: 350, height: 50))
//            }
//            
//            addDiaryView.contentView.snp.makeConstraints {
//                $0.edges.equalTo(addDiaryView.scrollView)
//                $0.width.equalTo(addDiaryView.scrollView)
//                $0.bottom.equalTo(addDiaryView.saveButton.snp.bottom).offset(50)
//            }
//            
//            addDiaryView.scrollView.snp.makeConstraints {
//                $0.edges.equalTo(view.safeAreaLayoutGuide)
//            }
//        }
    }

    
    override func setAddTarget() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(emojiLabelTapped))
        addDiaryView.emojiLabel.addGestureRecognizer(tapGesture)
        
        addDiaryView.categoryButton.addTarget(self, action: #selector(categoryButtonTapped), for: .touchUpInside)
        
        addDiaryView.saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
    }
    
    func addEmoji() {
        NetworkService.shared.emojiService.postEmoji(request: PostEmojiRequestModel(createAt: addDiaryView.dateLabel.text ?? "", todayEmoji: addDiaryView.emojiLabel.text ?? "")) { result in
            switch result {
            case .success(let EmojiResponseDTO):
                print(EmojiResponseDTO)
                DispatchQueue.main.async {
                    self.addDiaryView.dateLabel.text = EmojiResponseDTO.data.createAt
                    self.addDiaryView.emojiLabel.text = EmojiResponseDTO.data.todayEmoji
                }
            case .tokenExpired(_):
                print("만료된 accessToken 입니다. \n재발급을 시도합니다.")
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
    
    func addReview() {
        NetworkService.shared.reviewService.postReview(request: PostReviewRequestModel(createAt: addDiaryView.dateLabel.text ?? "2024-06-19", categoryId: 41, content: addDiaryView.dateLabel.text ?? "")) { result in
            switch result {
            case .success(let ReviewResponseDTO):
                print(ReviewResponseDTO)
                DispatchQueue.main.async {
                    self.addDiaryView.todoTextView.text = ReviewResponseDTO.data.content
                    self.addDiaryView.thankfulLabel.text = ReviewResponseDTO.data.content
                    self.addDiaryView.bestTextView.text = ReviewResponseDTO.data.content
                }
            case .tokenExpired(_):
                print("만료된 accessToken 입니다. \n재발급을 시도합니다.")
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
    
    func sendReview(requestModel: PostReviewRequestModel) {
        NetworkService.shared.reviewService.postReview(request: requestModel) { result in
            switch result {
            case .success(let response):
                print("PostReview 성공: \(response)")
            case .tokenExpired(_):
                print("만료된 accessToken 입니다. \n재발급을 시도합니다.")
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
    
    func updateTodo() {
        guard let createAt = addDiaryView.dateLabel.text else { return }
        print("getTodo 호출됨, createAt: \(createAt)")
        NetworkService.shared.todoService.getTodo(createAt: createAt) { result in
            switch result {
            case .success(let TodosResponseDTO):
                print("🥵🥵🥵🥵🥵🥵")
                print(TodosResponseDTO)
                DispatchQueue.main.async {
                    // 각 TodoDateResDto의 content 배열을 꺼내와서 하나의 문자열로 조인
                    let allContents = TodosResponseDTO.data.todoDateResDtos.flatMap { $0.content }.joined(separator: ", ")
                    self.addDiaryView.todoLabel.text = allContents
                    
                    // 각 카테고리 이름을 데이터 소스로 사용
//                    self.dropDown.dataSource = TodosResponseDTO.data.todoDateResDtos.map { $0.categoryName }
                   self.dropDown.dataSource = ["운동하기", "공부하기"]
                    self.dropdowncount = self.dropDown.dataSource.count
                    print("🤩🤩🤩🤩🤩🤩🤩🤩🤩 : \(self.dropdowncount)")
                    
                    // 카테고리 이름과 그에 해당하는 콘텐츠를 딕셔너리로 만듦
//                    self.categoryTodos = Dictionary(uniqueKeysWithValues: TodosResponseDTO.data.todoDateResDtos.map { ($0.categoryName, $0.content.joined(separator: ", ")) })
                    
                    self.setupDropDown()
                    print("😗😗😗😗😗")
                    print(self.categoryTag)
                    
                    self.setLayout()
                }
            case .tokenExpired(_):
                print("만료된 accessToken 입니다. \n재발급을 시도합니다.")
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
    
    
    func setUpDelegates() {
        addDiaryView.todoTextView.delegate = self
        addDiaryView.thankfulTextView.delegate = self
        addDiaryView.bestTextView.delegate = self
    }
    
    func setUpClosures() {
        addDiaryView.emojiPickerHandler = { [weak self] in
            self?.PresentEmojiPicker()
        }
        
        let _: (UIAction) -> Void = { [weak self] action in
            self?.addDiaryView.categoryLabel.text = action.title
        }
    }
    
    @objc func categoryButtonTapped() {
        dropDown.show()
    }
    
   func setupDropDown() {
       dropDown.anchorView = addDiaryView.categoryButton
       dropDown.bottomOffset = CGPoint(x: 0, y: addDiaryView.categoryButton.bounds.height + 10)
//        dropDown.dataSource = [Array(categoryTodos.keys)]
      let str1 = UserDefaults.standard.string(forKey: "category1Name")
      let str2 = UserDefaults.standard.string(forKey: "category2Name")
      dropDown.dataSource = [str1 ?? "", str2 ?? ""]
       dropDown.backgroundColor = .white
       
       dropDown.textFont = UIFont.pretendard(size: 18, weight: .regular)
       
       if let firstCategory = dropDown.dataSource.first {
          addDiaryView.categoryButton.setTitle(firstCategory, for: .normal)
          addDiaryView.categoryLabel.text = firstCategory
          addDiaryView.todoLabel.text = categoryTodos[firstCategory] ?? ""
          addDiaryView.todoTextView.text = ""
       }
       
       var beforecategorylabel = self.addDiaryView.categoryLabel.text
       
       dropDown.selectionAction = { [weak self] (index: Int, item: String) in
           self?.addDiaryView.categoryButton.setTitle(item, for: .normal)
           self?.addDiaryView.categoryLabel.text = item
           self?.addDiaryView.todoLabel.text = self?.categoryTodos[item] ?? ""
           self?.addDiaryView.todoTextView.text = ""
           
           print("현재 item: \(item)")
           print("현재 self?.diaryView.categoryLabel.text: \(self?.addDiaryView.categoryLabel.text)")
           if item != beforecategorylabel {
               self?.categoryTag.toggle()
               beforecategorylabel = item
           }
           
           if self?.dropDown.dataSource.count ?? 0 > 0 && item == self?.dropDown.dataSource[0] && self?.postReviewGoal1Content != "" {
               self?.addDiaryView.todoTextView.text = self?.postReviewGoal1Content
           } else if self?.dropDown.dataSource.count ?? 0 > 1 && item == self?.dropDown.dataSource[1] && self?.postReviewGoal2Content != "" {
               self?.addDiaryView.todoTextView.text = self?.postReviewGoal2Content
           }
       }
   }
    
    @objc func saveButtonTapped() {
        print("save")
        
        if addDiaryView.emojiLabel.text == addDiaryViewInitialEmoji {
            print("Cannot save because emoji has not changed.")
            return
        }
        
        addEmoji()
       let category1ID = UserDefaults.standard.integer(forKey: "category1ID")
       let category2ID = UserDefaults.standard.integer(forKey: "category2ID")
       let thanksID = UserDefaults.standard.integer(forKey: "감사한 일")
       let todayGoodID = UserDefaults.standard.integer(forKey: "가장 좋았던 일")
       
       UserDefaults.standard.set(postReviewGoal1Content, forKey: "목표1 내용")
       UserDefaults.standard.set(postReviewGoal2Content, forKey: "목표2 내용")
       UserDefaults.standard.set(postReviewThankfulContent, forKey: "감사한 일 내용")
       UserDefaults.standard.set(postReviewBestContent, forKey: "가장 좋았던 일 내용")
       
        let goal1RequestModel = PostReviewRequestModel(createAt: "2024-06-19", categoryId: category1ID, content: postReviewGoal1Content)
        let goal2RequestModel = PostReviewRequestModel(createAt: "2024-06-19", categoryId: category2ID, content: postReviewGoal2Content)
        let thankfulRequestModel = PostReviewRequestModel(createAt: "2024-06-19", categoryId: thanksID, content: postReviewThankfulContent)
        let bestRequestModel = PostReviewRequestModel(createAt: "2024-06-19", categoryId: todayGoodID, content: postReviewBestContent)
        
        print("🥳")
        print("dropdowncount: \(dropdowncount)")
        
        if dropdowncount == 0 {
            sendReview(requestModel: thankfulRequestModel)
            sendReview(requestModel: bestRequestModel)
        } else if dropdowncount == 1 {
            sendReview(requestModel: goal1RequestModel)
            sendReview(requestModel: thankfulRequestModel)
            sendReview(requestModel: bestRequestModel)
        }else {
            sendReview(requestModel: goal1RequestModel)
            sendReview(requestModel: goal2RequestModel)
            sendReview(requestModel: thankfulRequestModel)
            sendReview(requestModel: bestRequestModel)
        }
       
       showAlert(title: "일기 등록 성공", message: "일기를 성공적으로 등록하였습니다!", confirmButtonName: "확인", confirmButtonCompletion: {
          let mainVC = MainViewController()
          mainVC.newEmoji = self.addDiaryView.emojiLabel.text ?? ""
          self.closure?()
          self.navigationController?.popViewController(animated: true)
       })
    }
}

extension AddDiaryViewController: ElegantEmojiPickerDelegate {
    func PresentEmojiPicker() {
        let picker = ElegantEmojiPicker(delegate: self)
        self.present(picker, animated: true)
    }
    
    func emojiPicker(_ picker: ElegantEmojiPicker, didSelectEmoji emoji: Emoji?) {
        guard let emoji = emoji else { return }
        addDiaryView.emojiLabel.text = emoji.emoji
    }
    
    @objc func emojiLabelTapped() {
        addDiaryView.emojiPickerHandler?()
    }
}

extension AddDiaryViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        print("텍스트 필드 편집 시작")
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        print("🤪")
        
        if textView == addDiaryView.todoTextView {
            if categoryTag == true {
                postReviewGoal1Content = addDiaryView.todoTextView.text
                print("goal1content에 저장된 텍스트: \(self.postReviewGoal1Content)")
            } else if categoryTag == false {
                postReviewGoal2Content = addDiaryView.todoTextView.text
                print("goal2content에 저장된 텍스트: \(self.postReviewGoal2Content)")
            }
        }
        
        if textView == addDiaryView.thankfulTextView {
            postReviewThankfulContent = addDiaryView.thankfulTextView.text
            print("postReviewThankfulContent에 저장된 텍스트: \(self.postReviewThankfulContent)")
        }
        
        if textView == addDiaryView.bestTextView {
            postReviewBestContent = addDiaryView.bestTextView.text
        }
    }
}
