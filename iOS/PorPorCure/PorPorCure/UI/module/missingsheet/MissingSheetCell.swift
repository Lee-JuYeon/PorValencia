//
//  MissingSheetCell.swift
//  PorPorCure
//
//  Created by Jupond on 1/2/25.
//

import UIKit

class MissingSheetCell: UITableViewCell {
    
    private let title: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 18)
        view.numberOfLines = 0
        view.textAlignment = .left // 왼쪽 정렬
        view.textColor = UIColor(named: "colour_text")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let content: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 15)
        view.numberOfLines = 0
        view.textAlignment = .left // 왼쪽 정렬
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
    
    private var getTitle: String?
    private var getContent: String?
    func setData(title: String, content: String) {
        self.getTitle = title
        self.getContent = content
        updateView()
    }
    
    private func setupViews() {
        contentView.addSubview(title)
        contentView.addSubview(content)
        
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            title.widthAnchor.constraint(equalToConstant: 100),
            
            content.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            content.leadingAnchor.constraint(equalTo: title.trailingAnchor, constant: 8), // 기존 16 -> 8로 축소
            content.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
        ])
    }
    
    private func updateView() {
        guard let titleValue = getTitle else { return }
        guard let contentValue = getContent else { return }
        
        title.text = titleValue
        content.text = contentValue
    }
}
