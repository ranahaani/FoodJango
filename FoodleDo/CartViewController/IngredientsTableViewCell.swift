
//  IngredientsTableViewCell.swift
//  cookit
//
//  Created by Muhammad Abdullah on 07/01/2019.
//  Copyright © 2019 Muhammad Abdullah. All rights reserved.
//

import UIKit
import M13Checkbox
class IngredientsTableViewCell: UITableViewCell {
    
    
    let VariationSize:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont(name: "SourceSansPro-Regular", size: 18)
        return label
    }()
    let VariationName:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont(name: "SourceSansPro-Regular", size: 18)
        return label
    }()
    let VariationPrice:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont(name: "SourceSansPro-Regular", size: 28)
        return label
    }()
    
    
    let checkbox = M13Checkbox(frame: CGRect(x: 0.0, y: 0.0, width: 20.0, height: 20.0))
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addLabel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    fileprivate func addLabel(){
        
        // addSubview(cellLabel)
        addSubview(checkbox)
        addSubview(VariationPrice)
        addSubview(VariationSize)
        checkbox.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            checkbox.widthAnchor.constraint(equalToConstant: 20),
            checkbox.heightAnchor.constraint(equalToConstant: 20),
            checkbox.leadingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 335),
            //checkbox.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            checkbox.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            checkbox.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 10),
            ])
        
        NSLayoutConstraint.activate([
            VariationPrice.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            VariationPrice.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 250),
            ])
        NSLayoutConstraint.activate([
           VariationSize.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
           VariationSize.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            ])
    }
    
}
