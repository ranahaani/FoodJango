//
//  Menu.swift
//  FoodleDo
//
//  Created by ibrahim khan on 18/09/2018.
//  Copyright © 2018 l1f14bscs0033. All rights reserved.
//

import Foundation
class Menu: NSObject {
    var category_id: String?
    var title : String?
    var restaurant_id : String?
    
    init?(dic : [String: Any]) {
        self.category_id=dic["category_id"] as? String
        self.title = dic["title"] as? String
        self.restaurant_id = dic["restaurant_id"] as? String
    }
}

