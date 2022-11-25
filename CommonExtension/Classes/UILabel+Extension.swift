//
//  UILabel+Extension.swift
//  CarbonWorld
//
//  Created by 袁杰 on 2022/11/16.
//

import Foundation
import UIKit

extension UILabel {
    convenience init(font: UIFont, color: UIColor, alignment: NSTextAlignment, titleString: String = "") {
        self.init()
        self.font = font
        text = titleString
        textColor = color
        textAlignment = alignment
    }
}
