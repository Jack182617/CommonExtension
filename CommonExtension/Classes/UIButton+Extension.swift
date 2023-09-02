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
        self.init(type: .custom)
        setImage(image, for: .normal)
    }

    enum Textposition: Int{
        case TOP
        case LEFT
        case BOTTOM
        case RIGHT
    }

    // Set the relative position of button text and image
    func setTextAndImagePosition(textPosition: Textposition, space: CGFloat) {
        let imageSize = self.imageRect(forContentRect: self.frame)
        let titleFont = self.titleLabel?.font!
        let titleSize = (self.titleLabel?.text! as NSString?)?.size(withAttributes: [NSAttributedString.Key.font : titleFont ?? UIFont.systemFont(ofSize: 16)])

        var titleInsets: UIEdgeInsets
        var imageInsets: UIEdgeInsets

        switch (textPosition){
        case .TOP:
            titleInsets = UIEdgeInsets(top: -(imageSize.height + titleSize!.height + space),
                                       left: -(imageSize.width), bottom: 0, right: 0)
            imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -titleSize!.width)
        case .BOTTOM:
            titleInsets = UIEdgeInsets(top: imageSize.height + space / 2,
                                       left: -imageSize.width, bottom: 0, right: 0)
            imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: titleSize!.height + space / 2, right: -titleSize!.width)
        case .LEFT:
            titleInsets = UIEdgeInsets(top: 0, left: -(imageSize.width * 2), bottom: 0, right: 0)
            imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0,
                                       right: -(titleSize!.width * 2 + space))
        case .RIGHT:
            titleInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -space)
            imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }

        self.titleEdgeInsets = titleInsets
        self.imageEdgeInsets = imageInsets
    }
}
