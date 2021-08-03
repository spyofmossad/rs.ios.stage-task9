//
// 📰 🐸 
// Project: RSSchool_T9
// 
// Author: Dzmitry Navitski
// On: 29.07.2021
// 
// Copyright © 2021 RSSchool. All rights reserved.

import UIKit

class GoodSizeLabel: UILabel {
    
    override var intrinsicContentSize: CGSize {
        let newSize = CGSize(width: super.intrinsicContentSize.width, height: super.intrinsicContentSize.height + 5)
        invalidateIntrinsicContentSize()
        return newSize
    }

}
