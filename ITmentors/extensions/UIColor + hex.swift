//
//  UIColor + hex.swift
//  ITmentors
//
//  Created by Vladimir Alecseev on 27.09.2022.
//
import UIKit

extension UIColor {

    convenience init(hex: Int) {
        let components = (
            R: CGFloat((hex >> 16) & 0xff) / 255,
            G: CGFloat((hex >> 08) & 0xff) / 255,
            B: CGFloat((hex >> 00) & 0xff) / 255
        )
        self.init(red: components.R, green: components.G, blue: components.B, alpha: 1)
    }

}
extension CGColor {

    class func colorWithHex(hex: Int) -> CGColor {

        return UIColor(hex: hex).cgColor

    }

}

