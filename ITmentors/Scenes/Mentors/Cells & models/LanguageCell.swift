//
//  LanguageCell.swift
//  ITmentors
//
//  Created by Vladimir Alecseev on 28.09.2022.
//

import UIKit


class LanguageCollectionViewCell: UICollectionViewCell {
    
    
    var languageName: String?
    var languageBackgroundColor: UIColor?{
        didSet{
            switchToGradient()
            let gradientor = Gradientor()
            gradient.colors = gradientor.getGradientFromColor(color: languageBackgroundColor ?? .clear)
        }
    }
    var languageIconName: String? {
        didSet{
            languageImageView.image = UIImage(named: languageIconName ?? "")
            createViews()
        }
    }
    var setUpGradiend: CAGradientLayer?
    let gradient = CAGradientLayer()
    
    func switchToGradient(){
        gradient.frame = self.bounds
        layer.masksToBounds = true
        self.layer.insertSublayer(gradient, at: 0)

    }
    override func layoutSubviews() {
        super.layoutSubviews()
        setUpGradiend?.frame = self.bounds

    }
    func setup(language: Language){
        languageName = language.rawValue
        languageIconName = language.iconName
        languageBackgroundColor = language.color
    }
    
    let languageImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    let languageNameLabel: UILabel = {
        let l = UILabel()
        l.textColor = .white
        l.adjustsFontSizeToFitWidth = true
        l.minimumScaleFactor = 0.7
        l.textAlignment = .center
        return l
    }()
}

extension LanguageCollectionViewCell{
    func createViews(){
        backgroundColor = self.languageBackgroundColor
        layer.cornerRadius = 15
        languageNameLabel.text = languageName
        addSubview(languageImageView)
        addSubview(languageNameLabel)
        setConstraints()
    }
    
    func setConstraints() {
        languageImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(5)
            make.right.equalToSuperview().offset(-8)
            make.bottom.equalToSuperview().offset(-5)
            make.width.equalTo(languageImageView.snp.height)
        }
        languageNameLabel.snp.makeConstraints { make in
            make.top.left.equalToSuperview().offset(5)
            make.bottom.equalToSuperview().offset(-5)
            make.right.equalTo(languageImageView.snp.left).offset(-5)

        }
        
    }
}

