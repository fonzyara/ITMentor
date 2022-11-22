//
//  LanguageModel.swift
//  ITmentors
//
//  Created by Vladimir Alecseev on 29.09.2022.
//

import UIKit
enum Language: String, CaseIterable{
    
    case python = "Python"
    case swift = "Swift"
    case js = "JS"
    case cPlusPlus = "C++"
    case php = "PHP"
    case ruby = "Ruby"
    
    var color: UIColor {
        switch self {
        case .python:
            return .green
        case .swift:
            return .orange
        case .js:
            return .yellow
        case .cPlusPlus:
            return .blue
        case .php:
            return .purple
        case .ruby:
            return .red
        }
    }
    var iconName: String {
        switch self {
        case .python:
            return "python"
        case .swift:
            return "swift"
        case .js:
            return "js"
        case .cPlusPlus:
            return "c++"
        case .php:
            return "php"
        case .ruby:
            return "ruby"
        }
    }
}
