//
//  UITextField+Extension.swift
//  
//
//  Created by Jack on 2022-11-29.
//

import Foundation
import UIKit

public extension UITextField{
    convenience init(titleFont: UIFont? = .systemFont(ofSize: 16), titleColor: UIColor? = .black, titleString: String? = "", placeFont: UIFont? = .systemFont(ofSize: 16), placeColor: UIColor? = .gray, placeString: String? = "", textAlignment: NSTextAlignment? = .left) {
        self.init()
        self.font = titleFont
        self.textColor = titleColor
        self.attributedPlaceholder = NSAttributedString.init(string: placeString!, attributes: [.foregroundColor: placeColor!, .font: placeFont!])
    }

    private struct AssociatedKey{
        static var indexPath = IndexPath.init(row: 0, section: 0)
    }

    var indexPath : IndexPath{
        get{
            return objc_getAssociatedObject(self, &AssociatedKey.indexPath) as? IndexPath ?? IndexPath.init(row: 0, section: 0)
        }

        set{
            objc_setAssociatedObject(self, &AssociatedKey.indexPath, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
    }
}
