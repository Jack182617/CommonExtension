//
//  UIView+Extension.swift
//  SpeedR_Extension
//
//  Created by 袁杰 on 2022/10/10.
//

import Foundation
import UIKit

public struct UIRectSide: OptionSet {
    public let rawValue: Int
    public static let left = UIRectSide(rawValue: 1 << 0)
    public static let top = UIRectSide(rawValue: 1 << 1)
    public static let right = UIRectSide(rawValue: 1 << 2)
    public static let bottom = UIRectSide(rawValue: 1 << 3)
    public static let all: UIRectSide = [.top, .right, .left, .bottom]

    public init(rawValue: Int) {
        self.rawValue = rawValue
    }

}

public extension UIView{
    // 使用贝塞尔曲线画圆角时UIView动画改变frame时有问题：width或者height不变，这时需要在frame改变后重新设置圆角，，，或者用常规的方式设置圆角就不会有问题了
    // 四个角都加圆角
    func addAllCorner(cornerRadius: CGFloat) {
        let maskPath = UIBezierPath.init(roundedRect: self.bounds, cornerRadius: cornerRadius)
        let maskLayer = CAShapeLayer.init()
        maskLayer.frame = self.bounds
        maskLayer.path = maskPath.cgPath
        self.layer.mask = maskLayer
    }

    // 单独给每个角加圆角
    func addSingleCorner(location: UIRectCorner, cornerRadius: CGSize) {
        let maskPath = UIBezierPath.init(roundedRect: self.bounds, byRoundingCorners: location, cornerRadii: cornerRadius)

        let maskLayer = CAShapeLayer.init()
        maskLayer.frame = self.bounds
        maskLayer.path = maskPath.cgPath
        self.layer.mask = maskLayer
    }

    // 给四个角设置不同的圆角 (四个角同时设置)
    func addFourCorner(topLeft: CGFloat, topRight: CGFloat, bottomLeft: CGFloat, bottomRight: CGFloat) {
        let minX = bounds.minX
        let minY = bounds.minY
        let maxX = bounds.maxX
        let maxY = bounds.maxY

        let topLeftCenterX = minX + topLeft
        let topLeftCenterY = minY + topLeft
        let topRightCenterX = maxX - topRight
        let topRightCenterY = minY + topRight
        let bottomLeftCenterX = minX + bottomLeft
        let bottomLeftCenterY = maxY - bottomLeft
        let bottomRightCenterX = maxX - bottomRight
        let bottomRightCenterY = maxY - bottomRight

        let path = CGMutablePath()
        path.addArc(center: CGPoint(x: topLeftCenterX, y: topLeftCenterY), radius: topLeft, startAngle: CGFloat(Double.pi), endAngle: CGFloat(3 * Double.pi / 2.0), clockwise: false)
        path.addArc(center: CGPoint(x: topRightCenterX, y: topRightCenterY), radius: topRight, startAngle: CGFloat(3 * Double.pi / 2.0), endAngle: 0, clockwise: false)
        path.addArc(center: CGPoint(x: bottomRightCenterX, y: bottomRightCenterY), radius: bottomRight, startAngle: 0, endAngle: CGFloat(Double.pi / 2.0), clockwise: false)
        path.addArc(center: CGPoint(x: bottomLeftCenterX, y: bottomLeftCenterY), radius: bottomLeft, startAngle: CGFloat(Double.pi / 2.0), endAngle: CGFloat(Double.pi), clockwise: false)
        path.closeSubpath()

        let maskLayer = CAShapeLayer.init()
        maskLayer.frame = self.bounds
        maskLayer.path = path
        self.layer.mask = maskLayer
    }

    // 用view生成图片
    func makeImageWithView() -> UIImage{
        UIGraphicsBeginImageContext(self.bounds.size)
        if let context: CGContext = UIGraphicsGetCurrentContext(){
            self.layer.render(in: context)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            if nil != image{
                return image!
            }
        }
        return UIImage.init()
    }

}
