//
//  RestaurantsViewController.swift
//  FoodleDo
//
//  Created by apple on 17/09/2018.
//  Copyright © 2018 l1f14bscs0033. All rights reserved.
//

import UIKit
import SDWebImage
import Alamofire
class RestaurantsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var restAreaId = String()
    var restauratnsList = [Restauratns]()
    @IBOutlet weak var restaurantTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
        if #available(iOS 10.0, *) {
            restaurantTableView.refreshControl = refreshControl
        } else {
            restaurantTableView.backgroundView = refreshControl
        }
        self.callApi()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restauratnsList.count
    }
    @objc func refresh(_ refreshControl: UIRefreshControl) {
        restaurantTableView.reloadData()
        refreshControl.endRefreshing()
    }

    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantsTableViewCell", for: indexPath) as! RestaurantsTableViewCell
        cell.restaurantNameLabel.text = restauratnsList[indexPath.row].name
        cell.restaurantImageView.sd_setImage(with: URL(string: restauratnsList[indexPath.row].image ?? "Default"), placeholderImage: UIImage(named: "placeholder.png"))
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "MenuViewController") as! MenuViewController
        vc.restAreaId = self.restAreaId
        vc.indexPath = indexPath.row + 7
        if restauratnsList[indexPath.row].image != nil{
            let myImage = UIImage(named:restauratnsList[indexPath.row].image!)
            let image = UIImageView(image: myImage)
            image.sd_setImage(with: URL(string: restauratnsList[indexPath.row].image!), placeholderImage: UIImage(named: "placeholder.png"))
            vc.restauratnsList = self.restauratnsList
            vc.resturantImage = image
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func callApi(){
        let params:Parameters = [
            "token": "abc123xyz",
            "restarea_id":restAreaId,
            "time": "6:30",
            "day": "monday"
        ]
        let url = URL(string: "https://foodjango.000webhostapp.com/restaurant.php")
         Alamofire.request(url!, method: .get, parameters: params).responseJSON{ response  in
            if response.result.isSuccess{
                let json = response.result.value as! [Any]
                print(json,"JSON Data")
                for obj in json {
                    if let restaurant = Restauratns.init(dic: obj as! [String : Any]) {
                        self.restauratnsList.append(restaurant)
                        print(restaurant.image,"Resturant Details")
                        self.restaurantTableView.reloadData()
                    }
                    else{
                        print("error")
                    }
                }
            }
            else{
                print(response.result.error!)
            }
        }
    }

}
