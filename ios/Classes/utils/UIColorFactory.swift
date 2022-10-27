//
//  UIColorFactory.swift
//  flutter_yandex_ads_plus
//
//  Created by apple on 27.10.2022.
//

import Foundation

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int, alpha: Int = 0xFF) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")

        self.init(
            red: CGFloat(red) / 255.0,
            green: CGFloat(green) / 255.0,
            blue: CGFloat(blue) / 255.0,
            alpha: CGFloat(alpha) / 255.0
        )
    }
    
    convenience init(argb: Int) {
           self.init(
               red: (argb >> 16) & 0xFF,
               green: (argb >> 8) & 0xFF,
               blue: argb & 0xFF,
               alpha: (argb >> 24) & 0xFF
           )
       }
    
    convenience init(hexString: String) throws {
        let argb = UInt32(hexString.dropFirst(), radix: 16)
        
        if (argb == nil) {
            throw MyError.runtimeError(
                "\(hexString) is not valid hex"
            )
        }

        self.init(
            argb: Int(argb!)
        )
    }
    
    convenience init(hexString: String, defaultColor: UIColor) {
        do {
            try self.init(hexString: hexString)
        } catch {
            self.init(cgColor: defaultColor.cgColor)
        }
    }
}

enum MyError: Error {
    case runtimeError(String)
}
