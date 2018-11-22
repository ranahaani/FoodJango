//
//  MenuDetailTableViewCell1.swift
//  FoodleDo
//
//  Created by ibrahim khan on 26/09/2018.
//  Copyright © 2018 l1f14bscs0033. All rights reserved.
//

import UIKit

class MenuDetailTableViewCell1: UITableViewCell {
    
    
    @IBOutlet weak var DescriptionLable: UILabel!
    @IBOutlet weak var Imageincell: UIImageView!
    @IBOutlet weak var NameTitleLable: UILabel!
    
    @IBOutlet weak var PriceLable: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
