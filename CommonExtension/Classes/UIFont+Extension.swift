//
//  UIFont+Extension.swift
//  
//
//  Created by Jack on 2022/9/30.
//

import Foundation

public extension UIFont {
    class func font(_ size: CGFloat) -> UIFont { .systemFont(ofSize: size) }
    
    class func ultraLight(_ size: CGFloat) -> UIFont { .systemFont(ofSize: size, weight: .ultraLight) }
    
    class func thin(_ size: CGFloat) -> UIFont { .systemFont(ofSize: size, weight: .thin) }
    
    class func light(_ size: CGFloat) -> UIFont { .systemFont(ofSize: size, weight: .light) }
    
    class func regular(_ size: CGFloat) -> UIFont { .systemFont(ofSize: size, weight: .regular) }
    
    class func medium(_ size: CGFloat) -> UIFont { .systemFont(ofSize: size, weight: .medium) }
    
    class func semibold(_ size: CGFloat) -> UIFont { .systemFont(ofSize: size, weight: .semibold) }
    
    class func bold(_ size: CGFloat) -> UIFont { .systemFont(ofSize: size, weight: .bold) }
    
    class func heavy(_ size: CGFloat) -> UIFont { .systemFont(ofSize: size, weight: .heavy) }
    
    class func black(_ size: CGFloat) -> UIFont { .systemFont(ofSize: size, weight: .black) }

    // PingFangSC
    class func pfUltralight(_ size: CGFloat) -> UIFont {
        UIFont(name: "PingFangSC-Ultralight", size: size) ?? .ultraLight(size)
    }
    
    class func pfThin(_ size: CGFloat) -> UIFont {
        UIFont(name: "PingFangSC-Thin", size: size) ?? .thin(size)
    }
    
    class func pfLight(_ size: CGFloat) -> UIFont {
        UIFont(name: "PingFangSC-Light", size: size) ?? .light(size)
    }
    
    class func pfRegular(_ size: CGFloat) -> UIFont {
        UIFont(name: "PingFangSC-Regular", size: size) ?? .regular(size)
    }
    
    class func pfMedium(_ size: CGFloat) -> UIFont {
        UIFont(name: "PingFangSC-Medium", size: size) ?? .medium(size)
    }

    class func pfSemibold(_ size: CGFloat) -> UIFont {
        UIFont(name: "PingFangSC-Semibold", size: size) ?? .semibold(size)
    }
    
    class func pfBold(_ size: CGFloat) -> UIFont {
        UIFont(name: "PingFangSC-Bold", size: size) ?? .bold(size)
    }
    
    class func pfHeavy(_ size: CGFloat) -> UIFont {
        UIFont(name: "PingFangSC-Heavy", size: size) ?? .heavy(size)
    }
    
    class func pfBlack(_ size: CGFloat) -> UIFont {
        UIFont(name: "PingFangSC-Black", size: size) ?? .black(size)
    }

}
