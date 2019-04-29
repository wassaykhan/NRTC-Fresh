//
//  ShippingViewController.swift
//  NRTC
//
//  Created by Wassay Khan on 14/10/2018.
//  Copyright © 2018 Netpace. All rights reserved.
//

import UIKit
import SVProgressHUD
import Alamofire


class ShippingViewController: UIViewController,UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource {
	func numberOfComponents(in pickerView: UIPickerView) -> Int {
		return 1
	}
	

	@IBOutlet weak var txtShippingFirstName: UITextField!
	@IBOutlet weak var txtShippingLastName: UITextField!
	@IBOutlet weak var txtShippingAddress: UITextField!
	@IBOutlet weak var txtShippingAddress1: UITextField!
	@IBOutlet weak var txtShippingAddress2: UITextField!
	@IBOutlet weak var txtShippingCity: UITextField!
	@IBOutlet weak var txtSpecialMessageBox: UITextField!
	@IBOutlet weak var txtShippingPhoneNumber: UITextField!
	@IBOutlet weak var txtShippingDate: UITextField!
	@IBOutlet weak var viewShippingDetail: UIView!
	@IBOutlet weak var btnShippinpDate: UIButton!
//	@IBOutlet var pickerBizCat: UIPickerView! = UIPickerView()
	@IBOutlet weak var pickerCity: UIPickerView!
	@IBOutlet weak var txtTime: UITextField!
	@IBOutlet weak var txtDeliveryDate: UITextField!
	
	var myPickerView : UIPickerView!
	
	var timeSelected:Date?
	
	var arrProduct:Array<Product>?
	var pickerF : UIDatePicker?
	var preferredDate:String?
	var timeFinal:String?
	var cities:Array<String> = []
	var times:Array<String> = []
	var timeApi:Array<String> = []
	var dateOfDelivery:Array<String> = []
	var arrCities:Array<String> = []
	var arrArea:Array<String> = []
	var arrDateOfDelivery:Array<Any> = []
	var arrTime:Array<String> = []
	var arrDate:Array<String> = []
	
	
	func setDefault() {
		let credentials = getDefaults()
		self.txtShippingFirstName.text = credentials["first_name"] as? String
		self.txtShippingLastName.text = credentials["last_name"] as? String
		self.txtShippingAddress.text = credentials["billing_address_line_1"] as? String
		self.txtShippingAddress1.text = credentials["billing_address_line_2"] as? String
//		self.txtShippingAddress2.text = credentials["billing_address_line_2"] as? String
		self.txtShippingCity.text = "DUBAI"
//		self.txtShippingPostalCode.text = credentials["billing_zip_code"] as? String
		self.txtShippingPhoneNumber.text = credentials["billing_phone"] as? String
	}
	
	
    override func viewDidLoad() {
        super.viewDidLoad()
		self.hideKeyboard()
		self.txtShippingCity.delegate = self
		self.pickerCity.delegate = self
		self.txtShippingAddress1.delegate = self
		self.txtDeliveryDate.delegate = self
		pickerCity.isHidden = true;
		txtShippingCity.placeholder = "Shipping City"
		self.txtTime.delegate = self
		self.setDefault()
		self.getCities()
		self.getArea()
		self.getDateAndDelivery()
		
    }
	
	func pickUp(_ textField : UITextField){
		
		// UIPickerView
		self.myPickerView = UIPickerView(frame:CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 216))
		self.myPickerView.delegate = self
		self.myPickerView.dataSource = self
		self.myPickerView.backgroundColor = UIColor.white
		textField.inputView = self.myPickerView
		
		// ToolBar
		let toolBar = UIToolbar()
		toolBar.barStyle = .default
		toolBar.isTranslucent = true
		toolBar.tintColor = UIColor(red: 92/255, green: 216/255, blue: 255/255, alpha: 1)
		toolBar.sizeToFit()
		
