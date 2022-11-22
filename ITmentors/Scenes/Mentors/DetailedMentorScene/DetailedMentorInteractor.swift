//
//  DetailedMentorInteractor.swift
//  ITmentors
//
//  Created by Vladimir Alecseev on 29.09.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol DetailedMentorBusinessLogic {
    func showMentorInfo()
    func reportMentor(request: DetailedMentor.SendMentorReport.Request)
}

protocol DetailedMentorDataStore {
    var name: String? { get set}
    var discription: String? { get set}
    var imageData: Data? { get set}
    var languages: [Language] { get set}
    var messageLink: String? { get set}
    var shortDiscription: String? { get set}
    var ShortUUID: String? {get set}

}

class DetailedMentorInteractor: DetailedMentorBusinessLogic, DetailedMentorDataStore {
    
    var name: String?
    var discription: String?
    var imageData: Data?
    var languages: [Language] = []
    var messageLink: String?
    var shortDiscription: String?
    var ShortUUID: String?
    
    var presenter: DetailedMentorPresentationLogic?
    var worker: DetailedMentorWorker?
    //var name: String = ""
    
    // MARK: Do something
    
    func showMentorInfo() {
        var response = DetailedMentor.ShowMentorInfo.Response()
        response.languages = languages
        response.imageData = imageData
        response.discription = discription
        response.name = name
        response.messageLink = messageLink
        response.shortDiscription = shortDiscription
        presenter?.presentMentorInfo(response: response)
    }
    
    func reportMentor(request: DetailedMentor.SendMentorReport.Request) {
        let worker = DetailedMentorWorker()
        worker.sendReport(to: ShortUUID, with: request.reason ?? "") { [unowned self] in
            let response = DetailedMentor.SendMentorReport.Response(isReportSucssfulSent: true)
            presenter?.presentReportStatus(response: response)
        } error: { [unowned self] in
            let response = DetailedMentor.SendMentorReport.Response(isReportSucssfulSent: false)
            presenter?.presentReportStatus(response: response)
        }

    }
}
