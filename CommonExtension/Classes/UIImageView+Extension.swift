//
//  UIImageView+Extension.swift
//  CarbonWorld
//
//  Created by 袁杰 on 2022/11/19.
//

import Foundation
import UIKit

public extension UIImageView{
    convenience init(image: UIImage, contentMode: UIView.ContentMode){
        self.init()
        self.image = image
        self.contentMode = .scaleAspectFill
        self.clipsToBounds = true
    }
}
