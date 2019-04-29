//
//  User.swift
//  NRTC
//
//  Created by Wassay Khan on 15/10/2018.
//  Copyright © 2018 Netpace. All rights reserved.
//

import UIKit

class User: NSObject {
	
	
	var userID:String?
	var orderID:String?
	var insertTime:String?
	var preferredDateOfDelivery:String?
	var orderStatus:String?
	var grandTotal:String?
	
	
	
	var status: Bool?
	var message, code, firstName: String?
	var lastName, email: String?
	var address : NSDictionary?
	var billingAddressLine1:String?
	var billingAddressLine2:String?
	var billingZipCode:String?
	var billingCity:String?
	var billingCountry:String?
	var billingPhone:String?
	var gender:String?
	
	
	init(orderDictinary : NSDictionary) {
		
		orderID = orderDictinary["order_id"] as? String
		preferredDateOfDelivery = orderDictinary["preferred_date_of_delivery"] as? String
		orderStatus = orderDictinary["order_status"] as? String
		grandTotal = orderDictinary["grand_total"] as? String
	}
	
	
	init(dictionarys : NSDictionary) {
		if let status = dictionarys["status"] as? Bool{
			self.status = status
		}
		//        status = dictionary["status"] as? Bool
		message = dictionarys["message"] as? String
		code = dictionarys["code"] as? String
		userID = dictionarys["user_id"] as? String
		firstName = dictionarys["first_name"] as? String
		lastName = dictionarys["last_name"] as? String
		email = dictionarys["email"] as? String
		gender = dictionarys["gender"] as? String
		
	}
	
	init(dictionary : NSDictionary) {
		if let status = dictionary["status"] as? Bool{
			self.status = status
		}
		//        status = dictionary["status"] as? Bool
		message = dictionary["message"] as? String
		code = dictionary["code"] as? String
		userID = dictionary["id"] as? String
		firstName = dictionary["first_name"] as? String
		lastName = dictionary["last_name"] as? String
		email = dictionary["email"] as? String
		gender = dictionary["gender"] as? String
		address = dictionary["addresses"] as? NSDictionary
		address = address!["billing_address"] as? NSDictionary
		billingAddressLine1 = address!["billing_address_line_1"] as? String
		billingAddressLine2 = address!["billing_address_line_2"] as? String
		billingZipCode = address!["billing_zip_code"] as? String
		billingCity = address!["billing_city"] as? String
		billingCountry = address!["billing_country"] as? String
		billingPhone = address!["billing_phone"] as? String
		
		
	}
}
