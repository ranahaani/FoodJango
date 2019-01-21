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
import SVProgressHUD
class MenuViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var segmentedControl: ScrollableSegmentedControl!
    
    @IBOutlet weak var resturantImage: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    var restAreaId = String()
    var menuList = [Menu]()
    var indexPath = 0
    var categoryid = String()
    var restauratnsList = [Restauratns]()
    var menuDetailList = [MenuDetails]()

    //@IBOutlet weak var segmentControl: UISegmentedControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SVProgressHUD.setForegroundColor(.orange)
        SVProgressHUD.show()
        Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
         resturantImage.sd_setImage(with: URL(string: restauratnsList[indexPath].image ?? "Default"), placeholderImage: UIImage(named: "placeholder.png"))
       segmentedControl.underlineSelected = true
       //segmentedControl.tintColor = UIColor.white
       segmentedControl.segmentContentColor = UIColor.black
       segmentedControl.selectedSegmentContentColor = UIColor.gray
       segmentedControl.backgroundColor = UIColor.white
        
       segmentedControl.addTarget(self, action: #selector(segmentSelected(sender:)), for: .valueChanged)
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
        
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            tableView.backgroundView = refreshControl
        }
        print(menuDetailList.count)
        
    }
    @objc func timerAction() {
        SVProgressHUD.dismiss()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
      // DispatchQueue.main.async {
            self.callApi()
       //}
        
       // self.callApi_2(1);

    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        
    }

    func segmentControlView(){
        
        if menuList.count>0{
            for i in 0..<menuList.count-1{
                segmentedControl.selectedSegmentIndex = 0
                callApi_2(6)
                segmentedControl.insertSegment(withTitle: "\(menuList[i].title ?? "nil")", at: i)
            }
        }
        
        print(menuList.count)

       
    }
    @objc func segmentSelected(sender:ScrollableSegmentedControl) {
    }
    @objc func refresh(_ refreshControl: UIRefreshControl) {
        tableView.reloadData()
        refreshControl.endRefreshing()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     
       return menuList.count


    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "CartViewController") as! CartViewController
        vc.BannerImage.sd_setImage(with: URL(string: menuDetailList[indexPath.row].image ?? "Default"), placeholderImage: UIImage(named: "Default"))
        vc.recipeName.text =  menuDetailList[indexPath.row].food_name
        vc.recipePrice.text = ("Rs - \(menuDetailList[indexPath.row].price ?? "Price")")
        vc.foodItems =  menuDetailList[indexPath.row].category_id
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuDetailTableViewCell", for: indexPath) as! MenuDetailTableViewCell1
            print(indexPath.row)
            cell.NameTitleLable?.text = menuDetailList[indexPath.row].food_name
            cell.DescriptionLable?.text = menuDetailList[indexPath.row].food_description
            cell.PriceLable.text = ("Rs - \(menuDetailList[indexPath.row].price ?? "Price")")
            cell.Imageincell.sd_setImage(with: URL(string: menuDetailList[indexPath.row].image ?? "Default"), placeholderImage: UIImage(named: "Default"))
    
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func delayWithSeconds(_ seconds: Double, completion: @escaping () -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            completion()
        }
    }
    func callApi(){
        let params:Parameters = [
            "token": "abc123xyz",
            "restaurant_id":restAreaId
        ]
        let url = URL(string: "https://foodjango.000webhostapp.com/menu.php")
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
        //tableView.reloadData()
    }
    func callApi_2(_ i: Int){
        print("haani here")
        let params:Parameters = [
            "token": "wjfnqwobfqfb",
            "restaurant_id":restAreaId,
            "category_id":i
        ]
        let url = URL(string: "https://foodjango.000webhostapp.com/menu_details.php")
        Alamofire.request(url!, method: .get, parameters: params).responseJSON{ response  in
            if response.result.isSuccess{
                let json = response.result.value as!  [ Any]
                for obj in json {
                    if let menuDetail = MenuDetails.init(dic: obj as! [String : Any]) {
                        self.menuDetailList.append(menuDetail)
                        print(menuDetail.food_name,"Menu Details")
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
