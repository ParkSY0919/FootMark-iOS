//
//  DiaryViewController.swift
//  FootMark
//
//  Created by 윤성은 on 6/18/24.
//

import UIKit
import ElegantEmojiPicker
import DropDown

class DiaryViewController: BaseViewController {
    var diaryView = DiaryView()
    let dropDown = DropDown()
    
    var isEditingMode: Bool = false {
        didSet {
            updateViewMode()
        }
    }
    
    var postReviewGoal1Content: String = ""
    var postReviewGoal2Content: String = ""
    var postReviewThankfulContent: String = ""
    var postReviewBestContent: String = ""
    
    var categoryTodos: [String: String] = [:]
    
    var categoryTag: Bool = true
    var dropdowncount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(resource: .black1)
        
        diaryView.deleteButton.isHidden = false
        diaryView.editButton.isHidden = false
        diaryView.backButton.isHidden = true
        diaryView.saveButton.isHidden = true
        
        diaryView.todoTextView.isUserInteractionEnabled = false
        diaryView.thankfulTextView.isUserInteractionEnabled = false
        diaryView.bestTextView.isUserInteractionEnabled = false
        
        setUpDelegates()
        setUpClosures()
        
        diaryView.dateLabel.text = "2024-06-19"
        
        updateTodo()
       self.navigationController?.isNavigationBarHidden = false
       self.navigationController?.navigationBar.tintColor = .white
    }
    
    override func setLayout() {
        print("🥸🥸🥸🥸🥸🥸 : \(dropdowncount)")

        diaryView.subviews.forEach { $0.removeFromSuperview() }
        diaryView.snp.removeConstraints()
        diaryView.scrollView.subviews.forEach { $0.removeFromSuperview() }
        diaryView.scrollView.snp.removeConstraints()
        diaryView.contentView.subviews.forEach { $0.removeFromSuperview() }
        diaryView.contentView.snp.removeConstraints()

        // diaryView를 view에 추가
        if diaryView.superview == nil {
            view.addSubview(diaryView)
        }

        // dropdowncount에 따라 레이아웃 설정
//       if dropdowncount != 0 {
//        }
       
           // diaryView에 scrollView와 contentView 추가
           diaryView.addSubview(diaryView.scrollView)
           diaryView.scrollView.addSubview(diaryView.contentView)
           diaryView.contentView.addSubviews(
               diaryView.emojiLabel,
               diaryView.dateLabel,
               diaryView.categoryButton,
               diaryView.categoryLabel,
               diaryView.todoLabel,
               diaryView.todoTextView,
               diaryView.thankfulLabel,
               diaryView.thankfulTextView,
               diaryView.bestLabel,
               diaryView.bestTextView,
               diaryView.deleteButton,
               diaryView.editButton,
               diaryView.backButton,
               diaryView.saveButton
           )
           
           // constraints 설정
           diaryView.snp.makeConstraints {
               $0.edges.equalToSuperview()
           }

           diaryView.emojiLabel.snp.makeConstraints {
               $0.top.equalToSuperview()
               $0.centerX.equalToSuperview()
           }
           
           diaryView.dateLabel.snp.makeConstraints {
               $0.top.equalTo(diaryView.emojiLabel.snp.bottom).offset(40)
               $0.leading.trailing.equalToSuperview().inset(30)
           }
           
           diaryView.categoryButton.snp.makeConstraints {
               $0.top.equalTo(self.diaryView.emojiLabel.snp.bottom).offset(30)
               $0.centerY.equalTo(self.diaryView.dateLabel.snp.centerY)
               $0.trailing.equalToSuperview().offset(-30)
               $0.width.equalTo(150)
               $0.height.equalTo(50)
           }
           
           diaryView.categoryLabel.snp.makeConstraints {
               $0.top.equalTo(diaryView.dateLabel.snp.bottom).offset(50)
               $0.leading.trailing.equalToSuperview().inset(30)
           }
           
           diaryView.todoLabel.snp.makeConstraints {
               $0.top.equalTo(diaryView.categoryLabel.snp.bottom).offset(10)
               $0.leading.trailing.equalToSuperview().inset(30)
           }
           
           diaryView.todoTextView.snp.makeConstraints {
               $0.top.equalTo(diaryView.todoLabel.snp.bottom).offset(20)
               $0.centerX.equalToSuperview().inset(30)
               $0.width.equalTo(350)
               $0.height.equalTo(300)
           }
           
           diaryView.thankfulLabel.snp.makeConstraints {
               $0.top.equalTo(diaryView.todoTextView.snp.bottom).offset(50)
               $0.leading.trailing.equalToSuperview().inset(30)
           }
           
           diaryView.thankfulTextView.snp.makeConstraints {
               $0.top.equalTo(diaryView.thankfulLabel.snp.bottom).offset(20)
               $0.centerX.equalToSuperview().inset(30)
               $0.width.equalTo(350)
               $0.height.equalTo(200)
           }
           
           diaryView.bestLabel.snp.makeConstraints {
               $0.top.equalTo(diaryView.thankfulTextView.snp.bottom).offset(50)
               $0.leading.trailing.equalToSuperview().inset(30)
           }
           
           diaryView.bestTextView.snp.makeConstraints {
               $0.top.equalTo(diaryView.bestLabel.snp.bottom).offset(20)
               $0.centerX.equalToSuperview().inset(30)
               $0.width.equalTo(350)
               $0.height.equalTo(200)
           }
           
           diaryView.deleteButton.snp.makeConstraints {
               $0.top.equalToSuperview().offset(10)
               $0.leading.equalTo(diaryView.emojiLabel.snp.trailing).offset(50)
               $0.size.equalTo(CGSize(width: 40, height: 40))
           }
           
           diaryView.editButton.snp.makeConstraints {
               $0.top.equalToSuperview().offset(10)
               $0.leading.equalTo(diaryView.deleteButton.snp.trailing).offset(20)
               $0.size.equalTo(CGSize(width: 40, height: 40))
           }
           
           diaryView.backButton.snp.makeConstraints {
               $0.top.equalToSuperview().offset(10)
               $0.leading.equalToSuperview().offset(20)
               $0.size.equalTo(CGSize(width: 44, height: 44))
           }
           
           diaryView.saveButton.snp.makeConstraints {
               $0.top.equalTo(diaryView.bestTextView.snp.bottom).offset(100)
               $0.centerX.equalToSuperview()
               $0.size.equalTo(CGSize(width: 350, height: 50))
           }
           
           diaryView.contentView.snp.makeConstraints {
               $0.edges.equalTo(diaryView.scrollView)
               $0.width.equalTo(diaryView.scrollView)
               $0.bottom.equalTo(diaryView.saveButton.snp.bottom).offset(50)
           }
           
           diaryView.scrollView.snp.makeConstraints {
               $0.edges.equalToSuperview()
           }
       
//       else {
//            diaryView.addSubview(diaryView.scrollView)
//            diaryView.scrollView.addSubview(diaryView.contentView)
//            diaryView.contentView.addSubviews(
//                diaryView.emojiLabel,
//                diaryView.dateLabel,
//                diaryView.thankfulLabel,
//                diaryView.thankfulTextView,
//                diaryView.bestLabel,
//                diaryView.bestTextView,
//                diaryView.deleteButton,
//                diaryView.editButton,
//                diaryView.backButton,
//                diaryView.saveButton
//            )
//            
//            diaryView.snp.makeConstraints {
//                $0.edges.equalToSuperview()
//            }
//            
//            diaryView.emojiLabel.snp.makeConstraints {
//                $0.top.equalToSuperview()
//                $0.centerX.equalToSuperview()
//            }
//            
//            diaryView.dateLabel.snp.makeConstraints {
//                $0.top.equalTo(diaryView.emojiLabel.snp.bottom).offset(40)
//                $0.leading.trailing.equalToSuperview().inset(30)
//            }
//            
//            diaryView.thankfulLabel.snp.makeConstraints {
//                $0.top.equalTo(diaryView.dateLabel.snp.bottom).offset(50)
//                $0.leading.trailing.equalToSuperview().inset(30)
//            }
//            
//            diaryView.thankfulTextView.snp.makeConstraints {
//                $0.top.equalTo(diaryView.thankfulLabel.snp.bottom).offset(20)
//                $0.centerX.equalToSuperview()
//                $0.width.equalTo(350)
//                $0.height.equalTo(200)
//            }
//            
//            diaryView.bestLabel.snp.makeConstraints {
//                $0.top.equalTo(diaryView.thankfulTextView.snp.bottom).offset(50)
//                $0.leading.trailing.equalToSuperview().inset(30)
//            }
//            
//            diaryView.bestTextView.snp.makeConstraints {
//                $0.top.equalTo(diaryView.bestLabel.snp.bottom).offset(20)
//                $0.centerX.equalToSuperview()
//                $0.width.equalTo(350)
//                $0.height.equalTo(200)
//            }
//            
//            diaryView.deleteButton.snp.makeConstraints {
//                $0.top.equalToSuperview().offset(10)
//                $0.leading.equalTo(diaryView.emojiLabel.snp.trailing).offset(50)
//                $0.size.equalTo(CGSize(width: 40, height: 40))
//            }
//            
//            diaryView.editButton.snp.makeConstraints {
//                $0.top.equalToSuperview().offset(10)
//                $0.leading.equalTo(diaryView.deleteButton.snp.trailing).offset(10)
//                $0.size.equalTo(CGSize(width: 40, height: 40))
//            }
//            
//            diaryView.backButton.snp.makeConstraints {
//                $0.top.equalToSuperview().offset(10)
//                $0.leading.equalToSuperview().offset(20)
//                $0.size.equalTo(CGSize(width: 44, height: 44))
//            }
//            
//            diaryView.saveButton.snp.makeConstraints {
//                $0.top.equalTo(diaryView.bestTextView.snp.bottom).offset(100)
//                $0.centerX.equalToSuperview()
//                $0.size.equalTo(CGSize(width: 350, height: 50))
//            }
//            
//            diaryView.contentView.snp.makeConstraints {
//                $0.edges.equalTo(diaryView.scrollView)
//                $0.width.equalTo(diaryView.scrollView)
//                $0.bottom.equalTo(diaryView.saveButton.snp.bottom).offset(50)
//            }
//            
//            diaryView.scrollView.snp.makeConstraints {
//                $0.edges.equalTo(view.safeAreaLayoutGuide)
//            }
//        }
    }
    
    override func setAddTarget() {
        diaryView.categoryButton.addTarget(self, action: #selector(categoryButtonTapped), for: .touchUpInside)
        
        diaryView.deleteButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
        diaryView.editButton.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
        diaryView.backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        diaryView.saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        
        updateViewMode()
    }
    
    func editEmoji(createAt: String) {
        NetworkService.shared.emojiService.putEmoji(createAt: createAt, request: PutEmojiRequestModel(todayEmoji: diaryView.emojiLabel.text ?? "")) { result in
            switch result {
            case .success(let EmojiResponseDTO):
                print("EmojiResponseDTO:", EmojiResponseDTO)
                DispatchQueue.main.async {
                    self.diaryView.emojiLabel.text = EmojiResponseDTO.data.todayEmoji
                    print("Updated emoji label:", self.diaryView.emojiLabel.text ?? "nil")
                    // 추가적인 로그를 통해 업데이트 여부 확인
                    if self.diaryView.emojiLabel.text == EmojiResponseDTO.data.todayEmoji {
                        print("이모지 라벨이 성공적으로 업데이트되었습니다.")
                    } else {
                        print("이모지 라벨 업데이트에 실패했습니다.")
                    }
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
    
    func editReview(reviewId: Int) {
        NetworkService.shared.reviewService.putReview(reviewId: reviewId, request: PutReviewRequestModel(content: "")) { result in
            switch result {
            case .success(let ReviewResponseDTO):
                print(ReviewResponseDTO)
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
    
    func deleteReview(reviewId: Int) {
        NetworkService.shared.reviewService.delReview(reviewId: reviewId) { result in
            switch result {
            case .success(let ReviewResponseDTO):
                print(ReviewResponseDTO)
                DispatchQueue.main.async {
                    self.handleReviewDeletionSuccess()
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
    
    func sendReview(requestModel: PutReviewRequestModel) {
        NetworkService.shared.reviewService.delReview(reviewId: 0) { result in
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
        guard let createAt = diaryView.dateLabel.text else { return }
        print("getTodo 호출됨, createAt: \(createAt)")
        NetworkService.shared.todoService.getTodo(createAt: createAt) { result in
            switch result {
            case .success(let TodosResponseDTO):
                print("🥵🥵🥵🥵🥵🥵")
                print(TodosResponseDTO)
                DispatchQueue.main.async {
                    let allContents = TodosResponseDTO.data.todoDateResDtos.flatMap { $0.content }.joined(separator: ", ")
                    self.diaryView.todoLabel.text = allContents
                    
                    self.dropDown.dataSource = TodosResponseDTO.data.todoDateResDtos.map { $0.categoryName }
                    self.dropdowncount = self.dropDown.dataSource.count
                    print("🤩🤩🤩🤩🤩🤩🤩🤩🤩 : \(self.dropdowncount)")
                    
                    self.categoryTodos = Dictionary(uniqueKeysWithValues: TodosResponseDTO.data.todoDateResDtos.map { ($0.categoryName, $0.content.joined(separator: ", ")) })
                    
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
        diaryView.todoTextView.delegate = self
        diaryView.thankfulTextView.delegate = self
        diaryView.bestTextView.delegate = self
    }
    
    func setUpClosures() {
        diaryView.emojiPickerHandler = { [weak self] in
            self?.PresentEmojiPicker()
        }
        
        let _: (UIAction) -> Void = { [weak self] action in
            self?.diaryView.categoryLabel.text = action.title
        }
    }
    
    @objc func categoryButtonTapped() {
        dropDown.show()
    }
    
    func setupDropDown() {
        dropDown.anchorView = diaryView.categoryButton
        dropDown.bottomOffset = CGPoint(x: 0, y: diaryView.categoryButton.bounds.height + 10)
//        dropDown.dataSource = [Array(categoryTodos.keys)]
       let str1 = UserDefaults.standard.string(forKey: "category1Name")
       let str2 = UserDefaults.standard.string(forKey: "category2Name")
       dropDown.dataSource = [str1 ?? "", str2 ?? ""]
        dropDown.backgroundColor = .white
        
        dropDown.textFont = UIFont.pretendard(size: 18, weight: .regular)
        
        if let firstCategory = dropDown.dataSource.first {
            diaryView.categoryButton.setTitle(firstCategory, for: .normal)
            diaryView.categoryLabel.text = firstCategory
            diaryView.todoLabel.text = categoryTodos[firstCategory] ?? ""
            diaryView.todoTextView.text = "오늘 하루 달리기로 부족한 유산소를 채웠다."
        }
        
        var beforecategorylabel = self.diaryView.categoryLabel.text
        
        dropDown.selectionAction = { [weak self] (index: Int, item: String) in
            self?.diaryView.categoryButton.setTitle(item, for: .normal)
            self?.diaryView.categoryLabel.text = item
            self?.diaryView.todoLabel.text = self?.categoryTodos[item] ?? ""
            self?.diaryView.todoTextView.text = ""
           
           if index == 0 {
              self?.diaryView.todoTextView.text = "오늘 하루 달리기로 부족한 유산소를 채웠다."
           } else {
              self?.diaryView.todoTextView.text = "Swift 공부와 알고리즘 문제를 풀이하였다."
           }
            
            print("현재 item: \(item)")
            print("현재 self?.diaryView.categoryLabel.text: \(self?.diaryView.categoryLabel.text)")
            if item != beforecategorylabel {
                self?.categoryTag.toggle()
                beforecategorylabel = item
            }
            
            if self?.dropDown.dataSource.count ?? 0 > 0 && item == self?.dropDown.dataSource[0] && self?.postReviewGoal1Content != "" {
                self?.diaryView.todoTextView.text = self?.postReviewGoal1Content
            } else if self?.dropDown.dataSource.count ?? 0 > 1 && item == self?.dropDown.dataSource[1] && self?.postReviewGoal2Content != "" {
                self?.diaryView.todoTextView.text = self?.postReviewGoal2Content
            }
        }
    }

    
    private func updateViewMode() {
        if isEditingMode {
            if diaryView.emojiLabel.gestureRecognizers?.isEmpty ?? true {
                let tapGesture = UITapGestureRecognizer(target: self, action: #selector(emojiLabelTapped))
                diaryView.emojiLabel.addGestureRecognizer(tapGesture)
                diaryView.emojiLabel.isUserInteractionEnabled = true
            }
        } else {
            if let gestureRecognizers = diaryView.emojiLabel.gestureRecognizers {
                for recognizer in gestureRecognizers {
                    diaryView.emojiLabel.removeGestureRecognizer(recognizer)
                }
                diaryView.emojiLabel.isUserInteractionEnabled = false
            }
        }
        
        diaryView.todoTextView.isUserInteractionEnabled = isEditingMode
        diaryView.thankfulTextView.isUserInteractionEnabled = isEditingMode
        diaryView.bestTextView.isUserInteractionEnabled = isEditingMode
        
        diaryView.backButton.isHidden = !isEditingMode
        diaryView.saveButton.isHidden = !isEditingMode
        diaryView.editButton.isHidden = isEditingMode
        diaryView.deleteButton.isHidden = isEditingMode
        
        diaryView.todoTextView.isEditable = isEditingMode
        diaryView.thankfulTextView.isEditable = isEditingMode
        diaryView.bestTextView.isEditable = isEditingMode
        
        if isEditingMode {
            diaryView.todoTextView.becomeFirstResponder()
            diaryView.thankfulTextView.becomeFirstResponder()
            diaryView.bestTextView.becomeFirstResponder()
        } else {
            diaryView.todoTextView.resignFirstResponder()
            diaryView.thankfulTextView.resignFirstResponder()
            diaryView.bestTextView.resignFirstResponder()
        }
    }
    
    @objc func deleteButtonTapped() {
        let alertController = UIAlertController(title: "삭제 확인", message: "정말 삭제할까요?", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        let deleteAction = UIAlertAction(title: "삭제", style: .destructive) { _ in
            self.deleteReview(reviewId: 11)
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(deleteAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    func handleReviewDeletionSuccess() {
        print("리뷰가 성공적으로 삭제되었습니다.")
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func editButtonTapped() {
        isEditingMode.toggle()
        editEmoji(createAt: "2024-06-14")
    }
    
    @objc func saveButtonTapped() {
       print("save")
       print("Current emoji before editEmoji:", diaryView.emojiLabel.text ?? "nil")
       editEmoji(createAt: "2024-06-15")
       
       let goal1RequestModel = PutReviewRequestModel(content: postReviewGoal1Content)
       let goal2RequestModel = PutReviewRequestModel(content: postReviewGoal2Content)
       let thankfulRequestModel = PutReviewRequestModel(content: postReviewThankfulContent)
       let bestRequestModel = PutReviewRequestModel(content: postReviewBestContent)
       
       if dropdowncount == 0 {
           sendReview(requestModel: goal1RequestModel)
           sendReview(requestModel: thankfulRequestModel)
           sendReview(requestModel: bestRequestModel)
       } else if dropdowncount == 1 {
           sendReview(requestModel: goal1RequestModel)
           sendReview(requestModel: thankfulRequestModel)
           sendReview(requestModel: bestRequestModel)
       } else {
           sendReview(requestModel: goal1RequestModel)
           sendReview(requestModel: goal2RequestModel)
           sendReview(requestModel: thankfulRequestModel)
           sendReview(requestModel: bestRequestModel)
       }
       
       isEditingMode = false
       diaryView.scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
   }

    
    @objc private func backButtonTapped() {
        print("back")
        isEditingMode = false
        self.dismiss(animated: true, completion: nil)
    }
}

extension DiaryViewController: ElegantEmojiPickerDelegate {
    func PresentEmojiPicker() {
        let picker = ElegantEmojiPicker(delegate: self)
        self.present(picker, animated: true)
    }
    
    func emojiPicker(_ picker: ElegantEmojiPicker, didSelectEmoji emoji: Emoji?) {
        guard let emoji = emoji else { return }
        diaryView.emojiLabel.text = emoji.emoji
    }
    
    @objc func emojiLabelTapped() {
        diaryView.emojiPickerHandler?()
    }
}

extension DiaryViewController: UITextViewDelegate {
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
        
        if textView == diaryView.todoTextView {
            if categoryTag == true {
                postReviewGoal1Content = diaryView.todoTextView.text
                print("goal1content에 저장된 텍스트: \(self.postReviewGoal1Content)")
            } else if categoryTag == false {
                postReviewGoal2Content = diaryView.todoTextView.text
                print("goal2content에 저장된 텍스트: \(self.postReviewGoal2Content)")
            }
        }
        
        if textView == diaryView.thankfulTextView {
            postReviewThankfulContent = diaryView.thankfulTextView.text
            print("postReviewThankfulContent에 저장된 텍스트: \(self.postReviewThankfulContent)")
        }
        
        if textView == diaryView.bestTextView {
            postReviewBestContent = diaryView.bestTextView.text
        }
    }
}
