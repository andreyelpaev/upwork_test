//
//  UIView.swift
//  TestToUpwork
//
//  Created by Andrey Elpaev on 02/05/2017.
//  Copyright © 2017 ClearSofrware. All rights reserved.
//

import UIKit

extension UIView {
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        mask.frame = self.bounds
        self.layer.mask = mask
        
        let frameLayer = CAShapeLayer()
        frameLayer.frame = bounds
        frameLayer.path = mask.path
        frameLayer.fillColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0).cgColor
        


        
        self.layer.addSublayer(frameLayer)
        
    }
}
