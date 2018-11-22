//
//  Restaurants.swift
//  FoodleDo
//
//  Created by ibrahim khan on 18/09/2018.
//  Copyright © 2018 l1f14bscs0033. All rights reserved.
//

import Foundation
class Restauratns: NSObject {
    
    var Restaurant_id: String?
    var region : String?
    var postalcode : String?
    var city : String?
    var street : String?
    var postal_address : String?
    var situated_on_motorway : String?
    var situated_on_way_to : String?
    var phone_number : String?
    var rest_area_location : String?
    var name : String?
    var country : String?
    var restaurant_type : String?
    var mobile_number : String?
    var image : String?
    var location_id: String?
    
    init?(dic : [String: Any]) {
        self.Restaurant_id = dic["Restaurant_id"] as? String
        self.region = dic["region"] as? String
        self.postalcode = dic["postalcode"] as? String
        self.city = dic["city"] as? String
        self.street = dic["street"] as? String
        self.postal_address = dic["postal_address"] as? String
        self.situated_on_motorway = dic["situated_on_motorway"] as? String
        self.situated_on_way_to = dic["situated_on_way_to"] as? String
        self.phone_number = dic["phone_number"] as? String
        self.rest_area_location = dic["rest_area_location"] as? String
        self.name = dic["name"] as? String
        self.country = dic["country"] as? String
        self.restaurant_type = dic["restaurant_type"] as? String
        self.mobile_number = dic["mobile_number"] as? String
        self.image = dic["image"] as? String
        self.location_id = dic["location_id"] as? String
        
    }
    
}
