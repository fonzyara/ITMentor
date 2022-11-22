//
//  MentorsScreenView.swift
//  ITmentors
//
//  Created by Vladimir Alecseev on 22.11.2022.
//

import Foundation
import UIKit
protocol MentorsScreenViewDelegate: AnyObject {
    func goToDetailedMentorScreenn(withData: MentorsScreen.ShowMentorCells.ViewModel.MentorCellViewModel)
}

class MentorsScreenView: UIView{
    
    weak var delegate: MentorsScreenViewDelegate?
    
    var rows: [CellIdentifiable] = [] {
        didSet{
//            tableViewOfMentors.removeFromSuperview()
            addTableView(withTableViewHeigth: CGFloat(rows.count * 110))
            mentorsCountLabel.text = "\(rows.count) mentors"
            spinner.removeFromSuperview()
        }
    }
    
    
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .AppPalette.backgroundColor
        
        addSubviews()
        setConstraints()
        
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - subviews
    let tableViewOfMentors: UITableView = {
       let tv = UITableView()
        tv.backgroundColor = UIColor.AppPalette.elementsColor
        tv.layer.cornerRadius = 20
        tv.allowsSelection = false
        return tv
    }()
    
    let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        spinner.color = .white
    return spinner
    }()
    let mentorsCountLabel: UILabel = {
        let l = UILabel()
        l.textColor = .darkGray
        l.textAlignment = .center
      return l
    }()
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension MentorsScreenView: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellViewModel = rows[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: cellViewModel.cellIdentifier, for: indexPath) as! MentorCell
        cell.cellModel = cellViewModel
        cell.goToDetailedMentorScreenDelegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        110
    }
    
}

//MARK: - Extensions
extension MentorsScreenView{
    private func addSubviews(){
        addSubview(spinner)
    }
    
    private func setConstraints(){
        spinner.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
    }
    private func addTableView(withTableViewHeigth: CGFloat){
        tableViewOfMentors.register(MentorCell.self, forCellReuseIdentifier: "MentorCell")
        tableViewOfMentors.delegate = self
        tableViewOfMentors.dataSource = self
        
        addSubview(tableViewOfMentors)
        addSubview(mentorsCountLabel)
        tableViewOfMentors.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)

            make.top.equalToSuperview().offset(30)
            make.height.equalTo(withTableViewHeigth)
        }
        mentorsCountLabel.snp.makeConstraints { make in
            make.top.equalTo(tableViewOfMentors.snp.bottom).offset(7)
            make.centerX.equalToSuperview()
        }
    }
}
extension MentorsScreenView: goToDetailedMentorScreenDelegateProtocol{
    func goToDetailedMentorScreen(withData: MentorsScreen.ShowMentorCells.ViewModel.MentorCellViewModel) {
        delegate?.goToDetailedMentorScreenn(withData: withData)
    }
}

