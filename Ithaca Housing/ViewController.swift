//
//  ViewController.swift
//  Ithaca Housing
//
//  Created by RachelZheng on 22/4/2019.
//  Copyright © 2019 YISU ZHENG. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let rankSegList = ["$ from low to high", "$ from high to low", "Rank by Post Date"]
    
    var rankingSegment: UISegmentedControl!
    var housingCollectionView: UICollectionView!
    var rankArray: [Ranks]!
    var housingArray: [Houses]!
    var titleView: UILabel!
    
    let houseCellReuseIdentifier = "houseCellReuseIdentifier"
    let rankCellReuseIdentifier = "rankCellReuseIdentifier"
    let padding: CGFloat = 8
    
    override func viewDidLoad() {
        housingArray = []
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        self.navigationController?.isNavigationBarHidden = true
        titleView = UILabel()
        titleView.backgroundColor = .white
        titleView.frame = CGRect(x: 0, y: 0, width: 167, height: 29)
        titleView.backgroundColor = .white
        titleView.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        titleView.text = "Ithaca Housing"
        titleView.translatesAutoresizingMaskIntoConstraints = false
    //  view.font = UIFont(name: "HelveticaNeue-Medium", size: 24)
        view.addSubview(titleView)

        let housingLayout = UICollectionViewFlowLayout()
        housingLayout.scrollDirection = .vertical
        housingLayout.minimumLineSpacing = padding
        housingLayout.minimumInteritemSpacing = padding
        
        rankingSegment = UISegmentedControl(items: rankSegList)
        rankingSegment.addTarget(self, action: #selector(updateRank), for: .valueChanged)
        rankingSegment.translatesAutoresizingMaskIntoConstraints = false
        rankingSegment.tintColor = UIColor.black
        view.addSubview(rankingSegment)
        
        housingCollectionView = UICollectionView(frame: .zero, collectionViewLayout: housingLayout)
        housingCollectionView.translatesAutoresizingMaskIntoConstraints = false
        housingCollectionView.backgroundColor = .white
        housingCollectionView.dataSource = self
        housingCollectionView.delegate = self
        housingCollectionView.register(HousingViewCell.self, forCellWithReuseIdentifier: houseCellReuseIdentifier)
        getHousesNormal()
        view.addSubview(housingCollectionView)
        
        setupConstraints()
//        print ("get house info now")
        updateRank()
    }
    
    func setupConstraints(){
        NSLayoutConstraint.activate([
            titleView.widthAnchor.constraint(equalToConstant: 150),
            titleView.heightAnchor.constraint(equalToConstant: 29),
            titleView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 20),
            titleView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10)
        ])

        NSLayoutConstraint.activate([
            rankingSegment.topAnchor.constraint(equalTo: titleView.bottomAnchor, constant: 5),
            rankingSegment.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant:10),
            rankingSegment.heightAnchor.constraint(equalToConstant: 25),
            rankingSegment.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10)
            ])

        NSLayoutConstraint.activate([
            housingCollectionView.topAnchor.constraint(equalTo: rankingSegment.bottomAnchor, constant: 10),
            housingCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            housingCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            housingCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -5)
            ])
    }
    
    @objc func updateRank(){
        let idx = rankingSegment.selectedSegmentIndex
        let current = (idx == UISegmentedControl.noSegment) ? "none" : rankSegList[idx]
        if current == "$ from low to high" {
            getHousePriceLowtoHigh()
        }
        else if current == "$ from high to low"{
            getHousePriceHightoLow()
        }
        else if current == "Rank by Post Date"{
            getHouseDate()
        }
        else{
            getHousesNormal()
        }
        
    }
    
    func getHousesNormal(){
        NetworkManager.getHousesNormal { houses in
            self.housingArray = houses
            self.housingCollectionView.reloadData()
        }
    }
    
    func getHouseDate(){
        NetworkManager.getHousesDate { houses in
            self.housingArray = houses
            self.housingCollectionView.reloadData()
        }
    }
    
    func getHousePriceHightoLow(){
        NetworkManager.getHousesPriceHightoLow{houses in
            self.housingArray = houses
            self.housingCollectionView.reloadData()
        }
    }
    
    func getHousePriceLowtoHigh(){
        NetworkManager.getHousesPriceLowtoHigh{houses in
            self.housingArray = houses
            self.housingCollectionView.reloadData()
        }
    }
    
    func presentDetailView(selectedHouse: Houses) {
        let modalViewController = ModalViewController(houseHolder: selectedHouse)
        modalViewController.delegate = self
        present(UINavigationController(rootViewController: modalViewController), animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return housingArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: houseCellReuseIdentifier, for: indexPath) as! HousingViewCell
            let house = housingArray[indexPath.item]
        cell.configure(imageUrl: house.imageurl, money: "$ "+String(house.price), houseType: "House Type: "+house.type)
            cell.layer.borderColor = UIColor(red: 0.71, green: 0.76, blue: 0.96, alpha: 1).cgColor
            cell.layer.cornerRadius = 5
            cell.layer.borderWidth = 1
            return cell
    }
}

extension ViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presentDetailView(selectedHouse: (housingArray?[indexPath.item])!)
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let length = (collectionView.frame.width - 6)
            let long = collectionView.frame.height/3
            return CGSize(width: length, height: long)
    }
}



