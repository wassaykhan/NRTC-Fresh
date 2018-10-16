//
//  LoginViewController.swift
//  NRTC
//
//  Created by Wassay Khan on 03/10/2018.
//  Copyright © 2018 Netpace. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD

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
   
	@IBAction func btnBackAction(_ sender: Any) {
		self.navigationController?.popViewController(animated: true)
	}
	@IBAction func signup(_ sender: Any) {
  self.performSegue(withIdentifier: "register", sender: self)
    }
    @IBAction func login(_ sender: Any) {
        let emailError : String = validation(textField: username, labelError: usernameError, funct: isValidEmail, validEmailorPass: kValidEmail)
		let passError : String = self.password.text ?? ""//validation(textField: password, labelError: passwordError, funct: isValidPassword, validEmailorPass: kValidPass)
        if emailError == ""
        {
            loginCall(username: username.text!, password: password.text!)
          
        }
        
    }
    
    func loginCall(username:String,password:String)
    {
        let params: [String: Any] = ["email": username, "password": password]
        if Reachability.isConnectedToInternet(){
			SVProgressHUD.show(withStatus: "Loading Request")
            Alamofire.request(KBaseUrl + KLogin,method:.post,parameters: params, encoding: JSONEncoding.default).responseJSON { (response) -> Void in
                switch(response.result) {
                case .success(_):
					SVProgressHUD.dismiss()
                    if let result = response.result.value as? NSDictionary {
                        switch(result["code"] as? String)
                        {
                        case "404":
                            self.alerts(title: kError, message: kEmailPassValid)
                        case "200":
                            self.loginmodel = LoginModel(dictionary: result )
							
							UserDefaults.standard.set(self.loginmodel?.firstName, forKey: "first_name")
							UserDefaults.standard.set(self.loginmodel?.lastName, forKey: "last_name")
//							UserDefaults.standard.set(, forKey: "password")
//							UserDefaults.standard.set(self.password, forKey: "re_confrim_pass")
							UserDefaults.standard.set(self.loginmodel?.email, forKey: "email")
							UserDefaults.standard.set(self.loginmodel?.userID, forKey: "user_id")
							UserDefaults.standard.set(self.loginmodel?.billingAddressLine1, forKey: "billing_address_line_1")
							UserDefaults.standard.set(self.loginmodel?.billingAddressLine2, forKey: "billing_address_line_2")
							UserDefaults.standard.set(self.loginmodel?.billingCity, forKey: "billing_city")
							UserDefaults.standard.set(self.loginmodel?.billingZipCode, forKey: "billing_zip_code")
							UserDefaults.standard.set(self.loginmodel?.billingPhone, forKey: "billing_phone")
							
                            self.performSegue(withIdentifier: "loginButton", sender: self)
                        default:
                            self.alerts(title: kError, message:kSwr )
                        }
                        //
                    }
                    
                case .failure(_):
					SVProgressHUD.dismiss()
                    print("Failure : \(String(describing: response.result.error))")
                    
                }
            }
        }
        else
        {
              self.alerts(title: kInternet, message: kCheckInternet)
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
    func validation(textField : UITextField , labelError : UILabel , funct : (String) -> Bool, validEmailorPass : String) -> String
    {
        if textField.text != ""  {
            if !funct(textField.text ?? "") {
               labelError.text = validEmailorPass
                return labelError.text!
            }
            else {
                labelError.text = ""
                return labelError.text!
                
            }
        }
        else
        {
         labelError.text = kNotEmpty as String
            return labelError.text!
        }
    }
    func checkTextfield(textfield : UITextField,textfieldError : UILabel) -> String{
        if textfield.text == "" {
            textfieldError.text = kNotEmpty
            return textfieldError.text!
        }
        else {
            textfieldError.text = ""
            return textfieldError.text!
        }
    }
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
        let passwordRegex = "^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z])[0-9a-zA-Z!@#$%^&*()\\-_=+{}|?>.<,:;~`’]{6,}$"
        return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: Input)
    }
	
    func alerts(title:String,message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(defaultAction)
        self.present(alert, animated: true, completion: nil)
    }
}

