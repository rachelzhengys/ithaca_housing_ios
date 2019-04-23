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
    
    let restCellReuseIdentifier = "restCellReuseIdentifier"
    let filterCellReuseIdentifier = "filterCellReuseIdentifier"
    let padding: CGFloat = 8

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
}

