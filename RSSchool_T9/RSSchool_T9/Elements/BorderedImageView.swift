//
// 📰 🐸 
// Project: RSSchool_T9
// 
// Author: Dzmitry Navitski
// On: 30.07.2021
// 
// Copyright © 2021 RSSchool. All rights reserved.

import UIKit

class BorderedImageView: UIView {
    
    private lazy var tapGesture: UITapGestureRecognizer = {
        let singleTouch = UITapGestureRecognizer(target: self, action: #selector(imageOnTap))
        singleTouch.numberOfTapsRequired = 1
        singleTouch.numberOfTouchesRequired = 1
        return singleTouch
    }()
    
    public var touchCallback: ((Int) -> ())?
    public var innerImageView: UIImageView

    init(image: UIImage) {
        innerImageView = UIImageView(image: image)
        super.init(frame: CGRect.zero)
        
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.cornerRadius = 8
        self.translatesAutoresizingMaskIntoConstraints = false
        
        innerImageView.contentMode = .scaleAspectFill
        innerImageView.layer.cornerRadius = 4
        innerImageView.layer.masksToBounds = true
        innerImageView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(innerImageView)
        
        NSLayoutConstraint.activate([
            innerImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            innerImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
            innerImageView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10),
            innerImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
        ])
        
        self.addGestureRecognizer(tapGesture)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func imageOnTap(_ touch: UITapGestureRecognizer) {
        if touch.state == .ended, let index = touch.view?.tag {
            touchCallback?(index)
        }
    }
}
