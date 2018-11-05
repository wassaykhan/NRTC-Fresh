//
//  OrderViewController.swift
//  NRTC
//
//  Created by Wassay Khan on 02/10/2018.
//  Copyright © 2018 Netpace. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage
import SVProgressHUD
import MessageUI

class OrderViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,MFMailComposeViewControllerDelegate {
	
	@IBOutlet weak var orderTableView: UITableView!
	@IBOutlet weak var lbSubTotal: UILabel!
	@IBOutlet weak var lbTotal: UILabel!
	@IBOutlet weak var lbTaxAmount: UILabel!
	
	var arrProduct:Array<Product>?
	var currQuantity:Int?
	var currTitle:String?
	var productID:String?
	var reload:Bool = false
	var saveTotal:Float?
	var saveSubTotal:Float?
	var saveTax:Float?
	
	
	
	override func viewDidLoad() {
		super.viewDidLoad()

		orderTableView.delegate = self
		orderTableView.dataSource = self
		
		
		if (self.arrProduct?.count)! > 0 {
//			self.lbSubTotal.text = "$" + String(self.calculateTotalAmount(products: self.arrProduct!))
			
			let total = self.calculateTotalAmount(products: self.arrProduct!)
			
			let subTotal = (total/105) * 100
			
			let tax = total - subTotal
			
			self.saveTotal = self.calculateTotalAmount(products: self.arrProduct!)
			self.saveTax = tax
			self.saveSubTotal = subTotal
			
			self.lbSubTotal.text = "AED " + String(format: "%.2f", subTotal)//String(subTotal)
			self.lbTaxAmount.text = "AED " + String(format: "%.2f", tax)//String(tax)
			self.lbTotal.text = "AED " + String(format: "%.2f", self.calculateTotalAmount(products: self.arrProduct!))//String(self.calculateTotalAmount(products: self.arrProduct!))
		}
//		else{
//			self.lbSubTotal.text = "AED 0.0"
//			self.lbTaxAmount.text = "AED 0.0"
//			self.lbTotal.text = "AED 0.0"
//		}
		
		
		

	}
	@IBAction func btnEmailAction(_ sender: Any) {
		let composeVC = MFMailComposeViewController()
		composeVC.mailComposeDelegate = self
		
		// Configure the fields of the interface.
		composeVC.setToRecipients(["customercare@nrtcfresh.com"])
		composeVC.setSubject("Message Subject")
		composeVC.setMessageBody("Message content.", isHTML: false)
		
		// Present the view controller modally.
		self.present(composeVC, animated: true, completion: nil)
	}
	
	func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
		controller.dismiss(animated: true, completion: nil)
	}
	
	
	func calculateTotalAmount(products:Array<Product>) -> Float {
		
		var total:Float = 0
		for item:Product in products{
			
			let price:NSString = item.oldPrice! as NSString
			let quantity:NSString = item.productQuantity! as NSString
			total +=  price.floatValue * quantity.floatValue
			
		}
		return total
	}
	
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.arrProduct?.count ?? 0
	}
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let cellNewProduct:OrderTableViewCell = self.orderTableView.dequeueReusableCell(withIdentifier: "orderCellIdentifier") as! OrderTableViewCell
		
		if self.arrProduct?[indexPath.row].packaging == "KG" || self.arrProduct?[indexPath.row].packaging == "kg"{
			
			var weight:Float = 0.25
			let quantity:NSString = self.arrProduct![indexPath.row].productQuantity! as NSString
			self.currQuantity = Int(quantity as String)
			weight = weight*quantity.floatValue
			cellNewProduct.lbQuantity.text = String(weight)
			
			//for Unit Price
			let quarterPrice = self.arrProduct![indexPath.row].oldPrice! as NSString
			let kgPrice = quarterPrice.floatValue * 4
			cellNewProduct.lbUnitPrice.text = "Unit Price: AED " + String(format: "%.2f", kgPrice) + "/KG"
			//for Total Price
			let totalP = quarterPrice.floatValue * Float(self.currQuantity!)
			cellNewProduct.lbPrice.text = "Total: AED " + String(format: "%.2f", totalP)
			
			
			
		}else{
			cellNewProduct.lbQuantity.text = self.arrProduct?[indexPath.row].productQuantity
			let price = self.arrProduct![indexPath.row].oldPrice! as NSString
			let quantity:NSString = self.arrProduct![indexPath.row].productQuantity! as NSString
			//for Unit Price
			cellNewProduct.lbUnitPrice.text = "Price: AED " + (self.arrProduct?[indexPath.row].oldPrice)! + "/Pack"
			//For Total
			let totalP = quantity.floatValue * price.floatValue
			cellNewProduct.lbPrice.text = "Total: AED " + String(format: "%.2f", totalP)
			
		}
		print("hoja")
		//print(self.arrProduct?[indexPath.row].packaging!)
		cellNewProduct.lbTitle.text = self.arrProduct?[indexPath.row].title
