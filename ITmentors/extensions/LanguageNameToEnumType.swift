//
//  LanguageNameToEnumType.swift
//  ITmentors
//
//  Created by Vladimir Alecseev on 04.10.2022.
//

import Foundation
class LanguageNameToEnumType{
     static func from(_ array: [String]) -> [Language]{
        var result = [Language]()
        array.compactMap{
            switch $0{
            case "C++":
                result.append(.cPlusPlus)
            case "JS":
                result.append(.js)
            case "PHP":
                result.append(.php)
            case "Python":
                result.append(.python)
            case "Ruby":
                result.append(.ruby)
            case "Swift":
                result.append(.swift)
            default:
                break
            }
        }
        
        return result
    }
}
