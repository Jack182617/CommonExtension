//
//  UIColor+Extension.swift
//
//
//  Created by Jack on 2022/9/27.
//

import Foundation

// MARK: - UIColor
// Provide color generation through hex/hex strings
public extension UIColor {
    convenience init(hexString: String, alpha: CGFloat = 1.0) {
        var hexString = hexString.hasPrefix("#") ? String(hexString.dropFirst()) : hexString
        guard hexString.count == 3 || hexString.count == 6 else {
            self.init(white: 1, alpha: 0)
            return
        }
        
        if hexString.count == 3 {
            for (index, char) in hexString.enumerated() {
                hexString.insert(char, at: hexString.index(hexString.startIndex, offsetBy: index * 2))
            }
        }
        
        guard let intCode = Int(hexString, radix: 16) else {
            self.init(white: 1, alpha: 0)
            return
        }
        self.init(hex: intCode, alpha: alpha)
    }
    
    convenience init(hex: Int, alpha: CGFloat = 1.0) {
        self.init(redValue: CGFloat((hex >> 16) & 0xFF),
                  greenValue: CGFloat((hex >> 8) & 0xFF),
                  blueValue: CGFloat((hex) & 0xFF), alpha: alpha)
    }
    
    convenience init(redValue: CGFloat, greenValue: CGFloat, blueValue: CGFloat, alpha: CGFloat = 1.0) {
        self.init(red: redValue / 255.0, green: greenValue / 255.0, blue: blueValue / 255.0, alpha: alpha)
    }
    
    // Provide random color generation through hex/hex strings
    class var randomColor: UIColor {
        let r = CGFloat(arc4random() % 255) / 255.0
        let g = CGFloat(arc4random() % 255) / 255.0
        let b = CGFloat(arc4random() % 255) / 255.0
        return UIColor(red: r, green: g, blue: b, alpha: 1.0)
    }
    
}
