//
//  Houses.swift
//  Ithaca Housing
//
//  Created by RachelZheng on 23/4/2019.
//  Copyright © 2019 YISU ZHENG. All rights reserved.
//

import Foundation

struct Houses: Codable {
    
    var location: String
    var price: Int
    var imageurl: String
    var description: String
    var type: String
    var postdate: String
    var houseurl: String
}

struct HouseResponse: Codable {
    var data: [Houses]
}
