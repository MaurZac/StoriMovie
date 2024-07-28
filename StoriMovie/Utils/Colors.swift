//
//  Colors.swift
//  StoriMovie
//
//  Created by MaurZac on 25/07/24.
//

import UIKit
//let viewBackgroundColor = ColorUtils.color1
struct ColorUtils {
    static let mainGreen = UIColor(hex: "#003A40")
    static let secondaryGreen = UIColor(hex: "#336166")
    static let Olive = UIColor(hex: "#66898C")
    static let OliveTwo = UIColor(hex: "#809DA0")
    static let OliveThree = UIColor(hex: "#99B0B3")
    static let GrayGreen = UIColor(hex: "#B3C4C6")
    static let GrayGreenTwo = UIColor(hex: "#CCD8D9")
    static let Gray = UIColor(hex: "#E6EBEC")
    static let lightGray = UIColor(hex: "#F3F5F6")
    static let white = UIColor(hex: "#FFFFFF")
}

extension UIColor {
    convenience init(hex: String) {
        var hexString = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if hexString.hasPrefix("#") {
            hexString.remove(at: hexString.startIndex)
        }
        
        if hexString.count != 6 {
            self.init(white: 1.0, alpha: 0.0)
            return
        }
        
        var rgbValue: UInt64 = 0
        Scanner(string: hexString).scanHexInt64(&rgbValue)
        
        let red = CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgbValue & 0x0000FF) / 255.0
        
        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
}