//		cellNewProduct.lbPrice.text = "Total: AED " + (self.arrProduct?[indexPath.row].oldPrice)!
		cellNewProduct.imgProduct.sd_setImage(with: URL(string: (self.arrProduct?[indexPath.row].productImage)!), placeholderImage: UIImage(named: ""))
		
		
		
		
		cellNewProduct.onAddTapped = {
			self.productID = self.arrProduct?[indexPath.row].productId
			self.currTitle = cellNewProduct.lbTitle.text
//			self.currIndex = indexPath.row
//			self.currTitle = cellNewProduct.lbQuantity.text
			self.currQuantity = 0
			if self.arrProduct?[indexPath.row].packaging == "KG" || self.arrProduct?[indexPath.row].packaging == "kg"{
				
				var weight:Float = 0.25
				
				let quantity:NSString = self.arrProduct![indexPath.row].productQuantity! as NSString
				let newQuantity = 	quantity.intValue + 1
				self.currQuantity = Int(newQuantity)
				print(newQuantity)
				weight = weight*Float(newQuantity)
				print(weight)
				self.updateCart()
//				var weight:Float = 0.25
//				weight = weight*Float(self.currQuantity)
//				let cell = tableView.cellForRow(at: indexPath) as! OrderTableViewCell
//				cell.lbQuantity.text = String(weight)
				cellNewProduct.lbQuantity.text = String(weight)
				print(weight)
				
			}else{
//				self.lbQuantity.text = "1"
				let quantity:NSString = cellNewProduct.lbQuantity!.text! as NSString
				let value = quantity.intValue + 1
				self.currQuantity = Int(value)
				self.updateCart()
//				let cell = tableView.cellForRow(at: indexPath) as! OrderTableViewCell
//				cell.lbQuantity.text = String(value)
				cellNewProduct.lbQuantity.text = String(value)

			}
			
//			print("index path ", indexPath.row)
			print(indexPath.row)
//			self.arrProduct?[indexPath.row].oldPrice = String(value)
			
			
			
			//Do whatever you want to do when the button is tapped here
		}
		
		cellNewProduct.onSubTapped = {
			self.productID = self.arrProduct?[indexPath.row].productId
			self.currTitle = cellNewProduct.lbTitle.text

			if self.arrProduct?[indexPath.row].packaging == "KG" || self.arrProduct?[indexPath.row].packaging == "kg"{
				
				var weight:Float = 0.25
				
				let quantity:NSString = self.arrProduct![indexPath.row].productQuantity! as NSString
				let newQuantity = 	quantity.floatValue - 1
				self.currQuantity = Int(newQuantity)
				weight = weight*newQuantity
				
				//				var weight:Float = 0.25
				//				weight = weight*Float(self.currQuantity)
				let cell = tableView.cellForRow(at: indexPath) as! OrderTableViewCell
				cell.lbQuantity.text = String(weight)
				//				cellNewProduct.lbQuantity.text = String(weight)
				self.updateCart()
				
			}else{
				//				self.lbQuantity.text = "1"
				let quantity:NSString = cellNewProduct.lbQuantity!.text! as NSString
				let value = quantity.intValue - 1
				self.currQuantity = Int(value)
				
				let cell = tableView.cellForRow(at: indexPath) as! OrderTableViewCell
				cell.lbQuantity.text = String(value)
				self.updateCart()
				
			}
			
			
			
			
			
		}
		
		
		return cellNewProduct
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 130
	}
	
	
	
	func updateCart(){
		
		let userDefaults = UserDefaults.standard
		self.arrProduct = []
		let decoded  = userDefaults.object(forKey: "Products") as? Data
		//		let decodedTeams?
		if decoded != nil {
			let selectedProducts = NSKeyedUnarchiver.unarchiveObject(with: decoded!) as! [Product]
			print(selectedProducts)
//			selectedProducts[currIndex]
			if selectedProducts.count > 0 {
				for product:Product in selectedProducts{
					
//					if self.currTitle == product.title{
					if self.productID == product.productId{
						if	self.currQuantity! < 1 {
							print("Dont Add")
							self.reload = true
						}else{
							product.productQuantity = String(self.currQuantity!)
							self.arrProduct?.append(product)
						}
						
					}else{
						self.arrProduct?.append(product)
					}
					
					

				}
			}
		}
		
		
		
		
//		self.arrProducts?.append(self.product!)
	
		let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: arrProduct!)
		userDefaults.set(encodedData, forKey: "Products")
		userDefaults.synchronize()
		
