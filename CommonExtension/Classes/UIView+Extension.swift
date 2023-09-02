//
//  UIView+Extension.swift
//  
//
//  Created by Jack on 2022/10/10.
//

import Foundation
import UIKit
import QuartzCore

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
    convenience init(backgroundColor: UIColor? = .clear, clipsToBounds: Bool? = false, cornerRadius: CGFloat? = 0.0) {
        self.init()
        self.backgroundColor = backgroundColor
        self.clipsToBounds = clipsToBounds!
        self.layer.cornerRadius =  cornerRadius!
    }

    // Set Shadow and Fillet
    func addShadow(shadowColor: CGColor, shadowOffset: CGSize, shadowRadius: CGFloat, shadowOpacity: Float, cornerRadius: CGFloat? = 0.0){
        self.layer.shadowColor = shadowColor
        self.layer.shadowOffset = shadowOffset
        self.layer.shadowRadius = shadowRadius
        self.layer.shadowOpacity = shadowOpacity
        self.layer.cornerRadius = cornerRadius!
    }

    // Set gradient and rounded corners (requires a frame)
    func addGradientLayer(colors: [Any], locations: [NSNumber], startPoint: CGPoint, endPoint: CGPoint, cornerRadius: CGFloat? = 0.0){
        //
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors
        gradientLayer.locations = locations
        //
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        gradientLayer.frame = self.bounds
        gradientLayer.cornerRadius = cornerRadius!

        self.layer.insertSublayer(gradientLayer, at: 0)
    }

    // Add rounded corners to all four corners
    func addAllCorner(cornerRadius: CGFloat) {
        let maskPath = UIBezierPath.init(roundedRect: self.bounds, cornerRadius: cornerRadius)
        let maskLayer = CAShapeLayer.init()
        maskLayer.frame = self.bounds
        maskLayer.path = maskPath.cgPath
        self.layer.mask = maskLayer
    }

    // Add rounded corners to each corner separately
    func addSingleCorner(location: UIRectCorner, cornerRadius: CGFloat) {
        let maskPath = UIBezierPath.init(roundedRect: self.bounds, byRoundingCorners: location, cornerRadii: CGSize.init(width: cornerRadius, height: cornerRadius))

        let maskLayer = CAShapeLayer.init()
        maskLayer.frame = self.bounds
        maskLayer.path = maskPath.cgPath
        self.layer.mask = maskLayer
    }

    // Set different fillets for the four corners (set all four corners simultaneously)
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

    // Generate images using view
    func makeImageWithView() -> UIImage{
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, UIScreen.main.scale)
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
