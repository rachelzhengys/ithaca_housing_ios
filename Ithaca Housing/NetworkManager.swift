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
    
    private static let normalEndpoint = "http://35.237.181.113/api/houses?sort_options=1"
    private static let dateEndpoint = "http://35.237.181.113/api/houses?sort_options=0"
    private static let priceHightoLowEndpoint = "http://35.237.181.113/api/houses?sort_options=3"
    private static let priceLowtoHighEndpoint = "http://35.237.181.113/api/houses?sort_options=2"
    
    
    static func getHousesNormal(completion: @escaping ([Houses]) -> Void){
        print ("getHouse Normal called")
        Alamofire.request(normalEndpoint, method:.get).validate().responseData { response in
            print ("start case analysis")
            switch response.result{
            case .success(let data):
                print ("successfully get houses")
                let jsonDecoder = JSONDecoder()
                if let houseResponse = try? jsonDecoder.decode(HouseResponse.self, from: data){
                    let houses = houseResponse.data
                    print ("decode complete")
                    completion(houses)
                }
            case .failure(let error):
                print ("failed to get houses")
                print(error.localizedDescription)
            }
            
        }
    }
    static func getHousesDate(completion: @escaping ([Houses]) -> Void){
        Alamofire.request(dateEndpoint, method:.get).validate().responseData { response in
            switch response.result{
            case .success(let data):
                let jsonDecoder = JSONDecoder()
                if let houseResponse = try? jsonDecoder.decode(HouseResponse.self, from: data){
                    let houses = houseResponse.data
                    completion(houses)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
            
        }
    }
    static func getHousesPriceHightoLow(completion: @escaping ([Houses]) -> Void){
        Alamofire.request(priceHightoLowEndpoint, method:.get).validate().responseData { response in
            switch response.result{
            case .success(let data):
                let jsonDecoder = JSONDecoder()
                if let houseResponse = try? jsonDecoder.decode(HouseResponse.self, from: data){
                    let houses = houseResponse.data
                    completion(houses)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
            
        }
    }
    static func getHousesPriceLowtoHigh(completion: @escaping ([Houses]) -> Void){
        Alamofire.request(priceLowtoHighEndpoint, method:.get).validate().responseData { response in
            switch response.result{
            case .success(let data):
                let jsonDecoder = JSONDecoder()
                if let houseResponse = try? jsonDecoder.decode(HouseResponse.self, from: data){
                    let houses = houseResponse.data
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
