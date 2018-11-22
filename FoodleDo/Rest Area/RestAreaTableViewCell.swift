//
//  RestAreaTableViewCell.swift
//  FoodleDo
//
//  Created by apple on 08/09/2018.
//  Copyright © 2018 l1f14bscs0033. All rights reserved.
//

import UIKit

class RestAreaTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
