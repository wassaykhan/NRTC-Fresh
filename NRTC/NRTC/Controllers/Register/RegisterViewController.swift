//
//  RegisterViewController.swift
//  NRTC
//
//  Created by Wassay Khan on 03/10/2018.
//  Copyright © 2018 Netpace. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
	
	
	@IBOutlet weak var lastname: UITextField!
	@IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var confirmpass: UITextField!
    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var firstnameError: UILabel!
    @IBOutlet weak var passwordError: UILabel!
    @IBOutlet weak var confirmpassError: UILabel!
    @IBOutlet weak var emailError: UILabel!
    @IBOutlet weak var lastnameError: UILabel!
    
    var params : [String:Any] = [:]
    override func viewDidLoad() {
        super.viewDidLoad()
		addborder(name: firstName , label :"First Name")
		addborder(name: lastname, label: "Last Name")
		addborder(name: password,label: "Password")
		addborder(name: confirmpass,label: "Confirm Password")
		addborder(name: email,label: "Email")
    	self.hideKeyboard()
        // Do any additional setup after loading the view.
    }
	@IBAction func btnBackAction(_ sender: Any) {
		self.navigationController?.popViewController(animated: true)
	}
	
    @IBAction func signup(_ sender: Any) {
       
//        let firstnameError = checkTextfield(textfield: firstName, textfieldError: self.firstnameError)
		
//        let lastnameError = checkTextfield(textfield: lastname, textfieldError: self.lastnameError)
		
//        let passError = validation(textField: password, labelError: passwordError, funct: isValidPassword, validEmailorPass: kValidPass)
		
       
//            let cnfrmpassError = validation(textField: confirmpass, labelError: confirmpassError, funct: isValidPassword, validEmailorPass: kValidPass)
//            if(cnfrmpassError == "")
//            {
//                if confirmpass.text != password.text {
//                    confirmpassError.text = kPasswordMatch
//                }
//                else{
//                    confirmpassError.text = ""
//                }
//            }
		
//        let emailError = validation(textField: email, labelError: self.emailError, funct: isValidEmail, validEmailorPass: kValidEmail)
		
        if firstName.text != "" && lastname.text != "" && password.text != "" && confirmpass.text != "" && email.text != "" {
             params = [
                "first_name":firstName.text!,
            "last_name":lastname.text!,
            "password": password.text!,
            "re_confrim_pass": confirmpass.text!,
            "email": email.text!]
             self.performSegue(withIdentifier: "signup", sender: self)
		}else{
			alerts(title: "Required", message: "Please fill all the fields")
		}
        
    }
   


	
	
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "signup") {
             let vc = segue.destination as! BillingViewController
               vc.params = self.params
        }
    }
 

}
