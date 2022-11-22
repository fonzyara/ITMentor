//
//  UIColor + gradient.swift
//  ITmentors
//
//  Created by Vladimir Alecseev on 28.09.2022.
//

import Foundation
import UIKit

class Gradientor{
    func getGradientFromColor(color: UIColor) -> [CGColor]{

        switch color{
        case .red:
           return [UIColor(hex: 0xFF416C).cgColor,
             UIColor(hex: 0xFF4B2B).cgColor]
        case .orange:
            return [UIColor(hex: 0xf7b733).cgColor, UIColor(hex: 0xfc4a1a).cgColor]
        case .green:
            return [UIColor(hex: 0x52c234).cgColor, UIColor(hex: 0x061700).cgColor]
        case .blue:
            return [UIColor(hex: 0x4e54c8).cgColor,
             UIColor(hex: 0x8f94fb).cgColor]
        case .yellow:
            return [UIColor(hex: 0xfffc00).cgColor,
             UIColor(hex: 0xfffc00).cgColor]
        case .purple:   
            return [UIColor(hex: 0x654ae3).cgColor,
             UIColor(hex: 0xeaafc8).cgColor]
        default:
            return [UIColor(hex: 0x4e54c8).cgColor,
             UIColor(hex: 0x8f94fb).cgColor]
        }
    }
}
