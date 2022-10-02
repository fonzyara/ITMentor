//
//  LanguageModel.swift
//  ITmentors
//
//  Created by Vladimir Alecseev on 29.09.2022.
//

import UIKit
enum Languages: CaseIterable{
    
    case python
    case swift
    case js
    case cPlusPlus
    case php
    case ruby
    
    var languageName: String {
        switch self {
        case .python:
            return "Python"
        case .swift:
            return "Swift"
        case .js:
            return "JS"
        case .cPlusPlus:
            return "C++"
        case .php:
            return "PHP"
        case .ruby:
            return "Ruby"
            
        }
    }
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
