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


class ShippingViewController: UIViewController,UITextFieldDelegate {

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
	
	var arrProduct:Array<Product>?
	var pickerF : UIDatePicker?
	var preferredDate:String?
	
    override func viewDidLoad() {
        super.viewDidLoad()
		self.hideKeyboard()
//		self.txtShippingDate.delegate = self
//		self.txtShippingDate.inputView = pickerF
    }
	
	@IBAction func btnBackAction(_ sender: Any) {
		self.navigationController?.popViewController(animated: true)
	}
	
	
	@objc func updateDateField(sender: UIDatePicker) {
		self.btnShippinpDate.setTitle(formatDateForDisplay(date: sender.date), for: .normal) 
		print(self.btnShippinpDate.titleLabel?.text as Any)
//		self.view.willRemoveSubview(self.pickerF!)
		self.pickerF?.removeFromSuperview()
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
		
		if dateComponents.hour! <= 17 {
			compMin.day = 3
			compMax.day = 9
		}else{
			compMin.day = 2
			compMax.day = 8
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
		
		//picker.addSubview(toolBar)
		
		self.pickerF = picker
		
//		txtField.inputAccessoryView = toolBar
		
		
		
		self.view.addSubview(self.pickerF!)
	}
	
	
	
	fileprivate func formatDateForDisplay(date: Date) -> String {
		let formatter = DateFormatter()
		formatter.dateFormat = "dd MMM yyyy"
		return formatter.string(from: date)
	}
	
	@IBAction func btnDoneAction(_ sender: Any) {
		
		
		var finalProd = [[String: String]]()
		
		for products:Product in arrProduct! {
			let dictionary1: [String: String] = ["product_id":products.productId!,"quantity":products.productQuantity!,"prod_price":products.oldPrice!]
			finalProd.append(dictionary1)
		}

		let credentials = getDefaults()
		
		let urlString = KBaseUrl + KOrderCheckout

		let parameters:[String:AnyObject] = ["first_name":credentials["first_name"] as AnyObject,"last_name":credentials["last_name"] as AnyObject,"email":"jyotirajwani@hotmail.com" as AnyObject, "billing_address":credentials["billing_address_line_1"] as AnyObject,"billing_address_line_1":credentials["billing_address_line_1"] as AnyObject,"billing_address_line_2":credentials["billing_address_line_2"] as AnyObject,"billing_city":credentials["billing_city"] as AnyObject,"billing_zip_code":credentials["billing_zip_code"] as AnyObject,"billing_phone":credentials["billing_phone"] as AnyObject,"password_register":credentials["billing_phone"] as AnyObject,"re_password_register":"" as AnyObject,"shipping_first_name":self.txtShippingFirstName.text as AnyObject,"shipping_last_name":self.txtShippingLastName.text as AnyObject,"shipping_address":self.txtShippingAddress.text as AnyObject,"shipping_address_line_1":self.txtShippingAddress1.text as AnyObject,"shipping_address_line_2":self.txtShippingAddress2.text as AnyObject,"shipping_city":self.txtShippingCity.text as AnyObject,"shipping_zip_code":self.txtShippingPostalCode.text as AnyObject,"shipping_phone":self.txtShippingPhoneNumber.text as AnyObject,"preferred_date_of_delivery":self.btnShippinpDate.titleLabel?.text as AnyObject,
											 "product_items": finalProd as AnyObject,
											 
											 "payment_type":"cod" as AnyObject,"sub_total":credentials["sub_total"] as AnyObject,"value_added_tax":credentials["value_added_tax"] as AnyObject,"grand_total":credentials["grand_total"] as AnyObject,
											 "amount_currency":"AED" as AnyObject,"checkout_type":"guest" as AnyObject,"referrer":"" as AnyObject,"clean_referrer":"" as AnyObject,"user_id":credentials["user_id"]  as AnyObject]
		
		if Reachability.isConnectedToInternet(){
			
			SVProgressHUD.show(withStatus: "Loading Request")
			
			Alamofire.request(urlString,method:.post,parameters: parameters, encoding: JSONEncoding.default).responseJSON { (response) -> Void in
				
				switch(response.result) {
				case .success(_):
					
					SVProgressHUD.dismiss()
					
					if let result = response.result.value as? NSDictionary {
						switch(result["success"] as? Int)
						{
						case 404:
							self.alerts(title: kError, message: "kEmailAlreadyExist")
						case 200:
							let prefs = UserDefaults.standard
							prefs.removeObject(forKey:"Products")
							let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "homeID") as! HomeViewController
							self.navigationController?.pushViewController(nextViewController, animated: true)
							
							self.alerts(title: "Order Placed", message: "Thanks for shopping at NRTC Fresh")
	
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
	
	}

}
