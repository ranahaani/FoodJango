//
//  CartViewController.swift
//  FoodleDo
//
//  Created by Muhammad Abdullah on 14/01/2019.
//  Copyright © 2019 l1f14bscs0033. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD
class CartViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {
    //    fileprivate lazy var bgImage:UIImageView={
    //        let image = UIImageView()
    //        image.image = UIImage(named: "bgImage.png")
    //        image.contentMode = .scaleAspectFill
    //        image.translatesAutoresizingMaskIntoConstraints = false
    //        return image
    //    }()
    var variation = [Variations]()
      var BannerImage:UIImageView={
        let image = UIImageView()
        image.image = UIImage(named: "Default")
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    fileprivate lazy var bannerView:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(rgb: 0x101F30).withAlphaComponent(0.3)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
     var recipeName:UILabel = {
        let label = UILabel()
        label.text = "Spinach & chicken Salad"
        label.textAlignment = .center
        label.font = UIFont(name: "Avenir", size: 15)//Helvetica
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
     var recipePrice:UILabel = {
        let label = UILabel()
        label.text = "Spinach & chicken Salad"
        label.textAlignment = .center
        label.font = UIFont(name: "SourceSansPro-Black", size: 18)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let tableView : UITableView = {
        let t = UITableView()
        t.translatesAutoresizingMaskIntoConstraints = false
        return t
    }()
    
    fileprivate lazy var orderButton:UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .orange
        btn.setTitle("Add to Cart", for: .normal)
        btn.layer.cornerRadius = 5
        btn.titleLabel?.font = UIFont(name: "Avenir", size: 26)
        btn.addTarget(nil, action: #selector(addToCartNow(_:)), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    var foodItems:String?
    override func viewDidLoad() {
        super.viewDidLoad()
        SVProgressHUD.show()
        callApi()
//        Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
        view.backgroundColor = .white
        navigationItem.title = "Cart"
        
        [tableView,recipeName,recipePrice,BannerImage,bannerView, orderButton].forEach{view.addSubview($0)}

        tableView.separatorColor = view.backgroundColor
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(IngredientsTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.backgroundColor = view.backgroundColor
        
        setupViews()
        
        
    }
    //    @objc func backButtonPressed(_ sender: UIButton){
    //        print("Clicked")
    //        navigationController?.popToRootViewController(animated: true)
    //    }
    //
    @objc func timerAction() {
        SVProgressHUD.dismiss()
        tableView.reloadData()
    }
    func callApi(){
        SVProgressHUD.show()
        let params:Parameters = [
            "token": "abc123xyz",
            "fooditem_id":4
        ]
        let url = URL(string: "https://foodjango.000webhostapp.com/variations.php")
        Alamofire.request(url!, method: .get, parameters: params).responseJSON{ response  in
            if response.result.isSuccess{
                let json = response.result.value as? [Any]
                for obj in json! {
                    if let vari = Variations.init(dic: obj as! [String : Any]) {
                       self.variation.append(vari)
                    }
                    else{
                        print("error")
                    }
                }
                SVProgressHUD.dismiss()
            }
            else{
                print(response.result.error!)
            }
        }
        //tableView.reloadData()
    }
    @objc func addToCartNow(_ sender: UIButton){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "OrderViewController") as! OrderViewController
        vc.foodImage = BannerImage
//        vc.foodName.text =  recipeName.text
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor.clear
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return variation.count
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 150.0
//    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! IngredientsTableViewCell
        cell.checkbox.boxType = .square
        cell.VariationName.text = "Name"
        cell.VariationSize.text = variation[indexPath.row].size
        cell.VariationPrice.text = variation[indexPath.row].price
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // etc
    }
    
    
    func setupViews(){
        //tableView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        orderButton.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -30).isActive = true
        orderButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        orderButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        orderButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
        
        
        
        
        tableView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: 0).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5).isActive = true
        tableView.topAnchor.constraint(equalTo: recipePrice.bottomAnchor, constant: 5).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 10).isActive = true
        
        
        
        recipePrice.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        recipePrice.heightAnchor.constraint(equalToConstant: 22).isActive = true
        recipePrice.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        recipePrice.topAnchor.constraint(equalTo: recipeName.bottomAnchor, constant: 8).isActive = true
        
        
        
        recipeName.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        recipeName.heightAnchor.constraint(equalToConstant: 22).isActive = true
        recipeName.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        recipeName.topAnchor.constraint(equalTo: BannerImage.bottomAnchor, constant: 20).isActive = true
        
        
        
        
        bannerView.widthAnchor.constraint(equalTo: BannerImage.widthAnchor).isActive = true
        bannerView.heightAnchor.constraint(equalToConstant:260).isActive = true
        bannerView.topAnchor.constraint(equalTo: BannerImage.topAnchor).isActive = true
        bannerView.bottomAnchor.constraint(equalTo: BannerImage.bottomAnchor).isActive = true
        
        
        BannerImage.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        BannerImage.heightAnchor.constraint(equalToConstant:260).isActive = true
        BannerImage.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        BannerImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        
        //Background Image
        //        bgImage.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        //        bgImage.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        //        bgImage.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        //        bgImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
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
extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
}
