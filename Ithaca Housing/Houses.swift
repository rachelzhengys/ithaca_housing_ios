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
    var price: String
    var image: String
    var contact: String
    var description: String
    var type: String
    var postDate: String
    
    
    init(houseName: String, houseLocation: String, housePrice: String, houseImage: String, houseContact: String, houseDescription: String, houseType: String, postDate: String) {
        self.name = houseName
        self.location = houseLocation
        self.image = houseImage
        self.price = housePrice
        self.contact = houseContact
        self.description = houseDescription
        self.type = houseType
        self.postDate = postDate
}
}
