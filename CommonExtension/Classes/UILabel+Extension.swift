//
//  UILabel+Extension.swift
//  
//
//  Created by Jack on 2022/11/16.
//

import Foundation
import UIKit

public extension UILabel {
    convenience init(font: UIFont, color: UIColor, alignment: NSTextAlignment, titleString: String = "") {
        self.init()
        self.font = font
        text = titleString
        textColor = color
        textAlignment = alignment
    }
}
