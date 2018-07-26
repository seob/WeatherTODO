//
//  CustomTableViewCell.swift
//  Weachertodo
//
//  Created by seob on 2018. 7. 23..
//  Copyright © 2018년 seob. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "title"
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "2018-01-01"
        label.textColor = .black
        label.textAlignment = NSTextAlignment.right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(titleLabel)
        addSubview(dateLabel)
        setuplayout()
    }
     
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setuplayout(){
        
        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor ,constant: 10).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor ,constant: 20).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor ,constant: 10).isActive = true
        titleLabel.setContentHuggingPriority(UILayoutPriority(800), for: UILayoutConstraintAxis.horizontal)
//        titleLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
//        titleLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        
        dateLabel.topAnchor.constraint(equalTo: contentView.topAnchor ,constant: 10).isActive = true
        dateLabel.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor ,constant: 20).isActive = true
        dateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor ,constant: 20).isActive = true
        dateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor ,constant: 10).isActive = true
        dateLabel.setContentHuggingPriority(UILayoutPriority(700), for: UILayoutConstraintAxis.horizontal)
//        dateLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
//        dateLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
    }

}
