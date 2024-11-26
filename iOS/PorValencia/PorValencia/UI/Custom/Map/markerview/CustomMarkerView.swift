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

    init(annotation: MarkerAnnotation?, reuseIdentifier: String?, model: MarkerModel) {
        self.model = model
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        let imageSize: CGFloat = 30
        let paddingSize: CGFloat = 3

        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: imageSize + (paddingSize * 2), height: imageSize + (paddingSize * 2)))
        containerView.backgroundColor = .green
        containerView.layer.cornerRadius = (imageSize + 6) / 2
        containerView.layer.masksToBounds = true
        containerView.layer.borderColor = UIColor.black.cgColor
        containerView.layer.borderWidth = 1

        let imageView = UIImageView(image: UIImage(named: "image_plogging"))
        imageView.frame = CGRect(x: paddingSize, y: paddingSize, width: imageSize, height: imageSize)
        imageView.layer.cornerRadius = imageSize / 2
        imageView.layer.masksToBounds = true
        containerView.addSubview(imageView)

        addSubview(containerView)

        let titleLabel = UILabel()
        titleLabel.text = model.title
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.systemFont(ofSize: 12)
        titleLabel.textColor = .black
        titleLabel.backgroundColor = .white
        titleLabel.sizeToFit()
        titleLabel.frame = CGRect(x: -(imageSize / 2), y: imageSize + (paddingSize * 2), width: titleLabel.frame.width + 10, height: titleLabel.frame.height + 5)

        addSubview(titleLabel)
        frame = CGRect(x: 0, y: 0, width: containerView.frame.width, height: imageSize + titleLabel.frame.height)
    }
}
