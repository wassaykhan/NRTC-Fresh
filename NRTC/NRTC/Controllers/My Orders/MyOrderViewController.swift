//
//  MyOrderViewController.swift
//  NRTC
//
//  Created by Wassay Khan on 15/10/2018.
//  Copyright © 2018 Netpace. All rights reserved.
//

import UIKit
import BadgeSwift
import Alamofire
import SVProgressHUD
import SDWebImage

class MyOrderViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
	
	

	@IBOutlet weak var lbBadgeCount: BadgeSwift!
	@IBOutlet weak var mainTableView: UITableView!
	
	var orderData:User?
	var allOrders:Array<User> = []
	var arrProducts:Array<Product> = []
	
	
    override func viewDidLoad() {
        super.viewDidLoad()
		self.getOrders()
        // Do any additional setup after loading the view.
    }
	
	override func viewWillAppear(_ animated: Bool) {
		print("view will appear")
		let userDefaults = UserDefaults.standard
		self.arrProducts = []
		let decoded  = userDefaults.object(forKey: "Products") as? Data
		//		let decodedTeams?
		if decoded != nil {
			let selectedProducts = NSKeyedUnarchiver.unarchiveObject(with: decoded!) as! [Product]
			print(selectedProducts)
			
			for prod:Product in selectedProducts{
				self.arrProducts.append(prod)
			}
			
			self.lbBadgeCount.isHidden = false
			self.lbBadgeCount.text = String(selectedProducts.count)
		}else{
			self.lbBadgeCount.isHidden = true
		}
	}
	
    
	@IBAction func btnCartAction(_ sender: Any) {
		
		let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "orderIdentifier") as! OrderViewController
		nextViewController.arrProduct = self.arrProducts
		//		nextViewController.productID = NSNumber(value: Int(productID!)!)
		self.navigationController?.pushViewController(nextViewController, animated: true)
		
	}
	
	@IBAction func btnContactAction(_ sender: Any) {
		
		self.callUs()
		
	}
	@IBAction func btnBackAction(_ sender: Any) {
		self.navigationController?.popViewController(animated: true)
	}
	
	
	func getOrders()
	{
		
		let userPersonalID = UserDefaults.standard.integer(forKey: "user_id")
		
		let urlString = KBaseUrl + KGetOrders + String(userPersonalID)
		
		if Reachability.isConnectedToInternet(){
			SVProgressHUD.show(withStatus: "Loading Request")
			Alamofire.request(urlString,method:.get,parameters: nil , encoding: JSONEncoding.default).responseJSON { (response) -> Void in
				switch(response.result) {
				case .success(_):
					SVProgressHUD.dismiss()
					if let result = response.result.value as? NSDictionary {
						switch(result["code"] as? String)
						{
						case "404":
							self.alerts(title: kError, message: "No Order Found")
						case "200":
							
							let JSON:NSDictionary = (response.result.value as! NSDictionary?)!
							self.allOrders = []
							for dictionary in JSON["data"] as! NSArray{
								let order:User = User(orderDictinary: dictionary as! NSDictionary)
								self.allOrders.append(order)
							}
							print(self.allOrders)
							self.mainTableView.reloadData()
							
//							self.loginmodel = LoginModel(dictionary: result )
							
//							self.performSegue(withIdentifier: "loginButton", sender: self)
						default:
							self.alerts(title: kError, message: "No Order Found")
						}
						//
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
	
	
	
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.allOrders.count
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//		return 300
		return 130
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		//myOrderCellIdentifier
		let cellOrder:MyOrderTableViewCell = tableView.dequeueReusableCell(withIdentifier: "mainOrderCellIdentifier", for: indexPath) as! MyOrderTableViewCell
		cellOrder.lbOrderID.text =  "Order # " + (self.allOrders[indexPath.row].orderID ?? "Checking...")
		cellOrder.lbTotal.text = "Total: AED " + (self.allOrders[indexPath.row].grandTotal  ?? "0.0")
		cellOrder.lbStatus.text  = "Status: " + (self.allOrders[indexPath.row].orderStatus ?? "UNKNOWN")
		cellOrder.lbDeliveredOn.text = "Preferred delivery date: " + (self.allOrders[indexPath.row].preferredDateOfDelivery ?? "None")
		return cellOrder
		
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
