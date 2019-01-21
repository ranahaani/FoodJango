//
//  Variations.swift
//  FoodleDo
//
//  Created by Muhammad Abdullah on 15/01/2019.
//  Copyright © 2019 l1f14bscs0033. All rights reserved.
//

import Foundation
class Variations: NSObject {
    var variation_id: String?
    var name : String?
    var size : String?
    var fooditem_id:String?
    var price:String?
    
    init?(dic : [String: Any]) {
        self.variation_id = dic["variation_id"] as? String
        self.name = dic["name"] as? String
        self.size = dic["size"] as? String
        self.fooditem_id = dic["fooditem_id"] as? String
        self.price = dic["price"] as? String
        
    }
}

