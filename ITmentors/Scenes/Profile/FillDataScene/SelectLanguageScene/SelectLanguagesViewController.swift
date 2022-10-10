//
//  SelectLanguagesViewController.swift
//  ITmentors
//
//  Created by Vladimir Alecseev on 01.10.2022.
//

import UIKit

protocol ReturnArrayOfLanguagesToPreviousScreenProtocol{
    func getArray(array: [Languages])
    
}

class SelectLanguagesViewController: UIViewController {
    
    var returnArrayOfLanguagesToPreviousScreenDelegate: ReturnArrayOfLanguagesToPreviousScreenProtocol?
    
    var viewModel: SelectLanguagesViewModelProtocol?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = SelectLanguagesViewModel()
        setConstraints()
        view.backgroundColor = .AppPalette.backgroundColor
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(LanguageTableViewCell.self, forCellReuseIdentifier: "LanguageTableViewCell")
    }
    
    private let tableView: UITableView = {
        let t = UITableView()
        t.backgroundColor = .AppPalette.elementsColor
        t.separatorColor = .white
        t.separatorStyle = .singleLine
        return t
    }()
    
    private let label: UILabel = {
        let l = UILabel()
        l.text = "Языки программирования, которые вы используете"
        l.textColor = .white
        l.textAlignment = .center
        l.font = UIFont.boldSystemFont(ofSize: 40)
        l.minimumScaleFactor = 0.1
        l.adjustsFontSizeToFitWidth = true
        return l
    }()
    private let confirmButton: UIButton = {
        let b = UIButton()
        b.backgroundColor = .blue
        b.addTarget(self, action: #selector(returnArrayOfLanguagesToPreviousScreen), for: .touchUpInside)
        b.setTitle("Подтвердить", for: .normal)
        b.layer.cornerRadius = 10
        
        return b
    }()
    
    @objc func returnArrayOfLanguagesToPreviousScreen(){
        navigationController?.viewControllers.removeLast()
        self.returnArrayOfLanguagesToPreviousScreenDelegate?.getArray(array: viewModel?.arrayOfSelectedLanguages ?? [])
        
    }
    
}


//MARK: -  Constraints
extension SelectLanguagesViewController{
    private func setConstraints(){
        view.addSubview(tableView)
        view.addSubview(label)
        view.addSubview(confirmButton)
        tableView.snp.makeConstraints { make in
            make.right.left.equalToSuperview()
            make.top.equalTo(label.snp.bottom).offset(15)
            make.bottom.equalToSuperview().offset(-150)

        }
        
        label.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(5)
            make.right.equalToSuperview().offset(-15)
            make.top.equalToSuperview().offset(7)
        }
        confirmButton.snp.makeConstraints { make in
            make.top.equalTo(tableView.snp.bottom).offset(30)
            make.width.equalToSuperview().multipliedBy(0.7)
            make.height.equalTo(40)
            make.centerX.equalToSuperview()
        }
    }
}
//MARK: - TableView delegate&datasource

extension SelectLanguagesViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        70
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.cellForRow(at: indexPath.row)?.isSelected
        if tableView.cellForRow(at: indexPath)?.backgroundColor == .AppPalette.elementsColor {
            tableView.cellForRow(at: indexPath)?.backgroundColor = .AppPalette.secondElementColor
            viewModel?.appendToArray(cellIndexPathRow: indexPath.row)
        }
        else if tableView.cellForRow(at: indexPath)?.backgroundColor == .AppPalette.secondElementColor {
            tableView.cellForRow(at: indexPath)?.backgroundColor = .AppPalette.elementsColor
            viewModel?.removeFromArray(cellIndexPathRow: indexPath.row)
        }

    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.arrayOfAllLanguages.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LanguageTableViewCell", for: indexPath) as! LanguageTableViewCell
        cell.label.text = viewModel?.arrayOfAllLanguages[indexPath.row].languageName
        cell.icon.image = UIImage(named: viewModel?.arrayOfAllLanguages[indexPath.row].iconName ?? "")
        
        let bgColorView = UIView()
        bgColorView.backgroundColor = UIColor.clear
        cell.selectedBackgroundView = bgColorView
        return cell
    }
    
    
}


