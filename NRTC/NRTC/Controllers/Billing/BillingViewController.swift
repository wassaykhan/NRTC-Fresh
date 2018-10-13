//
//  BillingViewController.swift
//  NRTC
//
//  Created by Wassay Khan on 03/10/2018.
//  Copyright © 2018 Netpace. All rights reserved.
//

import UIKit
import Alamofire

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
            Alamofire.request(KBaseUrl + kSignup,method:.post,parameters: paramsAll, encoding: JSONEncoding.default).responseJSON { (response) -> Void in
                
                switch(response.result) {
                case .success(_):
                    if let result = response.result.value as? NSDictionary {
                        switch(result["code"] as? String)
                        {
                        case "404":
                            self.alerts(title: kError, message: kEmailAlreadyExist)
                        case "200":
                           
                            let register = LoginModel(dictionary: result)
                            print("\(String(describing: register.code)) \(String(describing: register.message))")
                            self.performSegue(withIdentifier: "register", sender: self)
                        default:
                            self.alerts(title: kError, message:kSwr )
                        }
                        //
                    }
                    else{
                         let arrays = response.result.value as! [String]
                       self.alerts(title: kError, message: arrays[0])
                    }
                    
                case .failure(_):
                    print("Failure : \(String(describing: response.result.error))")
                    
                }
            }
        }
        else
        {
            self.alerts(title: kInternet, message: kCheckInternet)
        }
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
