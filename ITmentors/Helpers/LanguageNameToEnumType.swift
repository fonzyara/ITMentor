//
//  LanguageNameToEnumType.swift
//  ITmentors
//
//  Created by Vladimir Alecseev on 04.10.2022.
//

import Foundation
class LanguageNameToEnumType{
    func from(_ string: String) -> Languages{
        switch string{
        case "C++":
            return .cPlusPlus
        case "JS":
            return .js
        case "PHP":
            return .php
        case "Python":
            return .python
        case "Ruby":
            return .ruby
        case "Swift":
            return .swift
        default:
            return .ruby
        }
    }
}
