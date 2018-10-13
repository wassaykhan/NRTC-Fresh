//
//  OrderViewController.swift
//  NRTC
//
//  Created by Wassay Khan on 02/10/2018.
//  Copyright © 2018 Netpace. All rights reserved.
//

import UIKit

class OrderViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
	@IBOutlet weak var orderTableView: UITableView!
	@IBOutlet weak var lbSubTotal: UILabel!
	@IBOutlet weak var lbTotal: UILabel!
	
	
//	var source = ["1","2","3","4","5","6","7","8"]
	var arrProduct:Array<Product>?
	
	override func viewDidLoad() {
		super.viewDidLoad()

		orderTableView.delegate = self
		orderTableView.dataSource = self
		
		self.lbSubTotal.text = "$" + String(self.calculateTotalAmount(products: self.arrProduct!))
		self.lbTotal.text = "$" + String(self.calculateTotalAmount(products: self.arrProduct!))
		
		// Do any additional setup after loading the view.
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
		
		cellNewProduct.lbQuantity.text = self.arrProduct?[indexPath.row].productQuantity
		cellNewProduct.lbTitle.text = self.arrProduct?[indexPath.row].title
		cellNewProduct.lbPrice.text = "AED " + (self.arrProduct?[indexPath.row].oldPrice)!
		cellNewProduct.imgProduct.sd_setImage(with: URL(string: (self.arrProduct?[indexPath.row].productImage)!), placeholderImage: UIImage(named: ""))
		cellNewProduct.onAddTapped = {
			let quantity:NSString = cellNewProduct.lbQuantity!.text! as NSString
			
			let value = quantity.intValue + 1
			
			print("Update value")
			print("index path")
			print(indexPath.row)
			self.arrProduct?[indexPath.row].oldPrice = String(value)
			
			let cell = tableView.cellForRow(at: indexPath) as! OrderTableViewCell
			cell.lbQuantity.text = String(value)
			//Do whatever you want to do when the button is tapped here
		}
		
		return cellNewProduct
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 130
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

}
