//
//  SelectLanguageViewModel.swift
//  ITmentors
//
//  Created by Vladimir Alecseev on 01.10.2022.
//

import UIKit

protocol SelectLanguagesViewModelProtocol: AnyObject {
    var arrayOfSelectedLanguages: [Languages] { get set }
    var arrayOfAllLanguages: [Languages] { get set }
    func appendToArray(cellIndexPathRow: Int)
    func removeFromArray(cellIndexPathRow: Int)

}

class  SelectLanguagesViewModel: SelectLanguagesViewModelProtocol {
    var arrayOfSelectedLanguages: [Languages] = []
    var arrayOfAllLanguages: [Languages] = Languages.allCases

    func appendToArray(cellIndexPathRow: Int){
        print(cellIndexPathRow)
        arrayOfSelectedLanguages.append(arrayOfAllLanguages[cellIndexPathRow])
        print(arrayOfSelectedLanguages)

    }
    func removeFromArray(cellIndexPathRow: Int){
        for i in 0...arrayOfSelectedLanguages.count{
            let elementWeNeedDelete = arrayOfAllLanguages[cellIndexPathRow]
            let elementWeCheck = arrayOfSelectedLanguages[i]
            if elementWeNeedDelete == elementWeCheck{
                arrayOfSelectedLanguages.remove(at: i)
                break
            }
        }
        print(arrayOfSelectedLanguages)

    }
}
