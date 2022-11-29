//
//  UITextView+Extension.swift
//  CommonExtension
//
//  Created by 袁杰 on 2022-11-29.
//

import Foundation
import UIKit

public extension UITextView{
    convenience init(contentFont: UIFont? = .systemFont(ofSize: 16), contentColor: UIColor? = .black, textAlignment: NSTextAlignment? = .left, contentString: String? = "") {
        self.init()
        self.font = contentFont
        self.textColor = contentColor
        self.textAlignment = textAlignment!
        self.text = contentString!
    }
}
