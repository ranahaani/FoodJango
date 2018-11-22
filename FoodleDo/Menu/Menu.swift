//
//  Menu.swift
//  FoodleDo
//
//  Created by ibrahim khan on 18/09/2018.
//  Copyright © 2018 l1f14bscs0033. All rights reserved.
//

import Foundation
class Menu: NSObject {
    
    var menu_id: String?
    var name : String?
    var restaurant_id : String?
    init?(dic : [String: Any]) {
        self.menu_id = dic["menu_id"] as? String
        self.name = dic["name"] as? String
        self.restaurant_id = dic["restaurant_id"] as? String
    }
}
