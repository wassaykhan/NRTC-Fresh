//
//  LoginViewController.swift
//  NRTC
//
//  Created by Wassay Khan on 03/10/2018.
//  Copyright © 2018 Netpace. All rights reserved.
//

import UIKit
import Alamofire

class LoginViewController: UIViewController {

	@IBOutlet weak var password: UITextField!
	@IBOutlet weak var username: UITextField!
	
    @IBOutlet weak var usernameError: UILabel!
    var loginmodel : LoginModel?
    @IBOutlet weak var passwordError: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addborder(name: username, label: "")
        self.addborder(name: password, label: "")
        self.hideKeyboard()
    }
   
    @IBAction func signup(_ sender: Any) {
  self.performSegue(withIdentifier: "register", sender: self)
    }
    @IBAction func login(_ sender: Any) {
        if username.text != ""  {
            if !isValidEmail(Input: username.text ?? "") {
                usernameError.text = kValidEmail
            }
            else {
                usernameError.text = ""
                
            }
        }
        else
        {
            usernameError.text = kNotEmpty
        }
        if password.text != "" {
            if !isValidPassword(Input: password.text ?? "") {
                passwordError.text = kValidPass
            }
            else {
                passwordError.text = ""
            }
        }
        else {
            passwordError.text = kNotEmpty
        }
        if usernameError.text == "" && passwordError.text == ""
        {
            loginCall(username: username.text!, password: password.text!)
          
        }
        
    }
    
    func loginCall(username:String,password:String)
    {
        let params: [String: Any] = ["email": username, "password": password]
        if Reachability.isConnectedToInternet(){
        Alamofire.request(KBaseUrl + KLogin,method:.post,parameters: params, encoding: JSONEncoding.default).responseJSON { (response) -> Void in
            switch(response.result) {
            case .success(_):
                if let result = response.result.value as? NSDictionary {
                    switch(result["code"] as? String)
                    {
                    case "404":
						self.alerts(title: "Internet", message: "Please check your connection")
                    case "200":
                          self.loginmodel = LoginModel(dictionary: result )
                        self.performSegue(withIdentifier: "loginButton", sender: self)
                    default:
                        print("Something went wrong")
                    }
//
                }

            case .failure(_):
				print("Failure : \(String(describing: response.result.error))")
             
            }
        }
    }
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
 
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if (segue.identifier == "loginButton") {
               // let vc = segue.destination as! RegisterViewController
            //    vc.model = self.loginmodel
            }
        }

    

  

}

extension UIViewController
{
    func addborder(name : UITextField,label : String)
    {
        let border1 = CALayer()
        let width = CGFloat(1.0)
        border1.frame = CGRect(x: 0, y: name.frame.size.height - width, width: name.frame.size.width, height: name.frame.size.height)
        
        border1.borderWidth = 0.5
        name.layer.addSublayer(border1)
        name.layer.masksToBounds = true
        name.placeholder = label
    }
    func hideKeyboard()
    {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(UIViewController.dismissKeyboard))
        
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard()
    {
        view.endEditing(true)
    }
    
    func isValidEmail(Input:String) -> Bool {
        let RegEx =  "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let Test = NSPredicate(format:"SELF MATCHES %@", RegEx)
        return Test.evaluate(with: Input)
    }
    
    public func isValidPassword(Input : String) -> Bool {
        let passwordRegex = "^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z])[0-9a-zA-Z!@#$%^&*()\\-_=+{}|?>.<,:;~`’]{8,}$"
        return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: Input)
    }
    func alerts(title:String,message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(defaultAction)
        self.present(alert, animated: true, completion: nil)
    }
}

