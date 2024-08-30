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
    
    var lineSpacing: CGFloat {
        get {
            guard let attributedText = attributedText, attributedText.length > 0 else { return 0 }
            let paragraphStyle = attributedText.attribute(.paragraphStyle, at: 0, effectiveRange: nil) as? NSMutableParagraphStyle
            return paragraphStyle?.lineSpacing ?? 0
        }
        set {
            guard let labelText = text else { return }
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = newValue
            paragraphStyle.alignment = textAlignment
            
            let attributedString = NSMutableAttributedString(string: labelText)
            attributedString.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedString.length))
            
            self.attributedText = attributedString
        }
    }
}
