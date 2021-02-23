//
//  UIView.swift
//  Weather
//
//  Created by Kautsya Kanu on 23/02/21.
//

import UIKit
extension UIView {
    func animatePop() {
        transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: 0.3,
                       initialSpringVelocity: 6.0, options: .allowUserInteraction, animations: {
            self.transform = .identity
           }, completion: nil)
    }
    var gradientLayerName: String { return "gradientLayer" }
    func addGradiant(of colors: [UIColor], from startPoint: Point, to endPoint: Point, at index: UInt32 = 0, shouldRasterize: Bool = false) {
        removeGradient()
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors.map({ $0.cgColor })
        gradientLayer.startPoint = startPoint.relativePos
        gradientLayer.endPoint = endPoint.relativePos
        gradientLayer.frame = bounds
        gradientLayer.name = gradientLayerName
        gradientLayer.shouldRasterize = shouldRasterize

        layer.insertSublayer(gradientLayer, at: index)
    }
    func removeGradient() {
        if let oldlayer = layer.sublayers?.filter({$0.name == gradientLayerName}).first {
            oldlayer.removeFromSuperlayer()}
    }
}

//MARK:- Enums
extension UIView {
    enum Point {
        enum VerticalPos { case top, mid, bottom, custom(_ pos: CGFloat) }
        enum HorizontalPos { case left, mid, right, custom(_ pos: CGFloat) }
        case pos(_ y: VerticalPos, _ x: HorizontalPos)
        
        var relativePos: CGPoint {
            let x: CGFloat
            let y: CGFloat
            switch self {
            case .pos(let verticalPos, let horizontalPos):
                switch horizontalPos {
                case .left: x = 0
                case .mid: x = 0.5
                case .right: x = 1
                case .custom(let xPos): x = xPos
                }
                switch verticalPos {
                case .top: y = 0
                case .mid: y = 0.5
                case .bottom: y = 1
                case .custom(let yPos): y = yPos
                }
            }
            return CGPoint(x: x, y: y)
        }
    }
}
