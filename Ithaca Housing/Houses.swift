//
//  Houses.swift
//  Ithaca Housing
//
//  Created by RachelZheng on 23/4/2019.
//  Copyright © 2019 YISU ZHENG. All rights reserved.
//

import Foundation

class Houses {
    
    var name: String
    var location: String
    var price: Int
    var image: String
    var contact: String
    var description: String
    var type: String
    var leaseDate: String
    
    
    init(houseName: String, houseLocation: String, housePrice: Int, houseImage: String, houseContact: String, houseDescription: String, houseType: String, houseLeaseDate: String) {
        self.name = houseName
        self.location = houseLocation
        self.image = houseImage
        self.price = housePrice
        self.contact = houseContact
        self.description = houseDescription
        self.type = houseType
        self.leaseDate = houseLeaseDate
}
}
