//
//  UIButton+Extension.swift
//  CarbonWorld
//
//  Created by 袁杰 on 2022/11/16.
//

import Foundation
import UIKit

extension UIButton {
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
        self.init(type: .custom)
        setImage(image, for: .normal)
    }
}
