//
//  MissingSheetView.swift
//  PorPorCure
//
//  Created by Jupond on 1/2/25.
//

import UIKit

class MissingSheetView : UIView {
  
    private let sheetView : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let grabberView : UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.layer.cornerRadius = 3
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let missingImage : UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit // 이미지 비율 유지
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let tableView : UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.register(MissingSheetCell.self, forCellReuseIdentifier: "MissingSheetCell")
        
        // 구분선 완전히 제거
        view.separatorStyle = .none
        view.separatorInset = .zero
        view.separatorColor = .clear
        view.showsVerticalScrollIndicator = false  // 스크롤바도 숨기고 싶다면
        
        view.rowHeight = UITableView.automaticDimension
        return view
    }()
    
    
    var dismissHandler: (() -> Void)? // Bottom Sheet 종료 핸들러
    
  
    private var mList: [(String, String)] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    
        
        addSubview(sheetView)
        
        sheetView.addSubview(grabberView)
        sheetView.addSubview(tableView)
        sheetView.addSubview(missingImage)
        
        NSLayoutConstraint.activate([
            sheetView.leadingAnchor.constraint(equalTo: leadingAnchor),
            sheetView.trailingAnchor.constraint(equalTo: trailingAnchor),
            sheetView.bottomAnchor.constraint(equalTo: bottomAnchor),
            sheetView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.7), // 화면 높이의 70%
            
            grabberView.topAnchor.constraint(equalTo: sheetView.topAnchor, constant: 8),
            grabberView.centerXAnchor.constraint(equalTo: sheetView.centerXAnchor),
            grabberView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 2.5),
            grabberView.heightAnchor.constraint(equalToConstant: 6),
            
            missingImage.leadingAnchor.constraint(equalTo: sheetView.leadingAnchor),
            missingImage.trailingAnchor.constraint(equalTo: sheetView.trailingAnchor),
            missingImage.topAnchor.constraint(equalTo: grabberView.bottomAnchor, constant: 8),
            missingImage.heightAnchor.constraint(equalToConstant: 200),
            
            tableView.leadingAnchor.constraint(equalTo: sheetView.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: sheetView.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: missingImage.bottomAnchor, constant: 8),
            tableView.bottomAnchor.constraint(equalTo: sheetView.bottomAnchor)
        ])
               
        
        // Bottom Sheet의 드래그 제스처 추가
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        sheetView.addGestureRecognizer(panGesture)

        // 배경 뷰 클릭을 감지하는 탭 제스처 추가
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapBackground))
        tapGesture.delegate = self // 델리게이트 설정
        self.addGestureRecognizer(tapGesture)

        self.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTableView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupTableView()
    }
}


extension MissingSheetView : UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate {
    
    func setMissingModel(model : MissingModel) {
        // 이미지 URL 비동기 로드
        if let url = URL(string: model.imageURL) {
            loadImage(from: url) { [weak self] image in
                DispatchQueue.main.async {
                    self?.missingImage.image = image
                }
            }
        }

        self.mList = [
            ("이름", "\(model.name)"),
            ("현재 상황", "\(MissingManager.shared.getMissingState(setType:model.missingState))"),
            ("실종 날짜", "\(MissingManager.shared.getDateByString(setDate: model.date))"),
            ("추정 위치", "\(model.zone)"),
            ("외관 특징", "\(model.character)")
        ]
    }
    
    @objc private func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: self)
        let velocity = gesture.velocity(in: self)
        
        switch gesture.state {
        case .changed:
            if translation.y > 0 { // 아래로만 이동
                sheetView.transform = CGAffineTransform(translationX: 0, y: translation.y)
            }
        case .ended:
            if translation.y > 150 || velocity.y > 1000 {
                dismissBottomSheet()
            } else {
                UIView.animate(withDuration: 0.3) {
                    self.sheetView.transform = .identity
                }
            }
        default:
            break
        }
    }
    
    // 이미지 다운로드 함수
    private func loadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let data = data,
                error == nil,
                let image = UIImage(data: data)
            else {
                completion(nil)
                return
            }
            completion(image)
        }
        task.resume()
    }
    
    func presentInKeyWindow() {
        guard let keyWindow = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) else { return }
        keyWindow.addSubview(self)
        
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: keyWindow.topAnchor),
            leadingAnchor.constraint(equalTo: keyWindow.leadingAnchor),
            trailingAnchor.constraint(equalTo: keyWindow.trailingAnchor),
            bottomAnchor.constraint(equalTo: keyWindow.bottomAnchor)
        ])
        
        // 등장 애니메이션
        sheetView.transform = CGAffineTransform(translationX: 0, y: 300)
        UIView.animate(withDuration: 0.3) {
            self.sheetView.transform = .identity
        }
    }
    
    // 배경 클릭 시 Bottom Sheet 닫기
    @objc private func handleTapBackground() {
        dismissBottomSheet()
    }
    
    private func dismissBottomSheet() {
        UIView.animate(withDuration: 0.3, animations: {
            self.sheetView.transform = CGAffineTransform(translationX: 0, y: 300)
            self.alpha = 0
        }) { _ in
            self.removeFromSuperview()
            self.dismissHandler?()
        }
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        // sheetView를 터치한 경우에는 제스처를 무시
        if touch.view === sheetView || touch.view?.isDescendant(of: sheetView) == true {
            return false
        }
        return true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MissingSheetCell", for: indexPath) as? MissingSheetCell else {
            return UITableViewCell()
        }
        let (key, value) = mList[indexPath.row]
        cell.setData(title: key, content: value)
        return cell
    }
}
