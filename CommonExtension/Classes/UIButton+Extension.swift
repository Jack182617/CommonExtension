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

    enum TextPosition {
        case top
        case left
        case bottom
        case right
    }

    // Set the relative position of button text and image
    func setTextAndImagePosition(textPosition: TextPosition, space: CGFloat) {
        guard let titleLabel = self.titleLabel, let imageView = self.imageView else { return }
            
            let imageSize = imageView.frame.size
            let titleFont = titleLabel.font ?? UIFont.systemFont(ofSize: 16)
            let titleSize = (titleLabel.text as NSString?)?.size(withAttributes: [NSAttributedString.Key.font: titleFont]) ?? CGSize.zero
            
            var titleInsets: UIEdgeInsets = .zero
        var imageInsets: UIEdgeInsets

        switch textPosition {
        case .top:
            titleInsets = UIEdgeInsets(top: -(imageSize.height + titleSize.height + space),
                                       left: -(imageSize.width), bottom: 0, right: 0)
            imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -titleSize.width)
        case .bottom:
            titleInsets = UIEdgeInsets(top: imageSize.height + space / 2,
                                       left: -imageSize.width, bottom: 0, right: 0)
            imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: titleSize.height + space / 2, right: -titleSize.width)
        case .left:
            titleInsets = UIEdgeInsets(top: 0, left: -(imageSize.width + space / 2), bottom: 0, right: imageSize.width + space / 2)
            imageInsets = UIEdgeInsets(top: 0, left: titleSize.width + space / 2, bottom: 0, right: -(titleSize.width + space / 2))
        case .right:
            titleInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -space)
            imageInsets = UIEdgeInsets(top: 0, left: -space, bottom: 0, right: 0)
        }

        self.titleEdgeInsets = titleInsets
        self.imageEdgeInsets = imageInsets
    }
}
