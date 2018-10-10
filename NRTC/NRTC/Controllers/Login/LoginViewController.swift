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
    
    @IBOutlet weak var passwordError: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addborder(name: username, label: "")
        self.addborder(name: password, label: "")
        self.hideKeyboard()
    }
   
    @IBAction func login(_ sender: Any) {
        if username.text != ""  {
            if !isValidUsername(Input: username.text ?? "") {
                usernameError.text = "Must contain atleast 7 characters"
            }
            else {
                usernameError.text = ""
                
            }
        }
        else
        {
            usernameError.text = "Please Enter Username"
        }
        if password.text != "" {
            if !isValidPassword(Input: password.text ?? "") {
                passwordError.text = "Must contain an uppercase and number"
            }
            else {
                passwordError.text = ""
            }
        }
        else {
            passwordError.text = "Please Enter Password"
        }
        if usernameError.text == "" && passwordError.text == ""
        {
            loginCall()
//            self.performSegue(withIdentifier: "loginButton", sender: self)
        }
        
    }
    
    func loginCall()
    {
        let newTodo: [String: Any] = ["email": "jyoti.shina@salsoft.net", "password": ""]
        
        Alamofire.request("https://dev17.onlinetestingserver.com/nrtc_beta/Api/Login/login",method:.post,parameters: newTodo, encoding: JSONEncoding.default).responseJSON { (response) -> Void in
            switch(response.result) {
            case .success(_):
                if let result = response.result.value as? NSDictionary {
                    switch(result["code"] as? String)
                    {
                    case "404":
						print(result["message"]!)
                    case "200":
						let loginmodel = LoginModel(dictionary: result )
                        print("Model \(String(describing: loginmodel.code))")
						print("response : \(String(describing: response.result.value))")
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

    
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destination.
//        // Pass the selected object to the new view controller.
//
//    }
//


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
    
    func isValidUsername(Input:String) -> Bool {
        let RegEx = "\\w{7,18}"
        let Test = NSPredicate(format:"SELF MATCHES %@", RegEx)
        return Test.evaluate(with: Input)
    }
    
    public func isValidPassword(Input : String) -> Bool {
        let passwordRegex = "^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z])[0-9a-zA-Z!@#$%^&*()\\-_=+{}|?>.<,:;~`’]{8,}$"
        return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: Input)
    }
}