//		if reload {
			self.orderTableView.reloadData()
//		self.lbSubTotal.text = String(self.calculateTotalAmount(products: self.arrProduct!))
//		self.lbTotal.text = String(self.calculateTotalAmount(products: self.arrProduct!))
//		}
		
		let total = self.calculateTotalAmount(products: self.arrProduct!)
		
		let subTotal = (total/105) * 100
		
		let tax = total - subTotal
		
		self.saveTotal = self.calculateTotalAmount(products: self.arrProduct!)
		self.saveTax = tax
		self.saveSubTotal = subTotal
		
		self.lbSubTotal.text = "AED " + String(format: "%.2f", subTotal)//String(subTotal)
		self.lbTaxAmount.text = "AED " + String(format: "%.2f", tax)//String(tax)
		self.lbTotal.text = "AED " + String(format: "%.2f", self.calculateTotalAmount(products: self.arrProduct!))//String(self.calculateTotalAmount(products: self.arrProduct!))
		
	}
	
    
	@IBAction func btnContinueShoppingAction(_ sender: Any) {
		for controller in self.navigationController!.viewControllers as Array {
			if controller.isKind(of: HomeViewController.self) {
				self.navigationController!.popToViewController(controller, animated: true)
				break
			}
		}
	}
	
	@IBAction func btnBackAction(_ sender: Any) {
		self.navigationController?.popViewController(animated: true)
	}
	/*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
	@IBAction func btnContactAction(_ sender: Any) {
		self.callUs()
	}
	@IBAction func btnCheckoutAction(_ sender: Any) {
		
		let quantity = self.calculateTotalAmount(products: self.arrProduct!)
//		let value = quantity.intValue
		if quantity < 80 {
			self.alerts(title: "Sorry", message: "The minimum ammount to fullfil your order is AED 80. Please add more item/s to Cart")
			return
		}
		
		if (self.arrProduct?.count)! < 1 {
			self.alerts(title: "No Products", message: "Please select products for Checkout")
			return
		}
		
		if UserDefaults.standard.string(forKey: "first_name") == nil {
			let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "loginID") as! LoginViewController
			self.navigationController?.pushViewController(nextViewController, animated: true)
			return
		}
		
		UserDefaults.standard.set(self.saveSubTotal, forKey: "sub_total")
		UserDefaults.standard.set(self.saveTotal, forKey: "grand_total")//value_added_tax
		UserDefaults.standard.set(self.saveTax, forKey: "value_added_tax")
		let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "shippingID") as! ShippingViewController
		nextViewController.arrProduct = self.arrProduct
		self.navigationController?.pushViewController(nextViewController, animated: true)
		
		return
		
		
		var finalProd = [[String: String]]()
		
		for products:Product in arrProduct! {
			let dictionary1: [String: String] = ["product_id":products.productId!,"quantity":products.productQuantity!,"prod_price":products.oldPrice!]
			finalProd.append(dictionary1)
		}
		
		
		let credentials = getDefaults()
		
		let urlString = KBaseUrl + KOrderCheckout
		
		
		
		
		let parameters:[String:AnyObject] = ["first_name":credentials["first_name"] as AnyObject,"last_name":credentials["last_name"] as AnyObject,"email":"jyotirajwani@hotmail.com" as AnyObject, "billing_address":credentials["billing_address_line_1"] as AnyObject,"billing_address_line_1":credentials["billing_address_line_1"] as AnyObject,"billing_address_line_2":credentials["billing_address_line_2"] as AnyObject,"billing_city":credentials["billing_city"] as AnyObject,"billing_zip_code":credentials["billing_zip_code"] as AnyObject,"billing_phone":credentials["billing_phone"] as AnyObject,"password_register":credentials["billing_phone"] as AnyObject,"re_password_register":"" as AnyObject,"shipping_first_name":"jhkjkjk" as AnyObject,"shipping_last_name":"jkljljlk" as AnyObject,"shipping_address":"ghfhtyjt" as AnyObject,"shipping_address_line_1":"ghfhtyjt" as AnyObject,"shipping_address_line_2":"" as AnyObject,"shipping_city":"DUBAI" as AnyObject,"shipping_zip_code":"54165456" as AnyObject,"shipping_phone":"0653656" as AnyObject,"preferred_date_of_delivery":"09 October 2018" as AnyObject,
			"product_items": finalProd as AnyObject,
			
			"payment_type":"cod" as AnyObject,"sub_total":"19.0476190476" as AnyObject,"value_added_tax":"0.952380952381" as AnyObject,"grand_total":"20.00" as AnyObject,
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
//			SVProgressHUD.dismiss()
			self.alerts(title: kInternet, message: kCheckInternet)
		}
		
	}
}
