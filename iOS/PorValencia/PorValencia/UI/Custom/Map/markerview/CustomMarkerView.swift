//
//  CustomMarkerView.swift
//  PorValencia
//
//  Created by C.A.V.S.S on 11/14/24.
//

import SwiftUI
import MapKit

class CustomMarkerView: MKAnnotationView {

    var model: MarkerModel
    var tapAction: ((MarkerModel) -> Void) // Closure for handling tap events

    init(annotation: MarkerAnnotation?, reuseIdentifier: String?, model: MarkerModel, tapAction: @escaping ((MarkerModel) -> Void)) {
        self.model = model
        self.tapAction = tapAction
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        setupView()
        addTapGesture()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        let imageSize: CGFloat = 40
        let backgroundSize: CGFloat = imageSize + 10 // Add padding for the background

        // Create a container view for the background
        let backgroundView = UIView(frame: CGRect(x: 0, y: 0, width: backgroundSize, height: backgroundSize))
        backgroundView.backgroundColor = UIColor.systemGray // Use system color
        backgroundView.layer.cornerRadius = backgroundSize / 2 // Make it circular
        backgroundView.layer.masksToBounds = true // Clip the edges to the bounds
        backgroundView.layer.borderColor = UIColor.white.cgColor
        backgroundView.layer.borderWidth = 2

        // Center the background view
        backgroundView.center = CGPoint(x: backgroundSize / 2, y: backgroundSize / 2)
        addSubview(backgroundView)

        
      
        
        switch(model.image.starts(with: "http") || model.image.starts(with: "https")){
        case true :
            // Create the image view
            
            if let imageUrl = URL(string: model.image) {
                URLSession.shared.dataTask(with: imageUrl) { data, response, error in
                    guard let data = data, error == nil else {
                        print("이미지 다운로드 실패: \(error?.localizedDescription ?? "알 수 없는 오류")")
                        return
                    }
                    DispatchQueue.main.async {
                        guard let downloadedImage = UIImage(data: data) else {
                            print("이미지 생성 실패")
                            return
                        }
                        
                        let imageView = UIImageView(image: downloadedImage)
                        imageView.frame = CGRect(x: (backgroundSize - imageSize) / 2, y: (backgroundSize - imageSize) / 2, width: imageSize, height: imageSize)
                        imageView.layer.cornerRadius = imageSize / 2 // Make the image circular
                        imageView.layer.masksToBounds = true // Clip the image edges
                        imageView.tintColor = UIColor.systemGray6 // Apply tint color to image
                        backgroundView.addSubview(imageView) // 다운로드 후 추가
                    }
                }.resume()
            }
        case false :
            // Create the image view
            let imageView = UIImageView(image: UIImage(named: model.image)?.withRenderingMode(.alwaysTemplate))
            imageView.frame = CGRect(x: (backgroundSize - imageSize) / 2, y: (backgroundSize - imageSize) / 2, width: imageSize, height: imageSize)
            imageView.layer.cornerRadius = imageSize / 2 // Make the image circular
            imageView.layer.masksToBounds = true // Clip the image edges
            imageView.tintColor = UIColor.systemGray6 // Apply tint color to image
            
            // Add the imageView to the background
            backgroundView.addSubview(imageView)
        }

       

        // Set the frame for the marker view
        frame = CGRect(x: 0, y: 0, width: backgroundSize, height: backgroundSize)
    }

    private func addTapGesture() {
        // Add a tap gesture recognizer to handle click events
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        self.isUserInteractionEnabled = true // Enable user interaction
        self.addGestureRecognizer(tapGesture)
    }

    @objc private func handleTap() {
        tapAction(model) // Execute the tap action closure when tapped
    }
}
