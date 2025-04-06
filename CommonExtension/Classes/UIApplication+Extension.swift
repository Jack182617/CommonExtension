//
//  UIApplication+Extension.swift
//  CommonExtension
//
//  Created by 袁杰 on 2025/4/6.
//

import Foundation

extension UIApplication {
    var rootWindow: UIWindow? {
        if #available(iOS 13.0, *) {
            return UIApplication.shared.connectedScenes
                .compactMap { ($0 as? UIWindowScene)?.windows.first(where: { $0.isKeyWindow }) }
                .first
        } else {
            return UIApplication.shared.keyWindow
        }
    }
    
    static func topViewController(base: UIViewController? = UIApplication.shared.rootWindow?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return topViewController(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            return topViewController(base: tab.selectedViewController)
        }
        if let presented = base?.presentedViewController {
            return topViewController(base: presented)
        }
        return base
    }
}
