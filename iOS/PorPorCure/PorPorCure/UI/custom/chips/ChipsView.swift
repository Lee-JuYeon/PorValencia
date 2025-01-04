//
//  ChipsView.swift
//  PorPorCure
//
//  Created by Jupond on 12/27/24.
//

import Foundation
import UIKit

class ChipsView: UIView, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    private var collectionView: UICollectionView!
    private var chips: [ChipModel] = [] // 초기값을 빈 배열로 설정
    
    // 클릭 이벤트를 외부에서 처리하기 위한 클로저
    var onChipSelected: ((ChipModel) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // chips를 외부에서 설정할 수 있는 메서드 추가
    func setChips(_ chips: [ChipModel]) {
        self.chips = chips
        collectionView.reloadData() // chips가 업데이트되면 컬렉션 뷰를 리로드
    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 8
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(ChipCell.self, forCellWithReuseIdentifier: ChipCell.reuseIdentifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    // MARK: - UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return chips.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ChipCell.reuseIdentifier, for: indexPath) as! ChipCell
        cell.configure(with: chips[indexPath.item])
        return cell
    }
    
    // MARK: - UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // 클릭된 chip의 isSelected 값을 토글
        chips[indexPath.item].isSelected.toggle()
        
        // 클로저를 통해 외부에 클릭 이벤트 전달
        let selectedChip = chips[indexPath.item]
        onChipSelected?(selectedChip)
        
        // 클릭된 아이템만 업데이트
        collectionView.reloadItems(at: [indexPath])
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let chip = chips[indexPath.item]
        let titleSize = chip.title.size(withAttributes: [.font: UIFont.systemFont(ofSize: 14, weight: .medium)])
        return CGSize(width: titleSize.width + 24, height: 40)
    }
}
