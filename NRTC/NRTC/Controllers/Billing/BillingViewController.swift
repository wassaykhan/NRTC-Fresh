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

class BillingViewController: UIViewController,UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource {
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
	@IBOutlet weak var pickerCity: UIPickerView!
	
	var arrCities:Array<String> = []
	var arrArea:Array<String> = []
	
	
	
	var cities = ["AL AIN", "AJMAN", "ABUDHABI", "DUBAI", "FUJERIAH", "RAS AL KHAIMAH"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
		self.city.delegate = self
		self.address2.delegate = self
		self.pickerCity.delegate = self
		pickerCity.isHidden = true
		addborder(name: address , label :"Complete Address (Required)")
		addborder(name: city, label: "Select Your Emirate (Required)")
		addborder(name: address2,label: "Select Your Area (Required)")
		addborder(name: zip,label: "Select Zip Code (Required)")
		addborder(name: phone,label: "Phone Number (Required)")
		hideKeyboard()
		
		self.getArea()
		self.getCities()
		
        // Do any additional setup after loading the view.
    }
	
	func numberOfComponents(in pickerView: UIPickerView) -> Int {
		return 1
	}
	
	// returns the # of rows in each component..
	func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
		if pickerView.tag == 1 {
			return arrCities.count
		}else{
			return arrArea.count
		}
		
	}
	
	func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
		if pickerView.tag == 1 {
			return arrCities[row]
		}else{
			return arrArea[row]
		}
		
	}
	
	func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
		
		if pickerView.tag == 1 {
			self.city.text = arrCities[row]
			pickerCity.isHidden = true;
		}else{
			self.address2.text = arrArea[row]
			pickerCity.isHidden = true;
		}
		
		
	}
	
	func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
		
		if textField == self.city {
			pickerCity.tag = 1
			pickerCity.reloadAllComponents()
			pickerCity.isHidden = false
			return false
		}else{
			pickerCity.tag = 2
			pickerCity.reloadAllComponents()
			pickerCity.isHidden = false
			return false
		}
		
		
	}
	
    @IBAction func done(_ sender: Any) {
        var paramsAll : [String:Any] = self.params
        if self.address.text != "" && self.address2.text != "" && self.city.text != "" && self.phone.text != "" {
            paramsAll["billing_address_line_2"] = address2.text
            paramsAll["billing_address_line_1"] = address.text
            paramsAll["billing_city"] = city.text
            paramsAll["billing_zip_code"] = zip.text
            paramsAll["billing_phone"] = phone.text
            registerCall(paramsAll: paramsAll)
        }
    }
	
	
	func getCities() {
		if Reachability.isConnectedToInternet(){
			SVProgressHUD.show(withStatus: "Loading Request")
			Alamofire.request(KBaseUrl + KGetCities,method:.get,parameters: nil, encoding: JSONEncoding.default).responseJSON { (response) -> Void in
				
				switch(response.result) {
				case .success(_):
					SVProgressHUD.dismiss()
					if let result = response.result.value as? NSDictionary {
						switch(result["code"] as? String)
						{
						case "404":
							self.alerts(title: kError, message: "Error")
						case "200":
							
							self.arrCities = []
							for cities in result["data"] as! NSArray{
								print(cities)
								let city = cities as! NSDictionary
								self.arrCities.append(city["city_name"] as! String)
							}
							
							
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
	
	func getArea() {
		if Reachability.isConnectedToInternet(){
			SVProgressHUD.show(withStatus: "Loading Request")
			Alamofire.request(KBaseUrl + KGetArea,method:.get,parameters: nil, encoding: JSONEncoding.default).responseJSON { (response) -> Void in
				
				switch(response.result) {
				case .success(_):
					SVProgressHUD.dismiss()
					if let result = response.result.value as? NSDictionary {
						switch(result["code"] as? String)
						{
						case "404":
							self.alerts(title: kError, message: "Error")
						case "200":
							
							self.arrArea = []
							for areas in result["data"] as! NSArray{
								print(areas)
								let area = areas as! NSDictionary
								self.arrArea.append(area["name"] as! String)
							}
							
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
//                            self.performSegue(withIdentifier: "register", sender: self)
							
							UserDefaults.standard.set(paramsAll["first_name"], forKey: "first_name")
							UserDefaults.standard.set(paramsAll["last_name"], forKey: "last_name")
							UserDefaults.standard.set(paramsAll["password"], forKey: "password")
							UserDefaults.standard.set(paramsAll["re_confrim_pass"], forKey: "re_confrim_pass")
							UserDefaults.standard.set(paramsAll["email"], forKey: "email")
							UserDefaults.standard.set(paramsAll["gender"], forKey: "gender")
							UserDefaults.standard.set(register.userID, forKey: "user_id")
							UserDefaults.standard.set(paramsAll["billing_address_line_1"], forKey: "billing_address_line_1")
							UserDefaults.standard.set(paramsAll["billing_address_line_2"], forKey: "billing_address_line_2")
							UserDefaults.standard.set(paramsAll["billing_city"], forKey: "billing_city")
							UserDefaults.standard.set(paramsAll["billing_phone"], forKey: "billing_phone")
							
							var checkIfOrderPresent = true
							for controller in self.navigationController!.viewControllers as Array {
								if controller.isKind(of: OrderViewController.self) {
									self.navigationController!.popToViewController(controller, animated: true)
									checkIfOrderPresent = false
									break
								}
							}
							
							
							if checkIfOrderPresent {
								for controller in self.navigationController!.viewControllers as Array {
									if controller.isKind(of: HomeViewController.self) {
										self.navigationController!.popToViewController(controller, animated: true)
										break
									}
								}
							}
							
							
							
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
		let credentials:NSDictionary = ["first_name": UserDefaults.standard.string(forKey: "first_name")!, "last_name": UserDefaults.standard.string(forKey: "last_name")!,"user_id": UserDefaults.standard.integer(forKey: "user_id"),"email": UserDefaults.standard.string(forKey: "email")!,"gender": UserDefaults.standard.string(forKey: "gender")!,"billing_address_line_1": UserDefaults.standard.string(forKey: "billing_address_line_1")!,"billing_address_line_2": UserDefaults.standard.string(forKey: "billing_address_line_2")!,"billing_city": UserDefaults.standard.string(forKey: "billing_city")!,"billing_phone": UserDefaults.standard.string(forKey: "billing_phone")!,"sub_total": UserDefaults.standard.string(forKey: "sub_total")!,"grand_total": UserDefaults.standard.string(forKey: "grand_total")!,"value_added_tax": UserDefaults.standard.string(forKey: "value_added_tax")!]
		return credentials
	}
}
