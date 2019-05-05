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
    var imageUrl: String
    var description: String
    var type: String
    var postDate: String
    var url: String
}

struct HouseDataResponse: Codable {
    var houses: [Houses]
}

struct HouseResponse: Codable {
    var data: HouseDataResponse
}
