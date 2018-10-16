//
//  BillingViewController.swift
//  NRTC
//
//  Created by Wassay Khan on 03/10/2018.
//  Copyright © 2018 Netpace. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD

class BillingViewController: UIViewController {
    var params : [String:Any] = [:]
	@IBOutlet weak var phone: UITextField!
	@IBOutlet weak var zip: UITextField!
    @IBOutlet weak var city: UITextField!
    @IBOutlet weak var address2: UITextField!
    @IBOutlet weak var address: UITextField!
    
    @IBOutlet weak var addressError: UILabel!
    @IBOutlet weak var address2Error: UILabel!
    @IBOutlet weak var cityError: UILabel!
    @IBOutlet weak var zipError: UILabel!
    @IBOutlet weak var phoneError: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
		addborder(name: address , label :"Address 1 *")
		addborder(name: city, label: "Town /City *")
		addborder(name: address2,label: "Address 2 *")
		addborder(name: zip,label: "ZIP *")
		addborder(name: phone,label: "Phone *")
		hideKeyboard()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func done(_ sender: Any) {
        var paramsAll : [String:Any] = self.params
        let addressError = checkTextfield(textfield: address, textfieldError: self.addressError)
          let address2Error = checkTextfield(textfield: address2, textfieldError: self.address2Error)
          let cityError = checkTextfield(textfield: city, textfieldError: self.cityError)
          let zipError = checkTextfield(textfield: zip, textfieldError: self.zipError)
          let phoneError = checkTextfield(textfield: phone, textfieldError: self.phoneError)
        
        if addressError == "" && address2Error == "" && cityError == "" && zipError == "" && phoneError == "" {
            paramsAll["billing_address_line_1"] = address.text
            paramsAll["billing_address_line_2"] = address2.text
            paramsAll["billing_city"] = city.text
            paramsAll["billing_zip_code"] = zip.text
            paramsAll["billing_phone"] = phone.text
            registerCall(paramsAll: paramsAll)
        }
    }
    func registerCall(paramsAll : [String:Any])
    {
        if Reachability.isConnectedToInternet(){
			SVProgressHUD.show(withStatus: "Loading Request")
            Alamofire.request(KBaseUrl + kSignup,method:.post,parameters: paramsAll, encoding: JSONEncoding.default).responseJSON { (response) -> Void in
                
                switch(response.result) {
                case .success(_):
					SVProgressHUD.dismiss()
                    if let result = response.result.value as? NSDictionary {
                        switch(result["code"] as? String)
                        {
                        case "404":
                            self.alerts(title: kError, message: kEmailAlreadyExist)
                        case "200":
                           
                            let register = LoginModel(dictionarys: result)
                            print("\(String(describing: register.code)) \(String(describing: register.message))")
                            self.performSegue(withIdentifier: "register", sender: self)
							
							UserDefaults.standard.set(paramsAll["first_name"], forKey: "first_name")
							UserDefaults.standard.set(paramsAll["last_name"], forKey: "last_name")
							UserDefaults.standard.set(paramsAll["password"], forKey: "password")
							UserDefaults.standard.set(paramsAll["re_confrim_pass"], forKey: "re_confrim_pass")
							UserDefaults.standard.set(paramsAll["email"], forKey: "email")
							UserDefaults.standard.set(register.userID, forKey: "user_id")
							UserDefaults.standard.set(paramsAll["billing_address_line_1"], forKey: "billing_address_line_1")
							UserDefaults.standard.set(paramsAll["billing_address_line_2"], forKey: "billing_address_line_2")
							UserDefaults.standard.set(paramsAll["billing_city"], forKey: "billing_city")
							UserDefaults.standard.set(paramsAll["billing_zip_code"], forKey: "billing_zip_code")
							UserDefaults.standard.set(paramsAll["billing_phone"], forKey: "billing_phone")
							
							
                        default:
                            self.alerts(title: kError, message:kSwr )
                        }
                        //
                    }
                    else{
						SVProgressHUD.dismiss()
                         let arrays = response.result.value as! [String]
                       self.alerts(title: kError, message: arrays[0])
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

	@IBAction func btnBackAction(_ sender: Any) {
		self.navigationController?.popViewController(animated: true)
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

extension UIViewController {
	func getDefaults() -> NSDictionary{
		print("Setting Defaults")
		let credentials:NSDictionary = ["first_name": UserDefaults.standard.string(forKey: "first_name")!, "last_name": UserDefaults.standard.string(forKey: "last_name")!,"user_id": UserDefaults.standard.integer(forKey: "user_id"),"email": UserDefaults.standard.string(forKey: "email")!,"billing_address_line_1": UserDefaults.standard.string(forKey: "billing_address_line_1")!,"billing_address_line_2": UserDefaults.standard.string(forKey: "billing_address_line_2")!,"billing_city": UserDefaults.standard.string(forKey: "billing_city")!,"billing_zip_code": UserDefaults.standard.string(forKey: "billing_zip_code")!,"billing_phone": UserDefaults.standard.string(forKey: "billing_phone")!,"sub_total": UserDefaults.standard.string(forKey: "sub_total")!,"grand_total": UserDefaults.standard.string(forKey: "grand_total")!,"value_added_tax": UserDefaults.standard.string(forKey: "value_added_tax")!]
		return credentials
	}
}
