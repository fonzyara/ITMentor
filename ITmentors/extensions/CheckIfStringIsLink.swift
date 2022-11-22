//
//  CheckIfStringIsLink.swift
//  ITmentors
//
//  Created by Vladimir Alecseev on 12.10.2022.
//

import Foundation

class CheckerIfStringIsLink{
    func check(_ string: String?) -> Bool{
        guard let string = string else {return false}
        guard string.isEmpty == false else {return false}
        guard string.prefix(8) == "https://" else {return false}
        return true
    }
}
