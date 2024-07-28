//
//  Fonts.swift
//  StoriMovie
//
//  Created by MaurZac on 25/07/24.
//

import UIKit

extension UIFont {
    public class FlatorySans: NSObject {
        static func bold(_ size: CGFloat = 16.0) -> UIFont {
            return UIFont.customFont(fontName: "FlatorySans-700", fontSize: size)
        }

        static func light(_ size: CGFloat = 16.0) -> UIFont {
            return UIFont.customFont(fontName: "FlatorySans-300", fontSize: size)
        }
    }
    
    private static func customFont(fontName: String, fontSize: CGFloat) -> UIFont {
        guard let font = UIFont(name: fontName, size: fontSize) else {
            print("Failed to load font: \(fontName). Falling back to system font.")
            return UIFont.systemFont(ofSize: fontSize)
        }
        return font
    }
}

