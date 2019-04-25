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
        
        let house1 = Houses(houseName: "Collegetown Crossing", houseLocation: "307 College Ave", housePrice: "$1350", houseImage: "collegetowncrossing", houseContact: "607-123-4567", houseDescription: "Close to bus stop and grocery store", houseType: "4b2b", postDate: "4.20")
        
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
    
//    @objc func presentModalViewController() {
//        // Create a view controller with a custom field (such as title).
//        let modalViewController = ModalViewController(placeholderText: presentModalViewControllerButton.title(for: .normal)!)
//        // Here, we set the ModalViewController's delegate to our ViewController so it
//        // can receive information from ModalViewController.
//        //
//        // This way, the modalViewController can call the method for when the button title changes
//        // and the method will be called inside this view controller (self)
//        modalViewController.delegate = self
//        present(modalViewController, animated: true, completion: nil)
//    }
//
//    @objc func pushNavViewController() {
//        let navViewController = NavViewController()
//        // This is how you push the NavViewController onto the navigation stack.
//        // navigationController is optional because we don't know whether or not this ViewController
//        // was implemented inside a NavigationController or not. (If it wasn't, nothing would happen)
//        //
//        // Now, NavViewController will be at the top of the navigation stack, and ViewController
//        // will be at the bottom of the stack. The order of a stack is last-in-first-out (LIFO),
//        // whereas queues are first-in-first-out (FIFO).
//        navigationController?.pushViewController(navViewController, animated: true)
//    }
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
            cell.configure(image: house.image, houseName: house.name, money: house.price, houseType: house.type)
            cell.layer.borderColor = UIColor.brown.cgColor
            cell.layer.borderWidth = 1
            return cell
        }
        //if collectionView is filterCollectionView
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:rankCellReuseIdentifier, for: indexPath) as! RankViewCell
        let ra = rankArray[indexPath.item]
        cell.configure(for: ra)
        //        cell.needsUpdateConstraints()
        
        cell.layer.borderColor = UIColor.purple.cgColor
        cell.layer.borderWidth = 1
        return cell
    }
}

extension ViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Run some code upon tapping a cell
        if collectionView == housingCollectionView{
            
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
    }}

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

//extension ViewController: ChangeViewControllerLabels {
//
//    func nameChange(new_name: String) {
//        songs[chosenIndex].name = new_name
//        tableView.reloadData()
//    }
//    func albumChange(new_album: String) {
//        songs[chosenIndex].album = new_album
//        tableView.reloadData()
//    }
//    func artistChange(new_artist: String) {
//        songs[chosenIndex].artist = new_artist
//        tableView.reloadData()
//    }
//}


