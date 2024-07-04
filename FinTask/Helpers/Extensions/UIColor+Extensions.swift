//
//  UIColor+Extensions.swift
//  FinTask
//
//  Created by Иван Незговоров on 25.06.2024.
//

import UIKit

extension UIColor {
    func rgb(r: Int, g: Int, b: Int) -> UIColor {
        return UIColor(
            red: Double(r) / 255.0,
            green: Double(g) / 255.0,
            blue: Double(b) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    func toHexString() -> String {
        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 0
        getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        let rgba: Int = (Int)(red*255)<<24 | (Int)(green*255)<<16 | (Int)(blue*255)<<8 | (Int)(alpha*255)
        return String(format:"#%08x", rgba)
    }
    
    convenience init?(hexString: String) {
        var hexString = hexString.trimmingCharacters(in: .whitespacesAndNewlines)
        hexString = hexString.replacingOccurrences(of: "#", with: "")
        
        var rgbValue: UInt64 = 0
        Scanner(string: hexString).scanHexInt64(&rgbValue)
        
        let red = CGFloat((rgbValue & 0xFF000000) >> 24) / 255.0
        let green = CGFloat((rgbValue & 0x00FF0000) >> 16) / 255.0
        let blue = CGFloat((rgbValue & 0x0000FF00) >> 8) / 255.0
        let alpha = CGFloat(rgbValue & 0x000000FF) / 255.0
        
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
}
