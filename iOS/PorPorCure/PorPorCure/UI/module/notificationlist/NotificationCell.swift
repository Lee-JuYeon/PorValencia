//
//  NotificationCell.swift
//  PorPorCure
//
//  Created by Jupond on 12/31/24.
//

import UIKit

class NotificationCell: UITableViewCell {

    private let title: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 20)
        view.numberOfLines = 0
        view.textColor = UIColor(named: "colour_text")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let content: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 20)
        view.numberOfLines = 0
        view.textColor = UIColor(named: "colour_text")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let date: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 20)
        view.numberOfLines = 0
        view.textColor = UIColor(named: "colour_text")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
   
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }

    private var getModel: NotificationModel?
    func setNotificationModel(model : NotificationModel) {
        self.getModel = model
        updateView()
    }

    private func setupViews() {
        contentView.addSubview(title)
        contentView.addSubview(content)
        contentView.addSubview(date)

        NSLayoutConstraint.activate([
            // Title Constraints
            title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            title.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            title.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            
            // Content Constraints
            content.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            content.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            content.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 8),

            // Date Constraints
            date.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            date.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            date.topAnchor.constraint(equalTo: content.bottomAnchor, constant: 8),
            date.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8) // 마지막 여백 추가
        ])
    }
    
    private func updateView() {
        guard let model = getModel else { return } // 모델이 없는 경우 아무것도 하지 않음
        
        title.text = model.title
        content.text = model.text
        
        // 현재 날짜를 String으로 변환하여 UILabel에 표시
        let dateString = formatDateToString(date: model.date)
        date.text = "📅 \(dateString)"
       
    }
    
    // Date -> String 변환 메서드
    private func formatDateToString(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd" // 원하는 형식 지정
        return formatter.string(from: date)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // 선택 배경색 제거
        self.selectionStyle = .none
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = .clear
        contentView.backgroundColor = .clear
    }
}
 

