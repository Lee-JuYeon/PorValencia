//
//  SocialListView.swift
//  PorPorCure
//
//  Created by Jupond on 12/30/24.
//

import UIKit

class SocialListView: UIView, UITableViewDelegate, UITableViewDataSource {
    
    private let tableView: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.register(SocialCell.self, forCellReuseIdentifier: "SocialCell")
    
        view.backgroundColor = UIColor(named: "mainColour")

        // 구분선 완전히 제거
        view.separatorStyle = .none
        view.showsVerticalScrollIndicator = false  // 스크롤바도 숨기고 싶다면
        
        view.rowHeight = UITableView.automaticDimension
        return view
    }()
    
    private var mList: [(String, String)] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTableView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupTableView()
    }
    
    func setList(_ list: [(String, String)]) {
        self.mList = list
    }
    
    private func setupTableView() {
        addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SocialCell", for: indexPath) as? SocialCell else {
            return UITableViewCell()
        }
        let (key, value) = mList[indexPath.row]
        cell.setData(setIconAsset: key, setLabelString: value)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let (key, value) = mList[indexPath.row]
        switch key {
            case "email":
                if let encodedEmail = value.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
                    if let url = URL(string: "mailto:\(encodedEmail)") {
                        UIApplication.shared.open(url)
                    }
                }
            case "insta":
                var idChecker = value
               
                // 먼저 Instagram 앱으로 열기 시도
                if let instagramURL = URL(string: "instagram://user?username=\(idChecker)") {
                    if UIApplication.shared.canOpenURL(instagramURL) {
                        UIApplication.shared.open(instagramURL)
                    } else {
                        if idChecker.first == "@" {
                            idChecker.removeFirst()
                        }
                       
                        // Instagram 앱이 없으면 웹브라우저로 열기
                        if let webURL = URL(string: "https://www.instagram.com/\(idChecker)") {
                            UIApplication.shared.open(webURL)
                        }
                    }
                }
        case "x":
                // X(Twitter) 앱으로 열기 시도
                if let twitterURL = URL(string: "twitter://user?screen_name=\(value)") {
                    if UIApplication.shared.canOpenURL(twitterURL) {
                        UIApplication.shared.open(twitterURL)
                    } else {
                        // X 앱이 없으면 웹브라우저로 열기
                        if let webURL = URL(string: "https://x.com/\(value)") {
                            UIApplication.shared.open(webURL)
                        }
                    }
                }
            default :
                if let encodedEmail = value.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
                    if let url = URL(string: "mailto:\(encodedEmail)") {
                        UIApplication.shared.open(url)
                    }
                }
        }
    }
}
