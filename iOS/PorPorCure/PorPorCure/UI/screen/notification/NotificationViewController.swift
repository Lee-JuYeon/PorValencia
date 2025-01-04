//
//  NotificationViewController.swift
//  PorPorCure
//
//  Created by Jupond on 12/23/24.
//

import Foundation
import UIKit

class NotificationViewController: UIViewController {
    
    private let contactTextView: UILabel = {
        let view = UILabel()
        view.text = "Contact"
        view.font = UIFont.systemFont(ofSize: 40, weight: .bold)
        view.textAlignment = .left
        view.textColor = UIColor(named: "colour_text")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let socialListView : SocialListView = {
        let view = SocialListView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let notificationTitle: UILabel = {
        let view = UILabel()
        view.text = "Notification"
        view.font = UIFont.systemFont(ofSize: 40, weight: .bold)
        view.textAlignment = .left
        view.textColor = UIColor(named: "colour_text")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let notificationView : NotificationListView = {
        let view = NotificationListView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        setNotificationVM()
    }
    
    private func setView() {
        view.backgroundColor = UIColor(named: "mainColour")
        
        // 뷰 추가 및 레이아웃 설정
        view.addSubview(contactTextView)
        view.addSubview(socialListView)
        view.addSubview(notificationTitle)
        view.addSubview(notificationView)
        
        NSLayoutConstraint.activate([
            contactTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16), // 왼쪽 여백 추가
            contactTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16), // 오른쪽 여백 추가
            contactTextView.topAnchor.constraint(equalTo: view.topAnchor, constant: 16), // 상단 여백 추가
            contactTextView.heightAnchor.constraint(equalToConstant: 50), // 높이 고정
            
            socialListView.leadingAnchor.constraint(equalTo: view.leadingAnchor), //
            socialListView.trailingAnchor.constraint(equalTo: view.trailingAnchor), //
            socialListView.topAnchor.constraint(equalTo: contactTextView.bottomAnchor), //
            socialListView.heightAnchor.constraint(equalToConstant: 200), //
            
            notificationTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16), // 왼쪽 여백 추가
            notificationTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16), // 오른쪽 여백 추가
            notificationTitle.topAnchor.constraint(equalTo: socialListView.bottomAnchor, constant: 16), // 상단 여백 추가
            notificationTitle.heightAnchor.constraint(equalToConstant: 50), // 높이 고정
            
            notificationView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            notificationView.topAnchor.constraint(equalTo: notificationTitle.bottomAnchor, constant: 0),
            notificationView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            notificationView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
        
        
        socialListView.setList([
            ("email", "redpond2@naver.com"),
            ("insta", "@por_valencia_"),
            ("x", "@por_valencia_")
        ])
      
    }
    
    private func setNotificationVM(){
        // ViewController에서
        let repository = NotificationRepository()
        let vm = NotificationVMFactory.createViewModel(repository: repository)

        if #available(iOS 13.0, *) {
            // iOS 13 이상에서 Combine 사용시
            if let combineVM = vm as? CombineNotificationVM {
                combineVM.$list
                    .sink { list in
                        self.notificationView.setList(list)
                    }
                    .store(in: &combineVM.cancellables)
            }
        } else {
            // iOS 13 미만에서 RxSwift 사용시
            if let rxVM = vm as? RxNotificationVM {
                rxVM.listObservable
                    .subscribe(onNext: { list in
                        // UI 업데이트
                        self.notificationView.setList(list)
                    })
                    .disposed(by: rxVM.disposeBag)
            }
        }
    }
}
