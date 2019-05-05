//
//  NetworkManager.swift
//  Ithaca Housing
//
//  Created by Youhan Yuan on 5/03/19.
//  Copyright © 2019 YISU ZHENG. All rights reserved.
//

import Foundation
import Alamofire

class NetworkManager {
    
    private static let endpoint = "www.baidu.com"
    
    
    static func getHouses(completion: @escaping ([Houses]) -> Void){
        Alamofire.request(endpoint, method:.get).validate().responseData { response in
            switch response.result{
            case .success(let data):
                let jsonDecoder = JSONDecoder()
                if let houseResponse = try? jsonDecoder.decode(HouseResponse.self, from: data){
                    let houses = houseResponse.data.houses
                    completion(houses)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
            
        }
    }
    static func fetchHouseImage(imageURL: String, completion: @escaping (UIImage) -> Void) {
        Alamofire.request(imageURL).validate().responseData { (response) in
            switch response.result {
            case .success(let data):
                if let houseImage = UIImage(data: data) {
                    completion(houseImage)
                } else {
                    print("Invalid Response Data")
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
    
    
}
