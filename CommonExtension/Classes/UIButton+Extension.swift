//
//  UIButton+Extension.swift
//
//
//  Created by Jack on 2022/11/16.
//

import Foundation
import UIKit

public extension UIButton {
    convenience init(title: String = "",
                     titleFont: UIFont = UIFont.systemFont(ofSize: 16),
                     titleColor: UIColor? = .clear,
                     image: UIImage? = nil,
                     backgroundImage: UIImage? = nil) {
        self.init(type: .custom)
        titleLabel?.font = titleFont
        setTitle(title, for: .normal)
        setTitleColor(titleColor, for: .normal)
        setImage(image, for: .normal)
        setBackgroundImage(backgroundImage, for: .normal)
        setBackgroundImage(backgroundImage, for: .highlighted)
    }
    
    convenience init(image: UIImage) {
        self.init(title: "", image: image)
    }
}
