//
//  OrderViewController.swift
//  FoodleDo
//
//  Created by Muhammad Abdullah on 18/01/2019.
//  Copyright © 2019 l1f14bscs0033. All rights reserved.
//

import UIKit

class OrderViewController: UIViewController {
    fileprivate lazy var orderButton:UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .orange
        btn.setTitle("Add to Cart", for: .normal)
        btn.layer.cornerRadius = 5
        btn.titleLabel?.font = UIFont(name: "Avenir", size: 26)
        btn.addTarget(nil, action: #selector(loginClicked(_:)), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
