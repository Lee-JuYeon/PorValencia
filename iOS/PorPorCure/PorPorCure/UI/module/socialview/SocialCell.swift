//
//  SocialCell.swift
//  PorPorCure
//
//  Created by Jupond on 12/30/24.
//

import UIKit

class SocialCell: UITableViewCell {
        
    private let icon: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit // 이미지 비율 유지
        view.clipsToBounds = true
        view.tintColor = UIColor(named: "colour_icon")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let label: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 20)
        view.numberOfLines = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = UIColor(named: "colour_text")
        view.accessibilityLabel = "social media id text"
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

    private var iconAsset: String?
    private var labelString : String?
    func setData(setIconAsset getIconAsset : String, setLabelString getLabelString : String) {
        self.iconAsset = getIconAsset
        self.labelString = getLabelString
        updateView()
    }

    private func setupViews() {
                // 셀의 배경색을 clear로 설정
               contentView.backgroundColor = .clear
               backgroundColor = .clear

        
        contentView.addSubview(icon)
        contentView.addSubview(label)

        NSLayoutConstraint.activate([
            // 아이콘 제약 조건
            icon.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            icon.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            icon.widthAnchor.constraint(equalToConstant: 40), // 아이콘의 크기를 명시적으로 설정
            icon.heightAnchor.constraint(equalToConstant: 40),
            
            // 레이블 제약 조건
            label.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: 12), // 아이콘 오른쪽에 위치
            label.centerYAnchor.constraint(equalTo: icon.centerYAnchor), // 아이콘과 수직 중심 정렬
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            label.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -8) // 셀의 아래 여백 추가
        ])
    }
    
    private func updateView() {
        guard let iconAsset = iconAsset else { return } // 모델이 없는 경우 아무것도 하지 않음
        guard let labelString = labelString else { return } // 모델이 없는 경우 아무것도 하지 않음
        
        
        switch iconAsset {
            case "insta":
                icon.image = UIImage(named: "image_insta")?.withRenderingMode(.alwaysTemplate)
            case "email":
                icon.image = UIImage(named: "image_email")?.withRenderingMode(.alwaysTemplate)
            case "x":
                icon.image = UIImage(named: "image_x")?.withRenderingMode(.alwaysTemplate)
            default:
                icon.image = UIImage(named: "image_email")?.withRenderingMode(.alwaysTemplate)
        }
        label.text = "\(labelString)"

       
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // 선택 배경색 제거
        self.selectionStyle = .none
    }

}
 
