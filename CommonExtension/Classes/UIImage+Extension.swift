//
//  UIImage+Extension.swift
//  
//
//  Created by Jack on 2022/9/30.
//

import Foundation

public extension UIImage{
    static func image(with color: UIColor, width: CGFloat = 1, height: CGFloat = 1) -> UIImage? {
        let rect = CGRect(x: 0, y: 0, width: width, height: height)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}
