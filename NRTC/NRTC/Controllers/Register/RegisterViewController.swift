//
//  RegisterViewController.swift
//  NRTC
//
//  Created by Wassay Khan on 03/10/2018.
//  Copyright © 2018 Netpace. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
	@IBOutlet weak var password: UITextField!
	@IBOutlet weak var emailadd: UITextField!
	@IBOutlet weak var username: UITextField!
	@IBOutlet weak var lastname: UITextField!
	@IBOutlet weak var firstName: UITextField!
	
    override func viewDidLoad() {
        super.viewDidLoad()
		addborder(name: firstName , label :"First Name")
		addborder(name: lastname, label: "Last Name")
		addborder(name: username,label: "Username")
		addborder(name: emailadd,label: "Email Address")
		addborder(name: password,label: "Password")
        // Do any additional setup after loading the view.
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
