//
//  Colors.swift
//  Fox Weather
//
//  Created by Joseph Mikko Mañoza on 05/02/2020.
//  Copyright © 2020 Joseph Mikko Mañoza. All rights reserved.
//

import Foundation
import UIKit

struct Colors {
    static let navigationBarGreen: UIColor = UIColor.colorWithRGBHex(0x427781)
    static let darkYellow: UIColor = UIColor.colorWithRGBHex(0xAE7A00)
}

extension UIColor {
    class func colorWithRGBHex(_ hex: Int, alpha: Float = 1.0) -> UIColor {
        let r = Float((hex >> 16) & 0xFF)
        let g = Float((hex >> 8) & 0xFF)
        let b = Float((hex) & 0xFF)
        
        return UIColor(red: CGFloat(r / 255.0), green: CGFloat(g / 255.0), blue:CGFloat(b / 255.0), alpha: CGFloat(alpha))
    }
}
