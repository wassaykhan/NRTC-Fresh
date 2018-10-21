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
	var allOrders:Array<Orders> = []
	
	var numOfViews:Int = 0
	
	//for Cart
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
								let product:Orders = Orders(orderDictinary: dictionary as! NSDictionary)
								print(product)
								self.allOrders.append(product)
							}
							print(self.allOrders)
							self.mainTableView.reloadData()
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
//		return 130
		return (CGFloat(83 + (100*self.allOrders[indexPath.row].productArr.count)))
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		//myOrderCellIdentifier
		let cellOrder:MyOrderTableViewCell = tableView.dequeueReusableCell(withIdentifier: "mainOrderCellIdentifier", for: indexPath) as! MyOrderTableViewCell
		
		
		
//		cellOrder.clearsContextBeforeDrawing = true
		
//		cellOrder.contentView.willRemoveSubview(<#T##subview: UIView##UIView#>)
		
		cellOrder.lbOrderID.text =  "Order # " + (self.allOrders[indexPath.row].orderID ?? "Checking...")
		cellOrder.lbTotal.text = "Total: AED " + (self.allOrders[indexPath.row].grandTotal  ?? "0.0")
		cellOrder.lbStatus.text  = "Status: " + (self.allOrders[indexPath.row].orderStatus ?? "UNKNOWN")
		cellOrder.lbDeliveredOn.text = "Preferred delivery date: " + (self.allOrders[indexPath.row].preferredDateOfDelivery ?? "None")
		cellOrder.lbItems.text = String(self.allOrders[indexPath.row].productArr.count) + " items"
		var myView = UIView(frame: CGRect(x: 0, y: cellOrder.lbStatus.bounds.height + cellOrder.lbStatus.frame.origin.y, width: cellOrder.viewBackground.bounds.width - 10, height: 80))
		
		numOfViews = self.allOrders[indexPath.row].productArr.count
		
		for n in 0..<numOfViews {
			print(n)
			
			if n == 0 {
				// Product Image
				let imgItem = UIImageView(frame: CGRect(x: 20, y: 10, width: 50, height: 50))
				imgItem.sd_setImage(with: URL(string: (self.allOrders[indexPath.row].productArr[n].productOrderImage)!), placeholderImage: UIImage(named: ""))
				myView.addSubview(imgItem)
				//Product Title
				let lbTitle = UILabel(frame: CGRect(x: imgItem.frame.origin.x + 70, y: imgItem.frame.origin.y + 5, width: 300, height: 20))
				lbTitle.text = self.allOrders[indexPath.row].productArr[n].title
				lbTitle.tag = 100
				lbTitle.textColor = UIColor.gray
				lbTitle.font = UIFont.boldSystemFont(ofSize: 13)
				myView.addSubview(lbTitle)
				
//				lbTitle.text = ""
				//Product Price and Quantity
				let lbPriceQuantity = UILabel(frame: CGRect(x: imgItem.frame.origin.x + 70, y: lbTitle.frame.origin.y + 15, width: 300, height: 20))
				lbPriceQuantity.text = self.allOrders[indexPath.row].productArr[n].oldPrice! + " x " + self.allOrders[indexPath.row].productArr[n].productOrderQuantity!
				lbPriceQuantity.textColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0) 
				lbPriceQuantity.font = UIFont.systemFont(ofSize: 12)
				myView.addSubview(lbPriceQuantity)
				//Product Total
				let lbTotal = UILabel(frame: CGRect(x: imgItem.frame.origin.x + 70, y: lbPriceQuantity.frame.origin.y + 15, width: 300, height: 20))
				let price = self.allOrders[indexPath.row].productArr[n].oldPrice! as NSString
				let quantity = self.allOrders[indexPath.row].productArr[n].productOrderQuantity! as NSString
				let total = price.intValue * quantity.intValue
				lbTotal.text = "Total: " + String(total)
				lbTotal.textColor = UIColor(red: 0.31, green: 0.72, blue: 0.41, alpha: 1)
				lbTotal.font = UIFont.boldSystemFont(ofSize: 13)
				myView.addSubview(lbTotal)
				
				cellOrder.viewBackground.addSubview(myView)
				
				
				
			}else{
				
				let imgItems = UIImageView(frame: CGRect(x: 20, y: 10, width: 50, height: 50))
				imgItems.sd_setImage(with: URL(string: (self.allOrders[indexPath.row].productArr[n].productOrderImage)!), placeholderImage: UIImage(named: ""))
				let nextView = UIView(frame: CGRect(x: 0, y: myView.frame.origin.y + 100, width: cellOrder.viewBackground.bounds.width - 10, height: 80))
				nextView.addSubview(imgItems)
				//Product Title
				let lbTitle = UILabel(frame: CGRect(x: imgItems.frame.origin.x + 70, y: imgItems.frame.origin.y + 5, width: 300, height: 20))
				lbTitle.text = self.allOrders[indexPath.row].productArr[n].title
				lbTitle.textColor = UIColor.gray
				lbTitle.font = UIFont.boldSystemFont(ofSize: 13)
				nextView.addSubview(lbTitle)
				//Product Price and Quantity
				let lbPriceQuantity = UILabel(frame: CGRect(x: imgItems.frame.origin.x + 70, y: lbTitle.frame.origin.y + 15, width: 300, height: 20))
				lbPriceQuantity.text = self.allOrders[indexPath.row].productArr[n].oldPrice! + " x " + self.allOrders[indexPath.row].productArr[n].productOrderQuantity!
				lbPriceQuantity.textColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0)
				lbPriceQuantity.font = UIFont.systemFont(ofSize: 12)
				nextView.addSubview(lbPriceQuantity)
				//Product Total
				let lbTotal = UILabel(frame: CGRect(x: imgItems.frame.origin.x + 70, y: lbPriceQuantity.frame.origin.y + 15, width: 300, height: 20))
				let price = self.allOrders[indexPath.row].productArr[n].oldPrice! as NSString
				let quantity = self.allOrders[indexPath.row].productArr[n].productOrderQuantity! as NSString
				let total = price.intValue * quantity.intValue
				lbTotal.text = "Total: " + String(total)
				lbTotal.textColor = UIColor(red: 0.31, green: 0.72, blue: 0.41, alpha: 1)
				lbTotal.font = UIFont.boldSystemFont(ofSize: 13)
				nextView.addSubview(lbTotal)
				
				
				cellOrder.viewBackground.addSubview(nextView)
				myView = UIView(frame: CGRect(x: 0, y: nextView.frame.origin.y, width: cellOrder.viewBackground.bounds.width - 10, height: 80))
			}
		}
		
//		cellOrder.clipsToBounds = true
//		cellOrder.clearsContextBeforeDrawing = true
		
		return cellOrder
	}

}
