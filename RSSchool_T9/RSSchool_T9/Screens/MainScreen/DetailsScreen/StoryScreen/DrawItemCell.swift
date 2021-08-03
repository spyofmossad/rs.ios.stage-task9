//
// 📰 🐸 
// Project: RSSchool_T9
// 
// Author: Dzmitry Navitski
// On: 29.07.2021
// 
// Copyright © 2021 RSSchool. All rights reserved.

import UIKit

class DrawItemCell: UICollectionViewCell {
    
    private var shapeLayer: CAShapeLayer!
            
    func prepare(with path: CGPath, settings: StoriesSettings) {
        shapeLayer = CAShapeLayer()
        shapeLayer.path = path
        shapeLayer.frame = self.bounds
        shapeLayer.strokeColor = settings.drawColor.cgColor
        shapeLayer.lineWidth = 1
        
        if settings.isAnimated {
            let animation = CABasicAnimation(keyPath: "strokeEnd")
            animation.duration = 3
            animation.fromValue = 0
            animation.toValue = 1
            shapeLayer.add(animation, forKey: "animatePath")
        }
        
        self.layer.addSublayer(shapeLayer)
    }
    
    func clean() {
        shapeLayer.removeFromSuperlayer()
    }
}
