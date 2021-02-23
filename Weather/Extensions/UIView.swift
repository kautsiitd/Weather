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
}
