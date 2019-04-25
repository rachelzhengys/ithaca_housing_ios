//
//  RankViewCell.swift
//  Ithaca Housing
//
//  Created by RachelZheng on 23/4/2019.
//  Copyright © 2019 YISU ZHENG. All rights reserved.
//

import Foundation

import UIKit

class RankViewCell: UICollectionViewCell {
    var rankName: UILabel!
    
    let padding: CGFloat = 8
    let labelHeight: CGFloat = 16
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        rankName = UILabel()
        rankName.translatesAutoresizingMaskIntoConstraints = false
        rankName.font = UIFont.systemFont(ofSize: 16)
        //        filterName.backgroundColor = .white
        rankName.textColor = .blue
        contentView.addSubview(rankName)
        
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            rankName.topAnchor.constraint(equalTo: contentView.topAnchor),
            rankName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            rankName.heightAnchor.constraint(equalToConstant: 20),
            rankName.widthAnchor.constraint(equalToConstant: 150)
            //            filterName.bottomAnchor.constraint(equalTo: contentView.topAnchor),
            //            filterName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            ])
    }
    
    func configure(for rank: Ranks) {
        rankName.text = rank.rankName
    }
}
