//
//  LoginViewController.swift
//  FoodleDo
//
//  Created by ibrahim khan on 04/09/2018.
//  Copyright © 2018 l1f14bscs0033. All rights reserved.
//

import UIKit
import Alamofire

class LoginViewController: UIViewController {

    @IBOutlet weak var passwordTxtField: UITextField!
    @IBOutlet weak var emailTxtField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTxtField.text = "ibii4466@gmail.com"
        passwordTxtField.text = "ibii"
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
    

    @IBAction func loginButtonAction(_ sender: Any) {
        if emailTxtField.text == "" || passwordTxtField.text == ""{
            let alert = UIAlertController(title: "Alert", message: "EMAIL IS EMPTY", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: { (action) in alert.dismiss(animated: true, completion: nil)
            }))
            self.present(alert, animated: true, completion: nil)
        }
        else{
            let params:Parameters = [
                "email":emailTxtField.text!,
                "password":passwordTxtField.text!
            ]
            let url = URL.init(string: "https://foodjango.000webhostapp.com/login.php")
            Alamofire.request(url!, method: .post, parameters: params).responseJSON {
                (response) in
                print(response)
                if let Json = response.result.value{
                    print(Json)
                    let dic = Json as! [Any]
                    let dic2 = dic.first as! [String : Any]
                    let token = dic2["user_api_token"] as! String
                    if token != ""{
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
