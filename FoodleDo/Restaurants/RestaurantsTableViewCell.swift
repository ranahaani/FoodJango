//
//  RestaurantsTableViewCell.swift
//  FoodleDo
//
//  Created by apple on 17/09/2018.
//  Copyright © 2018 l1f14bscs0033. All rights reserved.
//

import UIKit

class RestaurantsTableViewCell: UITableViewCell {

    @IBOutlet weak var restaurantNameLabel: UILabel!
    @IBOutlet weak var restaurantImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
