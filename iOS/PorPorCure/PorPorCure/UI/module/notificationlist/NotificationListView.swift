//
//  NotificationListView.swift
//  PorPorCure
//
//  Created by Jupond on 12/31/24.
//

import UIKit

class NotificationListView: UIView, UITableViewDelegate, UITableViewDataSource {
    
    private let tableView: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.register(NotificationCell.self, forCellReuseIdentifier: "NotificationCell")
        view.backgroundColor = UIColor(named: "mainColour")

        // 구분선 완전히 제거
        view.separatorStyle = .none
        view.separatorInset = .zero
        view.separatorColor = .clear
        view.showsVerticalScrollIndicator = false  // 스크롤바도 숨기고 싶다면
        
        view.rowHeight = UITableView.automaticDimension
        return view
    }()
    
    private var mList: [NotificationModel] = [] {
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
    
    func setList(_ list: [NotificationModel]) {
        self.mList = list
    }
    
    private func setupTableView() {
        
        // Set background color for the NotificationListView itself
        backgroundColor = UIColor(named: "mainColour")
        
        addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        // Ensure cells are transparent to show the NotificationListView's background
        tableView.backgroundColor = .clear
        
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationCell", for: indexPath) as? NotificationCell else {
            return UITableViewCell()
        }
        
        // Make sure the cell's background is clear/transparent
        cell.backgroundColor = .clear
        cell.contentView.backgroundColor = .clear
        
        // Remove cell selection style
        cell.selectionStyle = .none
        
        let model = mList[indexPath.row]
        cell.setNotificationModel(model: model)
        return cell
    }
    
   
}

