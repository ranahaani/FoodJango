//
//  SignUpViewController.swift
//  FoodleDo
//
//  Created by ibrahim khan on 16/11/2018.
//  Copyright © 2018 l1f14bscs0033. All rights reserved.
//

import UIKit
import Alamofire

class SignUpViewController: UIViewController {

    @IBOutlet weak var NameTextField: UITextField!
    @IBOutlet weak var UserNameTextField: UITextField!
    @IBOutlet weak var EmailTetField: UITextField!
    @IBOutlet weak var MobileNoTextField: UITextField!
    @IBOutlet weak var PasswordTextField: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated);
        super.viewWillDisappear(animated)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func Signup(_ sender: UIButton){
        
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let secondViewController = mainStoryboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        self.navigationController!.pushViewController(secondViewController, animated: true)

    }
    @IBAction func SignUpButton(_ sender: Any) {
    
        if NameTextField.text == "" || UserNameTextField.text == "" || EmailTetField.text == "" || MobileNoTextField.text == "" || PasswordTextField.text == ""
        {
            let alert = UIAlertController(title: "Alert", message: "Please Fill Empty Fields", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: { (action) in alert.dismiss(animated: true, completion: nil)
            }))
            self.present(alert, animated: true, completion: nil)
        }
        else{
            
            let params:Parameters = [
                "user_type":"0",
                "name":NameTextField.text!,
                "mobile_number": MobileNoTextField.text!,
                "email":EmailTetField.text!,
                "password":PasswordTextField.text!,
                "username":UserNameTextField.text!,
                "restaurant_id":"",
                "location_id":""
                
                
            ]
            let url = URL.init(string: "https://foodjango.000webhostapp.com/register.php")
            Alamofire.request(url!, method: .post, parameters: params).responseJSON {
                (response) in
                if let Json = response.result.value{
                    print(Json)
                    let dic = Json as! Dictionary<String,AnyObject>
                    //let dic2 = dic.first
                    let token = dic["user_api_token"]
                    if token != nil{
                        UserDefaults.standard.set(token, forKey: "token")
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let vc = storyboard.instantiateViewController(withIdentifier: "RestAreaViewController") as! RestAreaViewController
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                }
            }
        }
    }

}
