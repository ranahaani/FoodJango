//
//  RestArea.swift
//  FoodleDo
//
//  Created by apple on 08/09/2018.
//  Copyright © 2018 l1f14bscs0033. All rights reserved.
//

import Foundation
class RestArea: NSObject {
    
    var restarea_id: String?
    var name : String?
    var latitude : String?
    var longitude : String?
    var bound : String?
    var location_id : String?
   

    init?(dic : [String: Any]) {
        self.restarea_id = dic["restarea_id"] as? String
        self.name = dic["name"] as? String
        self.latitude = dic["latitude"] as? String
        self.longitude = dic["longitude"] as? String
        self.bound = dic["bound"] as? String
        self.location_id = dic["locatiopn_id"] as? String
    }
    
}
