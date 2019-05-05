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
    var housingArray: [Houses] = []
    var titleView: UILabel!
    
    let houseCellReuseIdentifier = "houseCellReuseIdentifier"
    let rankCellReuseIdentifier = "rankCellReuseIdentifier"
    let padding: CGFloat = 8
    
    override func viewDidLoad() {
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
    // view.font = UIFont(name: "HelveticaNeue-Medium", size: 24)
    view.addSubview(titleView)
    // Line height: 29 pt

        titleView.text = "Ithaca Housing"
        let byPrice = Ranks(rankName: "Rank by Price")
        let byPostDate = Ranks(rankName: "Rank by Post Date")
        rankArray = [byPrice, byPostDate]
        
        
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
        rankingBarCollectionView.dataSource = self
        rankingBarCollectionView.delegate = self
        rankingBarCollectionView.allowsMultipleSelection = true
        rankingBarCollectionView.register(RankViewCell.self, forCellWithReuseIdentifier: rankCellReuseIdentifier)
        view.addSubview(rankingBarCollectionView)
        
        housingCollectionView = UICollectionView(frame: .zero, collectionViewLayout: housingLayout)
        housingCollectionView.translatesAutoresizingMaskIntoConstraints = false
        housingCollectionView.backgroundColor = .white
        housingCollectionView.dataSource = self
        housingCollectionView.delegate = self
        housingCollectionView.register(HousingViewCell.self, forCellWithReuseIdentifier: houseCellReuseIdentifier)
        view.addSubview(housingCollectionView)
        
        setupConstraints()
        getHouses()
    }
    
    func setupConstraints(){
        NSLayoutConstraint.activate([
            titleView.widthAnchor.constraint(equalToConstant: 167),
            titleView.heightAnchor.constraint(equalToConstant: 29),
            titleView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 30),
            titleView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        ])

        NSLayoutConstraint.activate([
            rankingBarCollectionView.topAnchor.constraint(equalTo: titleView.bottomAnchor, constant: 10),
            rankingBarCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            rankingBarCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            rankingBarCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])

        NSLayoutConstraint.activate([
            housingCollectionView.topAnchor.constraint(equalTo: rankingBarCollectionView.bottomAnchor, constant: 10),
            housingCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            housingCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            housingCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
            ])
    }
    
    func getHouses(){
        NetworkManager.getHouses { houses in
            self.housingArray = houses
            
        }
    }
    
    @objc func pushCrossingController(){
        let crossing = ModalViewController(houseHolder: housingArray[0])
        crossing.delegate = self
        navigationController?.pushViewController(crossing, animated: true)
        
    }
    
//    func presentDetailView(selectedHouse:Houses) {
//        let modalViewController = ModalViewController(houseHolder: selectedHouse)
////        modalViewController.delegate = self
//        present(modalViewController, animated: true, completion: nil)
//    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == housingCollectionView{
            return housingArray.count
        }else{
            return rankArray.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == housingCollectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: houseCellReuseIdentifier, for: indexPath) as! HousingViewCell
            let house = housingArray[indexPath.item]
            cell.configure(image: house.image, money: house.price, houseType: house.type)
            cell.layer.borderColor = UIColor(red: 0.71, green: 0.76, blue: 0.96, alpha: 1).cgColor
            cell.layer.cornerRadius = 5
            cell.layer.borderWidth = 1
            return cell
        }
        //if collectionView is filterCollectionView
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:rankCellReuseIdentifier, for: indexPath) as! RankViewCell
        let ra = rankArray[indexPath.item]
        cell.configure(for: ra)
        //        cell.needsUpdateConstraints()
        cell.layer.borderColor = UIColor(red: 0.96, green: 0.81, blue: 0.71, alpha: 1).cgColor
        cell.layer.cornerRadius = 5
        cell.layer.borderWidth = 1
        return cell
    }
    

}

extension ViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Run some code upon tapping a cell
        if collectionView == housingCollectionView{
            pushCrossingController()
        }else{
        self.rankingBarCollectionView.allowsMultipleSelection=false
        let cell = collectionView.cellForItem(at: indexPath) as! RankViewCell
        let lastCellColor = cell.backgroundColor
        if lastCellColor == .white{
             //                print("tap to change color")
            if cell.isSelected {
                 cell.backgroundColor = .cyan
             }
         }else{
             if cell.isSelected {
                 cell.backgroundColor = .white
             }
         }
    }
    }
    
    func changeColor(cell: Ranks, _ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        let cell = collectionView.cellForItem(at: indexPath) as! RankViewCell
        let lastCellColor = cell.backgroundColor
        if lastCellColor == .white{
            if cell.isSelected {
                cell.backgroundColor = .cyan
            }
        }else{
            if cell.isSelected {
                cell.backgroundColor = .white
            }
        }
    }
    
    
}

extension ViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == housingCollectionView{
            // We want || padding IMAGE padding IMAGE padding ||
            let length = (collectionView.frame.width - padding * 3)/2.0
            return CGSize(width: length, height: length)
        }else{
            let filt_width = (collectionView.frame.width - padding*4)/2
            return CGSize(width: filt_width, height: 20)
        }
    }
}



