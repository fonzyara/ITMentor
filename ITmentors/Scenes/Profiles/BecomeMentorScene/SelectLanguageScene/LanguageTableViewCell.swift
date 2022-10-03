//
//  LanguageTableViewCell.swift
//  ITmentors
//
//  Created by Vladimir Alecseev on 01.10.2022.
//

import UIKit

class LanguageTableViewCell: UITableViewCell {
    var cellIndexPathRow: Int?
    


    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setConstraints()
        backgroundColor = .AppPalette.elementsColor
    }
    
    required init?(coder: NSCoder) {
       fatalError("init(coder:) has not been implemented")
    }
    
    let label: UILabel = {
      let l = UILabel()
        l.textColor = .white
        l.font = UIFont.boldSystemFont(ofSize: 20)
        l.textAlignment = .left
        return l
    }()
    
    let icon: UIImageView = {
      let i = UIImageView()
        i.contentMode = .scaleAspectFit
        return i
    }()
}

extension LanguageTableViewCell {
    func setConstraints(){
        contentView.addSubview(label)
        contentView.addSubview(icon)
        
        label.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(15)
        }
        
        icon.snp.makeConstraints { make in
            make.left.equalTo(label.snp.right).offset(7)
            make.centerY.equalToSuperview()
            make.height.equalTo(contentView.snp.height).multipliedBy(0.7)
            make.width.equalTo(icon.snp.height)
        }
        
    }
}
