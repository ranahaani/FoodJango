//
//  MenuViewController.swift
//  FoodleDo
//
//  Created by apple on 17/09/2018.
//  Copyright © 2018 l1f14bscs0033. All rights reserved.
//

import UIKit
import ScrollableSegmentedControl
import Alamofire
class MenuViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
  

    @IBOutlet weak var resturantImage: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    var restAreaId = String()
    var menuList = [Menu]()
    var indexPath = 0
    var restauratnsList = [Restauratns]()
    var menuDetailList = [MenuDetails]()
    @IBOutlet weak var segmentControl: ScrollableSegmentedControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.callApi()
        self.callApi_2()
        segmentControl.underlineSelected = true
        segmentControl.tintColor = UIColor.white
        segmentControl.segmentContentColor = UIColor.white
        segmentControl.selectedSegmentContentColor = UIColor.white
        segmentControl.backgroundColor = UIColor.blue
        segmentControl.addTarget(self, action: #selector(segmentSelected(sender:)), for: .valueChanged)
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
        
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            tableView.backgroundView = refreshControl
        }
        //print(restauratnsList,"Test")
        //resturantImage.sd_setImage(with: URL(string: restauratnsList[indexPath].image!), placeholderImage: UIImage(named: "placeholder.png"))
        //print(resturantImage.image,"ImageView")
    }
    @objc func refresh(_ refreshControl: UIRefreshControl) {
        tableView.reloadData()
        refreshControl.endRefreshing()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MenuDetailTableViewCell1
        if segmentControl.selectedSegmentIndex == 0{
            cell.textLabel?.text = "Abdullah"
            cell.NameTitleLable?.text = menuDetailList[indexPath.row].name
            cell.detailTextLabel?.text = menuDetailList[indexPath.row].food_description
        }
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @objc func segmentSelected(sender:ScrollableSegmentedControl) {
        print("Segment at index \(sender.selectedSegmentIndex)  selected")
        switch sender.selectedSegmentIndex{
        case 0:
           print("Segment at index \(sender.selectedSegmentIndex)  selected")
        case 1:
           print("Segment at index \(sender.selectedSegmentIndex)  selected")
        case 2:
            print("Segment at index \(sender.selectedSegmentIndex)  selected")
        default:
            break;
        }
    }
    func segmentControlView(){
        for i in 0...menuList.count-1{
            segmentControl.selectedSegmentIndex = 0
            segmentControl.insertSegment(withTitle: "\(menuList[i].name ?? "nil")", at: i)
        }
    }
    func callApi(){
        let params:Parameters = [
            "token": "abc123xyz",
            "restaurantid":restAreaId
        ]
        let url = URL(string: "https://foodietestapi.000webhostapp.com/menu.php")
        Alamofire.request(url!, method: .get, parameters: params).responseJSON{ response  in
            if response.result.isSuccess{
                let json = response.result.value as! [Any]
                for obj in json {
                    if let menu = Menu.init(dic: obj as! [String : Any]) {
                        self.menuList.append(menu)
                    }
                    else{
                        print("error")
                    }
                }
                self.segmentControlView()
            }
            else{
                print(response.result.error!)
            }
        }
        tableView.reloadData()
    }
    func callApi_2(){
        let params:Parameters = [
            "token": "abc123xyz",
            "restaurantid":restAreaId
        ]
        let url = URL(string: "https://foodietestapi.000webhostapp.com/menu_details.php")
        Alamofire.request(url!, method: .get, parameters: params).responseJSON{ response  in
            if response.result.isSuccess{
                let json = response.result.value as! [Any]
                for obj in json {
                    if let menuDetail = MenuDetails.init(dic: obj as! [String : Any]) {
                        self.menuDetailList.append(menuDetail)
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
