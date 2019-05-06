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
        houseImage.layer.cornerRadius = 5
        contentView.addSubview(houseImage)
        
//        houseName = UILabel(frame: .zero)
//        houseName.translatesAutoresizingMaskIntoConstraints = false
//        houseName.font = UIFont.init(name: "Quicksand-Bold", size: 20)
//        houseName.textAlignment = .center
////        houseName.font = UIFont.boldSystemFont(ofSize: 12)
//        houseName.highlightedTextColor = .black
//        contentView.addSubview(houseName)
        
        money = UILabel(frame: .zero)
        money.translatesAutoresizingMaskIntoConstraints = false
        money.font = UIFont.init(name: "OstrichSans-Black", size: 18)
//        money.textAlignment = .center
//        money.font = UIFont.systemFont(ofSize: 10)
        money.textColor = .gray
        contentView.addSubview(money)
        
        houseType = UILabel(frame: .zero)
        houseType.translatesAutoresizingMaskIntoConstraints = false
        houseType.font = UIFont.init(name: "HelveticaNeue-Medium", size: 25)
//        houseType.textAlignment = .center
//        houseType.font = UIFont.systemFont(ofSize: 10)
        contentView.addSubview(houseType)
        
        updateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func updateConstraints() {
        super.updateConstraints()
        
        NSLayoutConstraint.activate([
            houseImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            houseImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            houseImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            houseImage.bottomAnchor.constraint(equalTo: money.topAnchor),
            ])
        
        
        NSLayoutConstraint.activate([
            money.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            money.trailingAnchor.constraint(equalTo: contentView.centerXAnchor),
            money.topAnchor.constraint(equalTo: houseType.topAnchor, constant: -10),
            money.heightAnchor.constraint(equalToConstant: 20)
            ])
        
        NSLayoutConstraint.activate([
            houseType.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            houseType.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 5),
            houseType.heightAnchor.constraint(equalToConstant: 30),
            houseType.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
            ])
    }
    
    @objc func getHouseImage(url: String){
        NetworkManager.fetchHouseImage (imageURL: url){(houseImage) in
            DispatchQueue.main.async {
                self.houseImage.image = houseImage
            }
        }}
    func configure(imageUrl: String, money: String, houseType: String){
        getHouseImage(url: imageUrl)
        self.money.text = money
        self.houseType.text = houseType
    }
    
}
