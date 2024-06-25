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
}
