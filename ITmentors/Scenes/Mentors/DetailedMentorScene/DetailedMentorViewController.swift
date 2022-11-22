//
//  DetailedMentorViewController.swift
//  ITmentors
//
//  Created by Vladimir Alecseev on 29.09.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//


import UIKit

protocol DetailedMentorDisplayLogic: AnyObject {
    func showMentorInfo(viewModel: DetailedMentor.ShowMentorInfo.ViewModel)
    func isReportSucssfulSentAlert(viewModel: DetailedMentor.SendMentorReport.ViewModel)
}

class DetailedMentorViewController: UIViewController, DetailedMentorDisplayLogic {
    
    var interactor: DetailedMentorBusinessLogic?
    var router: (NSObjectProtocol & DetailedMentorRoutingLogic & DetailedMentorDataPassing)?
    
    private lazy var presentationView: DetailedMentorView = {
        let view = DetailedMentorView()
        view.delegate = self
        return view
    }()
    
    
    // MARK: lifecycle
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        DetailedMentorConfigurator.shared.configure(with: self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        DetailedMentorConfigurator.shared.configure(with: self)
    }
    
    override func loadView() {
        super.loadView()
        view = presentationView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let reportButton = UIBarButtonItem(title: "Пожаловаться", style: .done, target: self, action: #selector(reportButtonTapped))
        navigationItem.rightBarButtonItem = reportButton
        showMentorInfo()
    }
    
    
    // MARK: - interactor tasks
    
    private func showMentorInfo() {
        interactor?.showMentorInfo()
    }
    
    private func sendReport(with reason: String){
        let request = DetailedMentor.SendMentorReport.Request(reason: reason)
        interactor?.reportMentor(request: request)
    }
    
    // MARK: -  presenter
    func showMentorInfo(viewModel: DetailedMentor.ShowMentorInfo.ViewModel) {
        navigationItem.title = viewModel.name
        presentationView.model = viewModel
    }
    
    func isReportSucssfulSentAlert(viewModel: DetailedMentor.SendMentorReport.ViewModel){
        if viewModel.isReportSucssfulSent == true {
            let alert = UIAlertController(title: "Успешно!", message: "Жалоба успешно отправлена!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Отлично", style: .cancel))
            present(alert, animated: true){
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5){
                   alert.dismiss(animated: true)
               }
           }
        } else {
            let alert = UIAlertController(title: "Ошибка!", message: "По каким-то причинам жалоба не была отправлена, попробуйте снова", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Что ж", style: .cancel))
            present(alert, animated: true) {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5){
                    alert.dismiss(animated: true)
                }
            }
        }
        
    }
    

    @objc func reportButtonTapped(){
        let alert = UIAlertController(title: "Пожаловаться на ментора", message: nil, preferredStyle: .actionSheet)
        
        alert.view.tintColor = .systemBlue

        alert.addAction(UIAlertAction(title: "Ссылка для связи недействительна", style: .default , handler:{ [unowned self] actionn in
            sendReport(with: "Ссылка для связи недействительна")
        }))
        alert.addAction(UIAlertAction(title: "Ментор долго не отвечает", style: .default , handler:{ [unowned self] actionn in
            sendReport(with: "Ментор долго не отвечает")
        }))
        alert.addAction(UIAlertAction(title: "Отменить", style: .cancel))
        present(alert, animated: true)
    }
    
}

extension DetailedMentorViewController: DetailedMentorViewDelegate{
    func openMentorLink(withUrlAsString: String) {
        guard withUrlAsString != "" else {return}
        guard let url = URL(string: withUrlAsString) else {return}
        UIApplication.shared.open(url)
    }
}
