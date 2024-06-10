//
//  MainContentViewController.swift
//  FootMark
//
//  Created by 윤성은 on 6/4/24.
//

import UIKit

class MainContentViewController: BaseViewController {

    var sidebarVC: SidebarViewController?
    var isSidebarPresented = false
    let dimmingView = UIView()

    let sidebarButton = UIButton().then {
        $0.setImage(UIImage(systemName: "sidebar.left"), for: .normal)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(resource: .black1)

        setupDimmingView()
    }

    override func setAddTarget() {
        sidebarButton.addTarget(self, action: #selector(sidebarButtonTapped), for: .touchUpInside)
    }

    override func setLayout() {
        self.view.addSubview(sidebarButton)

        sidebarButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(50)
            $0.leading.equalToSuperview().offset(30)
            $0.width.equalTo(100)
            $0.height.equalTo(100)
        }
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
}
