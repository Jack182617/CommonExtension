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
    
    ///
    func setAttributedText(_ text: String, font: UIFont, color: UIColor, lineSpacing: CGFloat = 0, alignment: NSTextAlignment = .left) {
        let attributedString = NSMutableAttributedString(string: text, attributes: [
            .font: font,
            .foregroundColor: color
        ])
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        paragraphStyle.alignment = alignment
        
        attributedString.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedString.length))
        
        self.attributedText = attributedString
    }
    
    /// Set rich text, support SF Symbols icon insertion
    /// - Parameters:
    /// - textBefore: text before the icon
    /// - sfSymbolName: name of SF Symbols
    /// - textAfter: text after the icon
    /// - font: text font
    /// - color: text color
    /// - symbolSize: size of SF Symbols (default 16x16)
    /// - offsetY: Y-axis offset of the icon (default -2, adapt to text baseline)
    @available(iOS 13.0, *)
    func setAttributedTextWithSymbol(textBefore: String, sfSymbolName: String, textAfter: String, font: UIFont, color: UIColor, symbolSize: CGSize = CGSize(width: 16, height: 16), offsetY: CGFloat = -2, lineSpacing: CGFloat = 0, alignment: NSTextAlignment = .left) {
        
        let attributedString = NSMutableAttributedString(string: textBefore + " ", attributes: [
            .font: font,
            .foregroundColor: color
        ])
        
        // Create SF Symbols images and convert them to NSTextAttachment
        let symbolAttachment = NSTextAttachment()
        if let image = UIImage(systemName: sfSymbolName)?.withTintColor(color, renderingMode: .alwaysOriginal) {
            symbolAttachment.image = image
            symbolAttachment.bounds = CGRect(x: 0, y: offsetY, width: symbolSize.width, height: symbolSize.height)
        }
        
        // Convert NSTextAttachment to NSAttributedString and concatenate
        let symbolString = NSAttributedString(attachment: symbolAttachment)
        attributedString.append(symbolString)
        
        //
        attributedString.append(NSAttributedString(string: " " + textAfter, attributes: [
            .font: font,
            .foregroundColor: color
        ]))
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        paragraphStyle.alignment = alignment
        
        attributedString.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedString.length))
        
        self.attributedText = attributedString
    }
    
    func setImageText(image: UIImage?, text: String, imageFirst: Bool = true, spacing: CGFloat = 4) {
        let attachment = NSTextAttachment()
        attachment.image = image
        let imageString = NSAttributedString(attachment: attachment)
        let textString = NSAttributedString(string: " \(text)")
        
        let result = NSMutableAttributedString()
        if imageFirst {
            result.append(imageString)
            result.append(NSAttributedString(string: String(repeating: " ", count: Int(spacing))))
            result.append(textString)
        } else {
            result.append(textString)
            result.append(NSAttributedString(string: String(repeating: " ", count: Int(spacing))))
            result.append(imageString)
        }
        self.attributedText = result
    }
}
