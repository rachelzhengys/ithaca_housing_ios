//
//  HousingViewCell.swift
//  Ithaca Housing
//
//  Created by RachelZheng on 24/4/2019.
//  Copyright © 2019 YISU ZHENG. All rights reserved.
//

import Foundation
import UIKit

class HousingViewCell: UICollectionViewCell{
    var houseImage: UIImageView!
    var houseName: UILabel!
    var money: UILabel!
    var houseType: UILabel!

    let padding: CGFloat = 9
    let labelHeight: CGFloat = 18
    let restImageWidth: CGFloat = 120
    let restImageHeight: CGFloat = 80
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        houseImage = UIImageView(frame: .zero)
        houseImage.translatesAutoresizingMaskIntoConstraints = false
        houseImage.contentMode = .scaleAspectFit
        contentView.addSubview(houseImage)
        
        houseName = UILabel(frame: .zero)
        houseName.translatesAutoresizingMaskIntoConstraints = false
        houseName.font = UIFont.systemFont(ofSize: 16)
        contentView.addSubview(houseName)
        
        money = UILabel(frame: .zero)
        money.translatesAutoresizingMaskIntoConstraints = false
        money.font = UIFont.systemFont(ofSize: 10)
        contentView.addSubview(money)
        
        houseType = UILabel(frame: .zero)
        houseType.translatesAutoresizingMaskIntoConstraints = false
        houseType.font = UIFont.systemFont(ofSize: 10)
        contentView.addSubview(houseType)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func updateConstraints() {
        super.updateConstraints()
        
        NSLayoutConstraint.activate([
            houseImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            houseImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            houseImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            houseImage.bottomAnchor.constraint(equalTo: contentView.topAnchor, constant: restImageHeight)
            ])
        
        NSLayoutConstraint.activate([
            houseName.topAnchor.constraint(equalTo: houseImage.bottomAnchor),
            houseName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            houseName.trailingAnchor.constraint(equalTo: contentView.leadingAnchor),
            houseName.bottomAnchor.constraint(equalTo: houseImage.bottomAnchor, constant: labelHeight)
            ])
        
        NSLayoutConstraint.activate([
            money.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            money.trailingAnchor.constraint(equalTo: contentView.centerXAnchor),
            money.topAnchor.constraint(equalTo: houseName.bottomAnchor),
            money.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
            ])
        
        NSLayoutConstraint.activate([
            houseType.leadingAnchor.constraint(equalTo: contentView.centerXAnchor),
            houseType.topAnchor.constraint(equalTo: houseName.bottomAnchor),
            houseType.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            houseType.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
            ])
    }
    
    func configure(image: String, houseName: String, money: String, houseType: String){
        self.houseImage.image = UIImage(named: image)
        self.houseName.text = houseName
        self.money.text = money
        self.houseType.text = houseType
    }
    
}
