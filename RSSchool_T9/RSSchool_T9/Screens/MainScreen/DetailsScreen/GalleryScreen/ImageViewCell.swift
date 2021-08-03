//
// 📰 🐸 
// Project: RSSchool_T9
// 
// Author: Dzmitry Navitski
// On: 01.08.2021
// 
// Copyright © 2021 RSSchool. All rights reserved.

import UIKit

class ImageViewCell: UICollectionViewCell {
    
    private lazy var cellImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.layer.borderWidth = 1
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func prepate(with image: UIImage) {
        cellImage.image = image
        self.layer.cornerRadius = 8
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.white.cgColor
    }
    
    func setupSubviews() {
        self.addSubview(cellImage)
        
        NSLayoutConstraint.activate([
            cellImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            cellImage.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            cellImage.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
            cellImage.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10),
        ])
    }
}
