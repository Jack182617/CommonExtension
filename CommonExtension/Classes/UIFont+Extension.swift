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
    class func pfscUltralight(_ size: CGFloat) -> UIFont {
        UIFont(name: "PingFangSC-Ultralight", size: size) ?? .ultraLight(size)
    }
    
    class func pfscThin(_ size: CGFloat) -> UIFont {
        UIFont(name: "PingFangSC-Thin", size: size) ?? .thin(size)
    }
    
    class func pfscLight(_ size: CGFloat) -> UIFont {
        UIFont(name: "PingFangSC-Light", size: size) ?? .light(size)
    }
    
    class func pfscRegular(_ size: CGFloat) -> UIFont {
        UIFont(name: "PingFangSC-Regular", size: size) ?? .regular(size)
    }
    
    class func pfscMedium(_ size: CGFloat) -> UIFont {
        UIFont(name: "PingFangSC-Medium", size: size) ?? .medium(size)
    }
    
    class func pfscSemibold(_ size: CGFloat) -> UIFont {
        UIFont(name: "PingFangSC-Semibold", size: size) ?? .semibold(size)
    }
    
    class func pfscBold(_ size: CGFloat) -> UIFont {
        UIFont(name: "PingFangSC-Bold", size: size) ?? .bold(size)
    }
    
    class func pfscHeavy(_ size: CGFloat) -> UIFont {
        UIFont(name: "PingFangSC-Heavy", size: size) ?? .heavy(size)
    }
    
    class func pfscBlack(_ size: CGFloat) -> UIFont {
        UIFont(name: "PingFangSC-Black", size: size) ?? .black(size)
    }
    
    
    // PingFangHK
    class func pfhkUltralight(_ size: CGFloat) -> UIFont {
        UIFont(name: "PingFangHK-Ultralight", size: size) ?? .ultraLight(size)
    }
    
    class func pfhkThin(_ size: CGFloat) -> UIFont {
        UIFont(name: "PingFangHK-Thin", size: size) ?? .thin(size)
    }
    
    class func pfhkLight(_ size: CGFloat) -> UIFont {
        UIFont(name: "PingFangHK-Light", size: size) ?? .light(size)
    }
    
    class func pfhkRegular(_ size: CGFloat) -> UIFont {
        UIFont(name: "PingFangHK-Regular", size: size) ?? .regular(size)
    }
    
    class func pfhkMedium(_ size: CGFloat) -> UIFont {
        UIFont(name: "PingFangHK-Medium", size: size) ?? .medium(size)
    }
    
    class func pfhkSemibold(_ size: CGFloat) -> UIFont {
        UIFont(name: "PingFangHK-Semibold", size: size) ?? .semibold(size)
    }
    
    class func pfhkBold(_ size: CGFloat) -> UIFont {
        UIFont(name: "PingFangHK-Bold", size: size) ?? .bold(size)
    }
    
    class func pfhkHeavy(_ size: CGFloat) -> UIFont {
        UIFont(name: "PingFangHK-Heavy", size: size) ?? .heavy(size)
    }
    
    class func pfhkBlack(_ size: CGFloat) -> UIFont {
        UIFont(name: "PingFangHK-Black", size: size) ?? .black(size)
    }
    
    
    // PingFangTC
    class func pftcUltralight(_ size: CGFloat) -> UIFont {
        UIFont(name: "PingFangTC-Ultralight", size: size) ?? .ultraLight(size)
    }
    
    class func pftcThin(_ size: CGFloat) -> UIFont {
        UIFont(name: "PingFangTC-Thin", size: size) ?? .thin(size)
    }
    
    class func pftcLight(_ size: CGFloat) -> UIFont {
        UIFont(name: "PingFangTC-Light", size: size) ?? .light(size)
    }
    
    class func pftcRegular(_ size: CGFloat) -> UIFont {
        UIFont(name: "PingFangTC-Regular", size: size) ?? .regular(size)
    }
    
    class func pftcMedium(_ size: CGFloat) -> UIFont {
        UIFont(name: "PingFangTC-Medium", size: size) ?? .medium(size)
    }
    
    class func pftcSemibold(_ size: CGFloat) -> UIFont {
        UIFont(name: "PingFangTC-Semibold", size: size) ?? .semibold(size)
    }
    
    class func pftcBold(_ size: CGFloat) -> UIFont {
        UIFont(name: "PingFangTC-Bold", size: size) ?? .bold(size)
    }
    
    class func pftcHeavy(_ size: CGFloat) -> UIFont {
        UIFont(name: "PingFangTC-Heavy", size: size) ?? .heavy(size)
    }
    
    class func pftcBlack(_ size: CGFloat) -> UIFont {
        UIFont(name: "PingFangTC-Black", size: size) ?? .black(size)
    }
    
}
