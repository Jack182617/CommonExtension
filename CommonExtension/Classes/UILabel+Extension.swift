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
    
    /// 设置富文本（带字体、颜色、行距、对齐方式）
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
    
    /// 设置富文本，支持 SF Symbols 图标插入
    /// - Parameters:
    ///   - textBefore: 图标前的文本
    ///   - sfSymbolName: SF Symbols 的名称
    ///   - textAfter: 图标后的文本
    ///   - font: 文字字体
    ///   - color: 文字颜色
    ///   - symbolSize: SF Symbols 的大小（默认 16x16）
    ///   - offsetY: 图标的 Y 轴偏移量（默认 -2，适配文字基线）
    @available(iOS 13.0, *)
    func setAttributedTextWithSymbol(textBefore: String, sfSymbolName: String, textAfter: String, font: UIFont, color: UIColor, symbolSize: CGSize = CGSize(width: 16, height: 16), offsetY: CGFloat = -2, lineSpacing: CGFloat = 0, alignment: NSTextAlignment = .left) {
        
        let attributedString = NSMutableAttributedString(string: textBefore + " ", attributes: [
            .font: font,
            .foregroundColor: color
        ])
        
        // 创建 SF Symbols 图片并转换为 NSTextAttachment
        let symbolAttachment = NSTextAttachment()
        if let image = UIImage(systemName: sfSymbolName)?.withTintColor(color, renderingMode: .alwaysOriginal) {
            symbolAttachment.image = image
            symbolAttachment.bounds = CGRect(x: 0, y: offsetY, width: symbolSize.width, height: symbolSize.height)
        }
        
        // 把 NSTextAttachment 转换为 NSAttributedString 并拼接
        let symbolString = NSAttributedString(attachment: symbolAttachment)
        attributedString.append(symbolString)
        
        // 添加后续文本
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
