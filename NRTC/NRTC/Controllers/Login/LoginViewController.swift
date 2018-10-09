//
//  LoginViewController.swift
//  NRTC
//
//  Created by Wassay Khan on 03/10/2018.
//  Copyright © 2018 Netpace. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

	@IBOutlet weak var password: UITextField!
	@IBOutlet weak var username: UITextField!
	
    override func viewDidLoad() {
        super.viewDidLoad()
		let border = CALayer()
		let width = CGFloat(1.0)
		border.frame = CGRect(x: 0, y: username.frame.size.height - width, width: username.frame.size.width, height: username.frame.size.height)
		
		border.borderWidth = 0.5
		username.layer.addSublayer(border)
		username.layer.masksToBounds = true
		
		let border1 = CALayer()
		// let width1 = CGFloat(1.0)
		border1.frame = CGRect(x: 0, y: password.frame.size.height - width, width: password.frame.size.width, height: password.frame.size.height)
		
		border1.borderWidth = 0.5
		password.layer.addSublayer(border1)
		password.layer.masksToBounds = true
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
