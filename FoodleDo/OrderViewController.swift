//
//  OrderViewController.swift
//  FoodleDo
//
//  Created by Muhammad Abdullah on 18/01/2019.
//  Copyright © 2019 l1f14bscs0033. All rights reserved.
//

import UIKit
import Alamofire
class OrderViewController: UIViewController {
    @IBOutlet weak var foodPrice: UILabel!
    @IBOutlet weak var foodName: UILabel!
    @IBOutlet weak var foodImage: UIImageView!
    @IBOutlet weak var foodDescription: UILabel!
    fileprivate lazy var orderButton:UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .orange
        btn.setTitle("Add to Cart", for: .normal)
        btn.layer.cornerRadius = 5
        btn.titleLabel?.font = UIFont(name: "Avenir", size: 26)
        btn.addTarget(nil, action: #selector(orderNow(_:)), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(orderButton)
        callApi()
        // Do any additional setup after loading the view.
    }
    
    @objc func orderNow(_ sender: UIButton){
        callApi()
    }
    
    func callApi(){
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
        dateFormatter.string(from: date)
        print(dateFormatter)
        let parameters = [
            "user_id" : 1,
            "order_date" : dateFormatter,
            "restaurant_id":"2",
            "order_time": "1232",
            "price":"565",
            "fooditem_id":"ds",
            "variation_id":"dsd",
            "vprice":"dsd",
            "order_token":56,
            ]
            as [String : Any]
        
        
        let url = URL(string: "https://foodjango.000webhostapp.com/order.php")
        Alamofire.request(url!, method: .post, parameters: parameters).responseJSON{ response  in
            if response.result.isSuccess{
                let json = response.result.value as? [Any]
               print(json)
            }
            else{
                print(response.result.error!)
            }
        }
    }
    
    func setup(){
        orderButton.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -30).isActive = true
        orderButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        orderButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        orderButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
        
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
