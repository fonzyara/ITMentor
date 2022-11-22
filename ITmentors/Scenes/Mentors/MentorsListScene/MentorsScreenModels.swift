//
//  MentorsScreenModels.swift
//  ITmentors
//
//  Created by Vladimir Alecseev on 27.09.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit
protocol CellIdentifiable{
    var cellIdentifier: String { get }
    var cellHeight: Double { get }
}

struct MentorCellModel{
    let name: String?
    let discription: String?
    let shortDiscription: String?
    let imageData: Data?
    let languages: [Language]
    let messageLink: String?
    let ShortUUID: String?

}




enum MentorsScreen {
    // MARK: Use cases
    
    enum ShowMentorCells {
        // из интерактора в презентер передадим массив экземпляров моделей ячейки
        struct Response {
            let mentorCellsData: [MentorCellModel]
        }
        
        struct ViewModel {
            struct MentorCellViewModel: CellIdentifiable {
                let name: String?
                let discription: String?
                let imageData: Data?
                let languages: [Language]
                let messageLink: String?
                let shortDiscription: String?
                let ShortUUID: String?

                
                var cellIdentifier: String {
                    "MentorCell"
                }
                var cellHeight: Double {
                    200
                }
                init(cellData: MentorCellModel) {
                    name = cellData.name
                    discription = cellData.discription
                    imageData = cellData.imageData
                    languages = cellData.languages
                    messageLink = cellData.messageLink
                    shortDiscription = cellData.shortDiscription
                    ShortUUID = cellData.ShortUUID
                }
            }
            
            let rows: [CellIdentifiable]
        }
    }

}
