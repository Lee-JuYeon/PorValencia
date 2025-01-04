//
//  ChipCell.swift
//  PorPorCure
//
//  Created by Jupond on 12/27/24.
//

import Foundation
import UIKit

class ChipCell: UICollectionViewCell {
    static let reuseIdentifier = "ChipCell"
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        layer.cornerRadius = 12
        layer.borderWidth = 1
        layer.borderColor = UIColor.lightGray.cgColor
        backgroundColor = .white
        
        addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
        ])
    }
    
    func configure(with chip: ChipModel) {
        titleLabel.text = chip.title
        updateSelectionStyle(isSelected: chip.isSelected)
    }
    
    private func updateSelectionStyle(isSelected: Bool) {
        if isSelected {
            backgroundColor = .systemBlue
            titleLabel.textColor = .white
            layer.borderColor = UIColor.systemBlue.cgColor
        } else {
            backgroundColor = .white
            titleLabel.textColor = .black
            layer.borderColor = UIColor.lightGray.cgColor
        }
    }
}
