//
//  UIColor.swift
//  TestToUpwork
//
//  Created by Andrey Elpaev on 02/05/2017.
//  Copyright © 2017 ClearSofrware. All rights reserved.
//

import UIKit

public extension UIColor {
    
    convenience public init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
        switch hex.characters.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
    
    public func modify(alpha a: CGFloat) -> UIColor {
        let data = self.cgColor.components
        
        let r = data?[0]
        let g = data?[1]
        let b = data?[2]
        
        return UIColor(red: r!, green: g!, blue: b!, alpha: a)
    }
    
    
}
