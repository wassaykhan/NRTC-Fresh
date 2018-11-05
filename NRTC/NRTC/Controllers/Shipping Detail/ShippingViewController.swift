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
	@IBOutlet weak var txtShippingPostalCode: UITextField!
	@IBOutlet weak var txtShippingPhoneNumber: UITextField!
	@IBOutlet weak var txtShippingDate: UITextField!
	@IBOutlet weak var viewShippingDetail: UIView!
	@IBOutlet weak var btnShippinpDate: UIButton!
//	@IBOutlet var pickerBizCat: UIPickerView! = UIPickerView()
	@IBOutlet weak var pickerCity: UIPickerView!
	@IBOutlet weak var txtTime: UITextField!
	
	
	var timeSelected:Date?
	
	var arrProduct:Array<Product>?
	var pickerF : UIDatePicker?
	var preferredDate:String?
	var cities = ["AL AIN", "AJMAN", "ABUDHABI", "DUBAI", "FUJERIAH", "RAS AL KHAIMAH"]
	var times = ["09 AM - 12 PM", "1 PM - 4 PM", "5 PM - 8 PM"]
	
	func setDefault() {
		let credentials = getDefaults()
		self.txtShippingFirstName.text = credentials["first_name"] as? String
		self.txtShippingLastName.text = credentials["last_name"] as? String
		self.txtShippingAddress.text = credentials["billing_address_line_1"] as? String
		self.txtShippingAddress1.text = credentials["billing_address_line_1"] as? String
		self.txtShippingAddress2.text = credentials["billing_address_line_2"] as? String
		self.txtShippingCity.text = "DUBAI"
		self.txtShippingPostalCode.text = credentials["billing_zip_code"] as? String
		self.txtShippingPhoneNumber.text = credentials["billing_phone"] as? String
	}
	
	
    override func viewDidLoad() {
        super.viewDidLoad()
		self.hideKeyboard()
		self.txtShippingCity.delegate = self
		self.pickerCity.delegate = self
		pickerCity.isHidden = true;
		txtShippingCity.placeholder = "Shipping City"
		self.txtTime.delegate = self
		self.setDefault()
		
		
    }
	
	func donedatePicker() {
		print("sahi hai")
	}
	
	@IBAction func btnBackAction(_ sender: Any) {
		self.navigationController?.popViewController(animated: true)
	}
	
//	func numberOfComponentsInPickerView(pickerView: UIPickerView!) -> Int{
//		return 1
//	}
	
	// returns the # of rows in each component..
	func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
		if pickerView.tag == 2 {
			return times.count
		}else{
			return cities.count
		}
//		return cities.count
	}
	
	func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
		
		if pickerView.tag == 2 {
			return times[row]
		}else{
			return cities[row]
		}
		
//		return cities[row]
	}
	
	func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
		
		if pickerView.tag == 2 {
			self.txtTime.text = times[row]
			pickerCity.isHidden = true;
		}else{
			self.txtShippingCity.text = cities[row]
			pickerCity.isHidden = true;
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
	
	
	func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
		
		if textField == self.txtShippingCity {
			pickerCity.tag = 1
			pickerCity.reloadAllComponents()
			pickerCity.isHidden = false
			return false
		}else if textField == self.txtTime {
			let currDate = Date()
			
//			let currentDate = Date()
			
			let calendarCurrent = Calendar(identifier: .gregorian)
			
			let dateComponentsCurrent = calendarCurrent.dateComponents([.day ,.hour, .minute], from: currDate)
			
			
			let calendar = Calendar(identifier: .gregorian)
//			currDate = calendar.date
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
			
		}else{
			return false
		}
		
	}
	
	func textFieldDidBeginEditing(_ textField: UITextField) {
//		if textField == self.txtShippingDate {
//			self.datePicker()
//		}
	}
	
	@objc func doneClicked(sender: UIButton) {
		
		self.view.willRemoveSubview(self.pickerF!)
//		self.btnShippinpDate.titleLabel?.text = formatDateForDisplay(date: sender.date)
//		print(self.btnShippinpDate.titleLabel?.text as Any)
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
				let priceProd:NSString = products.price! as NSString
				let sumOfProd = quantity.floatValue * priceProd.floatValue
				
				let dictionary1: [String: String] = ["product_id":products.productId!,"quantity":products.productQuantity!,"prod_price":products.oldPrice!,"prod_name":products.title!,"prod_sum_price":String(format: "%.2f", sumOfProd)]
				finalProd.append(dictionary1)
			}
			
			let credentials = getDefaults()
			
			let urlString = KBaseUrl + KOrderCheckout
			
			//Change Delivery Time format
			var timeStr = ""
			
			if self.txtTime.text == "09 AM - 12 PM"{
				timeStr = "09:00-12:00"
			}else if self.txtTime.text == "1 PM - 4 PM"{
				timeStr = "01:00-04:00"
			}else if self.txtTime.text == "5 PM - 8 PM"{
				timeStr = "05:00-08:00"
			}
			
			
			let parameters:[String:AnyObject] = ["first_name":credentials["first_name"] as AnyObject,"last_name":credentials["last_name"] as AnyObject,"email":credentials["email"] as AnyObject, "billing_address":credentials["billing_address_line_1"] as AnyObject,"billing_address_line_1":credentials["billing_address_line_2"] as AnyObject,"billing_address_line_2":credentials["billing_address_line_2"] as AnyObject,"billing_city":credentials["billing_city"] as AnyObject,"billing_zip_code":credentials["billing_zip_code"] as AnyObject,"billing_phone":credentials["billing_phone"] as AnyObject,"password_register":credentials["billing_phone"] as AnyObject,"re_password_register":"" as AnyObject,"shipping_first_name":self.txtShippingFirstName.text as AnyObject,"shipping_last_name":self.txtShippingLastName.text as AnyObject,"shipping_address":self.txtShippingAddress.text as AnyObject,"shipping_address_line_1":self.txtShippingAddress1.text as AnyObject,"shipping_city":self.txtShippingCity.text as AnyObject,"shipping_zip_code":self.txtShippingPostalCode.text as AnyObject,"shipping_phone":self.txtShippingPhoneNumber.text as AnyObject,"preferred_date_of_delivery":self.btnShippinpDate.titleLabel?.text as AnyObject,"preferred_delivery_time":timeStr as AnyObject,
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
								
								let alert = UIAlertController(title: "Order Placed", message: "Thanks for shopping at NRTC Fresh", preferredStyle: UIAlertController.Style.alert)
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
