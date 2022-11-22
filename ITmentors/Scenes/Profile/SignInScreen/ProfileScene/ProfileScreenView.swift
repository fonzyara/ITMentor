//
//  ProfileScreenView.swift
//  ITmentors
//
//  Created by Vladimir Alecseev on 22.11.2022.
//

import UIKit

protocol ProfileScreenViewDelegate: AnyObject{
    
}
class ProfileScreenView: UIView {
    weak var delegate: ProfileScreenViewDelegate?
    
    var viewModel: ProfileScreen.loadYourDataa.ViewModel? {
        didSet{
            guard let viewModel = viewModel else {return}
            yourImageView.image = UIImage(data: viewModel.imageData ?? Data())
            nameLabel.text = viewModel.name
            shortDescriptionLabel.text = viewModel.shortDiscription
            descriptionLabel.text = "О себе: \(viewModel.discription ?? "")"
            messageLinkLabel.text = viewModel.messageLink
            
            setSubviews()
            setConstraints()
            spinner.removeFromSuperview()
            
            let width = UIScreen.main.bounds.width * 0.8 * 0.7
            yourImageView.layer.cornerRadius = width / 2
            
            collectionViewOfLanguages.reloadData()
        }
    }

    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .AppPalette.backgroundColor
        addSpinner()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Subviews
    private let yourImageView: UIImageView = {
        let iv = UIImageView()
        iv.layer.masksToBounds = true
        iv.image = UIImage()
        iv.clipsToBounds = true
        iv.backgroundColor = .gray
        iv.layer.borderColor = UIColor.AppPalette.thirdElementColor.cgColor
        iv.layer.borderWidth = 2
        
        return iv
    }()
    private let shortDescriptionLabel: UILabel = {
        let l = UILabel()
        l.textColor = .gray
        l.textAlignment = .center
        l.numberOfLines = 1
        l.lineBreakMode = .byWordWrapping
        l.adjustsFontSizeToFitWidth = true
        l.minimumScaleFactor = 0.5
        return l
    }()
    private let nameLabel: UILabel = {
        let l = UILabel()
        l.textColor = .white
        l.textAlignment = .center
        l.numberOfLines = 1
        l.lineBreakMode = .byWordWrapping
        l.adjustsFontSizeToFitWidth = true
        l.minimumScaleFactor = 0.5
        l.font = UIFont.boldSystemFont(ofSize: 50)
        return l
    }()
    private let descriptionLabel: UILabel = {
        let l = UILabel()
        l.textColor = .white
        l.textAlignment = .center
        l.numberOfLines = 0
        l.lineBreakMode = .byWordWrapping
        //        l.adjustsFontSizeToFitWidth = true
        //        l.minimumScaleFactor = 0.5
        return l
    }()
    private let messageLinkLabel: UILabel = {
        let l = UILabel()
        l.textColor = .gray
        l.textAlignment = .center
        l.numberOfLines = 1
        l.lineBreakMode = .byWordWrapping
        l.adjustsFontSizeToFitWidth = true
        l.minimumScaleFactor = 0.5
        return l
    }()
    
    lazy private var collectionViewOfLanguages: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 6
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    private let goToStatsScreenButton: UIButton = {
        let b = UIButton()
        b.addTarget(self, action: #selector(goToStatsScreen), for: .touchUpInside)
        b.backgroundColor = .AppPalette.thirdElementColor
        b.layer.cornerRadius = 10
        b.layer.borderWidth = 2
        b.layer.borderColor = UIColor.AppPalette.elementsColor.cgColor
        b.setTitle("Посмотреть статистику", for: .normal)
        return b
    }()
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        spinner.color = .white
        return spinner
    }()
    @objc func goToStatsScreen(){
        
    }
    

}


extension ProfileScreenView{
    func setSubviews(){
        addSubview(nameLabel)
        addSubview(shortDescriptionLabel)
        addSubview(yourImageView)
        addSubview(descriptionLabel)
        addSubview(messageLinkLabel)
        addSubview(goToStatsScreenButton)
        
        collectionViewOfLanguages.register(LanguageCollectionViewCell.self, forCellWithReuseIdentifier: "LanguageCell")
        collectionViewOfLanguages.delegate = self
        collectionViewOfLanguages.dataSource = self
        
        addSubview(collectionViewOfLanguages)
    }
    func setConstraints(){
        
        let width = UIScreen.main.bounds.width * 0.8
        yourImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.width.height.equalTo(width * 0.7)
            make.centerX.equalToSuperview()
        }
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(yourImageView.snp.bottom).offset(10)
            make.width.equalTo(width)
            make.height.equalTo(30)
            make.centerX.equalToSuperview()
        }
        shortDescriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(5)
            make.width.equalTo(width)
            make.height.equalTo(30)
            make.centerX.equalToSuperview()
        }
        
        collectionViewOfLanguages.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(40)
            make.right.equalToSuperview().offset(-40)
            make.height.equalTo(30)
            make.top.equalTo(shortDescriptionLabel.snp.bottom).offset(10)
        }
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(collectionViewOfLanguages.snp.bottom).offset(10)
            make.width.equalTo(width)
            make.height.greaterThanOrEqualTo(30)
            make.centerX.equalToSuperview()
        }
        messageLinkLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-10)
            make.centerX.equalToSuperview()
        }
        goToStatsScreenButton.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.width.equalTo(width)
            make.height.equalTo(50)
        }
    }
    func addSpinner(){
        addSubview(spinner)
        spinner.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
    }
}


//MARK: UICollectionViewDataSource

extension ProfileScreenView: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.languages.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LanguageCell", for: indexPath) as! LanguageCollectionViewCell
        guard let data = viewModel else {return cell}
        cell.setup(language: data.languages[indexPath.row])

        return cell
    }
}


//MARK: UICollectionViewDataSource
extension ProfileScreenView: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
    }

}

//MARK: UICollectionViewDelegateFlowLayout
extension ProfileScreenView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: 90, height: 29)
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 3
    }


    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        let CellWidth = 90
        let CellCount = collectionView.numberOfItems(inSection: 0)
        let CellSpacing = 5
        let collectionViewWidth = collectionView.frame.width
        guard CGFloat(CellWidth * CellCount) < collectionViewWidth else {return UIEdgeInsets()}
        let totalCellWidth = CellWidth * CellCount
        let totalSpacingWidth = CellSpacing * (CellCount - 1)

        let leftInset = (collectionViewWidth - CGFloat(totalCellWidth + totalSpacingWidth)) / 2
        let rightInset = leftInset

        return UIEdgeInsets(top: 0, left: leftInset, bottom: 0, right: rightInset)
    }
}
