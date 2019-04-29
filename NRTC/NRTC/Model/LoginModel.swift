//
//  LoginModel.swift
//  NRTC
//
//  Created by Usama Naseer on 09/10/2018.
//  Copyright © 2018 Netpace. All rights reserved.
//

import UIKit

class LoginModel : NSObject {
    var status: Bool?
    var message, code, firstName: String?
	var userID:Int?
    var lastName, email: String?
    var address : NSDictionary?
	var billingAddressLine1:String?
	var billingAddressLine2:String?
	var billingZipCode:String?
	var billingCity:String?
	var billingCountry:String?
	var billingPhone:String?
	var gender:String?
	
	init(dictionarys : NSDictionary) {
		if let status = dictionarys["status"] as? Bool{
			self.status = status
		}
		//        status = dictionary["status"] as? Bool
		message = dictionarys["message"] as? String
		code = dictionarys["code"] as? String
		userID = dictionarys["user_id"] as? Int
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
		
		let userIDInt = dictionary["user_id"] as! NSString
		
		userID = Int(userIDInt as String)
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
