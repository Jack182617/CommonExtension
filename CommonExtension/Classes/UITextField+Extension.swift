//
//  UITextField+Extension.swift
//  CommonExtension
//
//  Created by 袁杰 on 2022-11-29.
//

import Foundation
import UIKit

public extension UITextField{
    convenience init(titleFont: UIFont? = .systemFont(ofSize: 16), titleColor: UIColor? = .black, titleString: String? = "", placeFont: UIFont? = .systemFont(ofSize: 16), placeColor: UIColor? = .gray, placeString: String? = "", textAlignment: NSTextAlignment? = .left) {
        self.init()
        self.font = titleFont
        self.textColor = titleColor
        self.attributedPlaceholder = NSAttributedString.init(string: placeString!, attributes: [.foregroundColor: placeColor!, .font: placeFont!])
    }
}
