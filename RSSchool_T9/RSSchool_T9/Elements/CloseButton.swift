//
// 📰 🐸 
// Project: RSSchool_T9
// 
// Author: Dzmitry Navitski
// On: 29.07.2021
// 
// Copyright © 2021 RSSchool. All rights reserved.

import UIKit

class CloseButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.clear
        self.setImage(UIImage(systemName: "xmark"), for: .normal)
        self.tintColor = .white
    }
        
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        if let context = UIGraphicsGetCurrentContext() {
            context.setLineWidth(2.0);
            UIColor.white.set()
            
            let center = CGPoint(x: frame.size.width / 2, y: frame.size.height / 2)
            let radius = (frame.size.width - 4) / 2
            context.addArc(center: center, radius: radius, startAngle: 0.0, endAngle: .pi * 2.0, clockwise: true)
                
            context.strokePath()
        }
    }

}
