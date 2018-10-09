//
//  BillingViewController.swift
//  NRTC
//
//  Created by Wassay Khan on 03/10/2018.
//  Copyright © 2018 Netpace. All rights reserved.
//

import UIKit

class BillingViewController: UIViewController {

	@IBOutlet weak var phone: UITextField!
	@IBOutlet weak var zip: UITextField!
	@IBOutlet weak var state: UITextField!
	@IBOutlet weak var city: UITextField!
	@IBOutlet weak var address: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
		addborder(name: address , label :"Address *")
		addborder(name: city, label: "Town /City *")
		addborder(name: state,label: "State *")
		addborder(name: zip,label: "ZIP *")
		addborder(name: phone,label: "Phone *")
        // Do any additional setup after loading the view.
    }
	func addborder(name : UITextField,label : String)
	{
		let border1 = CALayer()
		let width = CGFloat(1.0)
		border1.frame = CGRect(x: 0, y: name.frame.size.height - width, width: name.frame.size.width, height: name.frame.size.height)
		
		border1.borderWidth = 0.5
		name.layer.addSublayer(border1)
		name.layer.masksToBounds = true
		name.placeholder = label
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