		// Adding Button ToolBar
		let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donePicker))
		let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
		let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelPicker))
		toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
		toolBar.isUserInteractionEnabled = true
		textField.inputAccessoryView = toolBar
		
	}
	
	
	@objc func donePicker (sender:UIBarButtonItem)
	{
		// Put something here
		print("hi")
	}
	
	@objc func cancelPicker (sender:UIBarButtonItem)
	{
		// Put something here
		print("hi")
	}
	
	@IBAction func btnBackAction(_ sender: Any) {
		self.navigationController?.popViewController(animated: true)
	}
	
	// returns the # of rows in each component..
	func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
		if pickerView.tag == 2 {
			return times.count
		}else if pickerView.tag == 3 {
			return arrArea.count
		}else if pickerView.tag == 4 {
			return dateOfDelivery.count
		} else{
			return arrCities.count
		}
	}
	
	func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
		
		if pickerView.tag == 2 {
			return times[row]
		}else if pickerView.tag == 3 {
			return arrArea[row]
		}else if pickerView.tag == 4 {
			return dateOfDelivery[row]
		}else{
			return arrCities[row]
		}
	}
	
	func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
		
		if pickerView.tag == 2 {
			if times.count > 0 {
				self.txtTime.text = times[row]
				self.timeFinal = self.timeApi[row]
				pickerCity.isHidden = true;
			}
			
		}else if pickerView.tag == 3 {
			if arrArea.count > 0 {
				self.txtShippingAddress1.text = arrArea[row]
				pickerCity.isHidden = true;
			}
			
		}else if pickerView.tag == 4 {
			if dateOfDelivery.count > 0 {
				self.txtDeliveryDate.text = dateOfDelivery[row]
				//set time
				self.times = []
				self.timeApi = []
				for dates in arrDateOfDelivery as NSArray{
					let dict = dates as! NSDictionary
					let selectedDate:String = dict["date"] as! String
					if selectedDate == self.txtDeliveryDate.text{
						for time in dict["slots"] as! NSArray{
							let dictTime = time as! NSDictionary
							self.times.append(dictTime["display"] as! String)
							self.timeApi.append(dictTime["time_slot"] as! String)
						}
					}
				}
				
				pickerCity.isHidden = true;
			}
			
		}else{
			
			if arrCities.count > 0 {
				self.txtShippingCity.text = arrCities[row]
				pickerCity.isHidden = true;
			}
			
		}
		
		
	}
	
	@objc func updateDateField(sender: UIDatePicker) {
		self.timeSelected = sender.date
		self.txtTime.isEnabled = true
		self.btnShippinpDate.setTitle(formatDateForDisplay(date: sender.date), for: .normal)
		print(self.btnShippinpDate.titleLabel?.text as Any)
//		self.view.willRemoveSubview(self.pickerF!)
		self.pickerF?.removeFromSuperview()
	}
	
	func textFieldDidBeginEditing(_ textField: UITextField) {
		self.pickUp(self.txtShippingCity)
	}
	
	func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
		
		if textField == self.txtShippingCity {
			self.pickUp(self.txtShippingCity)
			/*
			pickerCity.tag = 1
			pickerCity.reloadAllComponents()
			pickerCity.isHidden = false
			*/
			return false
		}else if textField == self.txtTime {
			
			pickerCity.tag = 2
			pickerCity.reloadAllComponents()
			pickerCity.isHidden = false
			return false
			/*
			let currDate = Date()
			let calendarCurrent = Calendar(identifier: .gregorian)
			let dateComponentsCurrent = calendarCurrent.dateComponents([.day ,.hour, .minute], from: currDate)
			let calendar = Calendar(identifier: .gregorian)
			let dateComponents = calendar.dateComponents([.day ,.hour, .minute], from: timeSelected!)
			
			if dateComponentsCurrent.day! == dateComponents.day!  {
				
				if dateComponents.hour! <= 10 {
					self.times.remove(at: 0)
					pickerCity.tag = 2
					pickerCity.reloadAllComponents()
					pickerCity.isHidden = false
					return false
				}else{
					self.times.remove(at: 0)
					self.times.remove(at: 0)
					pickerCity.tag = 2
					pickerCity.reloadAllComponents()
					pickerCity.isHidden = false
					return false
				}
				
			}else{
				
				print("Other than today")
				pickerCity.tag = 2
				pickerCity.reloadAllComponents()
				pickerCity.isHidden = false
				return false
			}
		*/
			
		}else if textField == self.txtShippingAddress1{
			pickerCity.tag = 3
			pickerCity.reloadAllComponents()
			pickerCity.isHidden = false
			return false
		}else if textField == self.txtDeliveryDate {
			pickerCity.tag = 4
			pickerCity.reloadAllComponents()
			pickerCity.isHidden = false
			return false
		}else{
			return false
		}
		
	}
	
	@objc func doneClicked(sender: UIButton) {
		
		self.view.willRemoveSubview(self.pickerF!)
	}
	
	
	@IBAction func btnShippingDateAction(_ sender: Any) {
		
		self.datePicker()
		
	}
	
	
	func datePicker(){
		let picker : UIDatePicker = UIDatePicker()
		picker.datePickerMode = UIDatePicker.Mode.date
		picker.addTarget(self, action: #selector(updateDateField(sender:)), for: UIControl.Event.valueChanged)
		
		picker.frame = CGRect(x:0.0, y:self.view.bounds.height - 200, width:self.view.bounds.width, height:200)
		// you probably don't want to set background color as black
		picker.backgroundColor = UIColor.white
		
		
//		let calendar = Calendar.current
		
		let currentDate = Date()
		
		let calendar = Calendar(identifier: .gregorian)
		
		let dateComponents = calendar.dateComponents([.hour, .minute], from: currentDate)
		
		
		var compMax = DateComponents()
		var compMin = DateComponents()
		
		if dateComponents.hour! <= 14 {
			compMin.day = 0
			compMax.day = 6
		}else{
			compMin.day = 1
			compMax.day = 7
		}
		
		
		let maxDate = calendar.date(byAdding: compMax, to: Date())
		
		let minDate = calendar.date(byAdding: compMin, to: Date())
		picker.maximumDate = maxDate
		picker.minimumDate = minDate
		
		
		let toolBar = UIToolbar()
		toolBar.barStyle = UIBarStyle.default
		toolBar.isTranslucent = true
		let space = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
		let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(doneClicked(sender:)))
		
		// if you remove the space element, the "done" button will be left aligned
		// you can add more items if you want
		toolBar.setItems([space, doneButton], animated: false)
		toolBar.isUserInteractionEnabled = true
		toolBar.sizeToFit()
		
		picker.addSubview(toolBar)
		
		self.pickerF = picker
		
//		txtField.inputAccessoryView = toolBar
		
		
		
		self.view.addSubview(self.pickerF!)
	}
	
	
	func getDateAndDelivery() {
		if Reachability.isConnectedToInternet(){
			SVProgressHUD.show(withStatus: "Loading Request")
			Alamofire.request(KBaseUrl + KGetDateAndDelivery,method:.get,parameters: nil, encoding: JSONEncoding.default).responseJSON { (response) -> Void in
				
				switch(response.result) {
				case .success(_):
					SVProgressHUD.dismiss()
					if let result = response.result.value as? NSDictionary {
						switch(result["code"] as? String)
						{
						case "404":
							self.alerts(title: kError, message: "Error")
						case "200":
							
							self.arrDateOfDelivery = []
							self.dateOfDelivery = []
							for dateOfDelivery in result["data"] as! NSArray{
								print(dateOfDelivery)
								self.arrDateOfDelivery.append(dateOfDelivery)
								
								let dict = dateOfDelivery as! NSDictionary
								
								self.dateOfDelivery.append(dict["date"] as! String)
//								let city = cities as! NSDictionary
//								self.arrCities.append(city["city_name"] as! String)
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
	
	
	
	fileprivate func formatDateForDisplay(date: Date) -> String {
		let formatter = DateFormatter()
		formatter.dateFormat = "dd MMM yyyy"
		return formatter.string(from: date)
	}
	
	func goToHome(action: UIAlertAction) {
		let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "homeID") as! HomeViewController
		self.navigationController?.pushViewController(nextViewController, animated: true)
	}
	
	@IBAction func btnDoneAction(_ sender: Any) {
		
		if txtTime.text != "" && txtShippingCity.text != "" && txtShippingAddress.text != "" {
			var finalProd = [[String: String]]()
			
			for products:Product in arrProduct! {
				
				let quantity:NSString = products.productQuantity! as NSString
				let priceProd:NSString = products.oldPrice! as NSString
				let sumOfProd = quantity.floatValue * priceProd.floatValue
				
				let dictionary1: [String: String] = ["product_id":products.productId!,"quantity":products.productQuantity!,"prod_price":products.oldPrice!,"prod_name":products.title!,"prod_sum_price":String(format: "%.2f", sumOfProd)]
				finalProd.append(dictionary1)
			}
			
			let credentials = getDefaults()
			
			let urlString = KBaseUrl + KOrderCheckout
			
			//Change Delivery Time format
			/*
			var timeStr = ""
			
			if self.txtTime.text == "09 AM - 12 PM"{
				timeStr = "09:00-12:00"
			}else if self.txtTime.text == "1 PM - 4 PM"{
				timeStr = "01:00-04:00"
			}else if self.txtTime.text == "5 PM - 8 PM"{
				timeStr = "05:00-08:00"
			}
*/
			
			
			let parameters:[String:AnyObject] = ["first_name":credentials["first_name"] as AnyObject,"last_name":credentials["last_name"] as AnyObject,"email":credentials["email"] as AnyObject,"gender":credentials["gender"] as AnyObject, "billing_address":credentials["billing_address_line_1"] as AnyObject,"billing_address_line_1":credentials["billing_address_line_2"] as AnyObject,"billing_address_line_2":credentials["billing_address_line_2"] as AnyObject,"billing_city":credentials["billing_city"] as AnyObject,"billing_phone":credentials["billing_phone"] as AnyObject,"password_register":credentials["billing_phone"] as AnyObject,"re_password_register":"" as AnyObject,"shipping_first_name":self.txtShippingFirstName.text as AnyObject,"shipping_last_name":self.txtShippingLastName.text as AnyObject,"shipping_address":self.txtShippingAddress.text as AnyObject,"shipping_address_line_1":self.txtShippingAddress1.text as AnyObject,"shipping_city":self.txtShippingCity.text as AnyObject,"special_message":self.txtSpecialMessageBox.text as AnyObject,"shipping_phone":self.txtShippingPhoneNumber.text as AnyObject,"preferred_date_of_delivery":self.txtDeliveryDate.text as AnyObject,"preferred_delivery_time":self.timeFinal as AnyObject,
												 "product_items": finalProd as AnyObject,
												 
												 "payment_type":"cod" as AnyObject,"sub_total":credentials["sub_total"] as AnyObject,"value_added_tax":credentials["value_added_tax"] as AnyObject,"grand_total":credentials["grand_total"] as AnyObject,
												 "amount_currency":"AED" as AnyObject,"checkout_type":"guest" as AnyObject,"referrer":"" as AnyObject,"clean_referrer":"" as AnyObject,"user_id":credentials["user_id"]  as AnyObject]
			
			if Reachability.isConnectedToInternet(){
				
				SVProgressHUD.show(withStatus: "Loading Request")
				
				Alamofire.request(urlString,method:.post,parameters: parameters, encoding: JSONEncoding.default).responseJSON { (response) -> Void in
					
					SVProgressHUD.dismiss()
					
					switch(response.result) {
						
						
						
					case .success(_):
						
						
						
						if let result = response.result.value as? NSDictionary {
							switch(result["success"] as? Int)
							{
							case 404:
								self.alerts(title: kError, message: "kEmailAlreadyExist")
							case 200:
								SVProgressHUD.dismiss()
								let prefs = UserDefaults.standard
								prefs.removeObject(forKey:"Products")
								
								let alert = UIAlertController(title: "Order Confirmation", message: "Thank you for your order at NRTC Fresh", preferredStyle: UIAlertController.Style.alert)
								let defaultAction = UIAlertAction(title: "OK", style: .default, handler: self.goToHome)
								alert.addAction(defaultAction)
								self.present(alert, animated: true, completion: nil)
								
								
//								self.alerts(title: "Order Placed", message: "Thanks for shopping at NRTC Fresh")
								
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
						SVProgressHUD.dismiss()
						print("Failure : \(String(describing: response.result.error))")
						
					}
				}
			}
			else
			{
				SVProgressHUD.dismiss()
				self.alerts(title: kInternet, message: kCheckInternet)
			}
		}else{
			alerts(title: "Required", message: "Please fill all the fields")
		}
		
		
	
	}

}
