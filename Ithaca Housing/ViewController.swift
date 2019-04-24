//
//  ViewController.swift
//  Ithaca Housing
//
//  Created by RachelZheng on 22/4/2019.
//  Copyright © 2019 YISU ZHENG. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var rankingBarCollectionView: UICollectionView!
    var housingCollectionView: UICollectionView!
    var rankArray: [Ranks]!
    var housingArray: [Houses]!
    
    let houseCellReuseIdentifier = "houseCellReuseIdentifier"
    let rankCellReuseIdentifier = "rankCellReuseIdentifier"
    let padding: CGFloat = 8

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "Ithaca Housing"
        view.backgroundColor = .white
        
        let byName = Ranks(rankName: "Rank by Name")
        let byPrice = Ranks(rankName: "Rank by Price")
        let byPostDate = Ranks(rankName: "Rank by Post Date")
        rankArray = [byName, byPrice, byPostDate]
        
        let house1 = Houses(houseName: "Collegetown Crossing", houseLocation: "307 College Ave", housePrice: 1350, houseImage: "Collegetown Crossing", houseContact: "607-123-4567", houseDescription: "Close to bus stop and grocery store", houseType: "4b2b", postDate: "4.20")
        
        housingArray=[house1]
        
        // Setup Collection View
        // UICollectionViewFlowLayout is used to help organize our cells/items into a grid-pattern
        let rankLayout = UICollectionViewFlowLayout()
        rankLayout.scrollDirection = .horizontal
        rankLayout.minimumInteritemSpacing = padding
        rankLayout.minimumLineSpacing = padding
        
        let housingLayout = UICollectionViewFlowLayout()
        housingLayout.scrollDirection = .vertical
        housingLayout.minimumLineSpacing = padding
        housingLayout.minimumInteritemSpacing = padding
        
        rankingBarCollectionView = UICollectionView(frame: .zero, collectionViewLayout: rankLayout)
        rankingBarCollectionView.translatesAutoresizingMaskIntoConstraints = false
        rankingBarCollectionView.backgroundColor = .white
//        rankingBarCollectionView.dataSource = self
//        rankingBarCollectionView.delegate = self
        rankingBarCollectionView.allowsMultipleSelection = true
        rankingBarCollectionView.register(RankViewCell.self, forCellWithReuseIdentifier: rankCellReuseIdentifier)
        view.addSubview(rankingBarCollectionView)
        
        housingCollectionView = UICollectionView(frame: .zero, collectionViewLayout: housingLayout)
        housingCollectionView.translatesAutoresizingMaskIntoConstraints = false
        housingCollectionView.backgroundColor = .white
//        housingCollectionView.dataSource = self
//        housingCollectionView.delegate = self
//        housingCollectionView.register(HousingViewCell.self, forCellWithReuseIdentifier: houseCellReuseIdentifier)
        view.addSubview(housingCollectionView)
        
        setupConstraints()
    }
    func setupConstraints(){
        NSLayoutConstraint.activate([
            rankingBarCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            rankingBarCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            rankingBarCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            rankingBarCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            housingCollectionView.topAnchor.constraint(equalTo: rankingBarCollectionView.bottomAnchor),
            housingCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            housingCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            housingCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
            ])
    }
}

extension ViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        <#code#>
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        <#code#>
    }
    
    
}

extension ViewController: UICollectionViewDelegate{
    
}

extension ViewController: UICollectionViewDelegateFlowLayout{
    
}
