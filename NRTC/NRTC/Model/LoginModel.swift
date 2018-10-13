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
    var message, code, userID, firstName: String?
    var lastName, email: String?
    var address : NSDictionary?
    
    init(dictionary : NSDictionary) {
        if let status = dictionary["status"] as? Bool{
            self.status = status
        }
        //        status = dictionary["status"] as? Bool
        message = dictionary["message"] as? String
        code = dictionary["code"] as? String
        userID = dictionary["user_id"] as? String
        firstName = dictionary["first_name"] as? String
        lastName = dictionary["last_name"] as? String
        email = dictionary["email"] as? String
        address = dictionary["addresses"] as? NSDictionary
    }
    
    
    
}
