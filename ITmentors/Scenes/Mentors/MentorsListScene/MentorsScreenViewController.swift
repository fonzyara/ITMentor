//
//  MentorsScreenViewController.swift
//  ITmentors
//
//  Created by Vladimir Alecseev on 27.09.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.

import SnapKit
import UIKit

protocol MentorsScreenDisplayLogic: AnyObject {
    func displayMentorCells(viewModel: MentorsScreen.ShowMentorCells.ViewModel)
}

class MentorsScreenViewController: UIViewController, MentorsScreenDisplayLogic, ConstraintRelatableTarget {
    
//MARK: - variables
    private var rows: [CellIdentifiable] = []

    
    var interactor: MentorsScreenBusinessLogic?
    var router: (NSObjectProtocol & MentorsScreenRoutingLogic & MentorsScreenDataPassing)?
    
    
    private lazy var presentationView: MentorsScreenView = {
        let view = MentorsScreenView()
        view.delegate = self
        return view
    }()
    
// MARK: - Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        MentorsListConfigurator.shared.configure(with: self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        MentorsListConfigurator.shared.configure(with: self)
    }
    override func loadView() {
        super.loadView()
        view = presentationView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        loadMentors()
    }

// MARK: - interactor tasks
    func loadMentors(){
        interactor?.loadMentors()
    }
    
// MARK: - presenter tasks
    func displayMentorCells(viewModel: MentorsScreen.ShowMentorCells.ViewModel) {
        presentationView.rows = viewModel.rows
        return
    }
}


//MARK: - MentorsScreenViewDelegate
extension MentorsScreenViewController: MentorsScreenViewDelegate{
    func goToDetailedMentorScreenn(withData: MentorsScreen.ShowMentorCells.ViewModel.MentorCellViewModel) {
        router?.navigateToDetailed(source: self, destination: DetailedMentorViewController(), withData: withData)
    }
}
