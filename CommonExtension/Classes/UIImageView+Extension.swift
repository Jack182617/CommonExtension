//
//  UIImageView+Extension.swift
//
//
//  Created by Jack on 2022/11/19.
//

import Foundation
import UIKit

public extension UIImageView{
    convenience init(image: UIImage, contentMode: UIView.ContentMode? = .scaleAspectFill, clipsToBounds: Bool? = false){
        self.init()
        self.image = image
        self.contentMode = contentMode!
        self.clipsToBounds = clipsToBounds!
    }
}
