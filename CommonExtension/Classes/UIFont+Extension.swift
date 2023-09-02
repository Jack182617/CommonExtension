//
//  UIFont+Extension.swift
//  
//
//  Created by Jack on 2022/9/30.
//

import Foundation

public extension UIFont {
    class func font(_ size: CGFloat) -> UIFont { .systemFont(ofSize: size) }
    class func regular(_ size: CGFloat) -> UIFont { .systemFont(ofSize: size, weight: .regular) }
    class func medium(_ size: CGFloat) -> UIFont { .systemFont(ofSize: size, weight: .medium) }
    class func semibold(_ size: CGFloat) -> UIFont { .systemFont(ofSize: size, weight: .semibold) }

    // PingFangSC
    class func pfMedium(_ size: CGFloat) -> UIFont {
        UIFont(name: "PingFangSC-Medium", size: size) ?? .font(size)
    }

    class func pfRegular(_ size: CGFloat) -> UIFont {
        UIFont(name: "PingFangSC-Regular", size: size) ?? .font(size)
    }

    class func pfLight(_ size: CGFloat) -> UIFont {
        UIFont(name: "PingFangSC-Light", size: size) ?? .font(size)
    }

    class func pfSemibold(_ size: CGFloat) -> UIFont {
        UIFont(name: "PingFangSC-Semibold", size: size) ?? .font(size)
    }

    // Arial
    class func arialMT(_ size: CGFloat) -> UIFont {
        UIFont(name: "ArialMT", size: size) ?? .font(size)
    }

    class func arialItalicMT(_ size: CGFloat) -> UIFont {
        UIFont(name: "Arial-ItalicMT", size: size) ?? .font(size)
    }

    class func arialBoldMT(_ size: CGFloat) -> UIFont {
        UIFont(name: "Arial-BoldMT", size: size) ?? .font(size)
    }

    class func arialBoldItalicMT(_ size: CGFloat) -> UIFont {
        UIFont(name: "Arial-BoldItalicMT", size: size) ?? .font(size)
    }
}
