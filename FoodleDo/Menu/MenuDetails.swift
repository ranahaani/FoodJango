//
//  MenuDetails.swift
//  FoodleDo
//
//  Created by ibrahim khan on 26/09/2018.
//  Copyright © 2018 l1f14bscs0033. All rights reserved.
//

import Foundation
class MenuDetails: NSObject {
    
    var name: String?
    var food_name : String?
    var food_description : String?
    var price : String?
    
    init?(dic : [String: Any]) {
        self.name = dic["name"] as? String
        self.food_name = dic["food_name"] as? String
        self.food_description = dic["food_description"] as? String
        self.price = dic["price"] as? String
    }
}
