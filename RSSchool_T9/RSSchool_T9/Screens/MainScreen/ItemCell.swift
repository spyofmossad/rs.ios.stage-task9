//
// 📰 🐸 
// Project: RSSchool_T9
// 
// Author: Dzmitry Navitski
// On: 28.07.2021
// 
// Copyright © 2021 RSSchool. All rights reserved.

import UIKit

class ItemCell: UICollectionViewCell {
    
    private lazy var cellImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 12
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.layer.borderWidth = 1
        return imageView
    }()
    
    private lazy var shadowLayer: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.locations = [0.7, 0.9]
        gradient.colors = [UIColor.clear.cgColor, UIColor.black.cgColor, UIColor.black.cgColor]
        return gradient
    }()
    
    private lazy var title: GoodSizeLabel = {
        let label = GoodSizeLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Rockwell-Regular", size: 16)
        label.textColor = .white

        return label
    }()

    private lazy var subtitle: GoodSizeLabel = {
        let label = GoodSizeLabel()
        label.font = UIFont(name: "Rockwell-Regular", size: 12)
        label.textColor = UIColor(named: "TextGray")
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        shadowLayer.frame = cellImage.bounds
    }
    
    func prepare(with data: ContentType) {
        switch data {
        case .story(let story):
            cellImage.image = story.coverImage
            title.text = story.title
            subtitle.text = story.type
        case .gallery(let gallery):
            cellImage.image = gallery.coverImage
            title.text = gallery.title
            subtitle.text = gallery.type
        }
    }
    
    private func setupSubviews() {
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.cornerRadius = 18
        
        self.addSubview(cellImage)
        self.addSubview(title)
        self.addSubview(subtitle)
        
        NSLayoutConstraint.activate([
            cellImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            cellImage.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            cellImage.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8),
            cellImage.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -8),
            
            subtitle.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 18),
            subtitle.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -23),

            title.bottomAnchor.constraint(equalTo: subtitle.topAnchor, constant: -3),
            title.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 18),
            title.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -15)
        ])
        
        shadowLayer.frame = cellImage.bounds
        cellImage.layer.insertSublayer(shadowLayer, at: 0)
    }
}
