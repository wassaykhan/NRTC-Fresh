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
	var source = ["1","2","3","4","5","6","7","8"]
	override func viewDidLoad() {
		super.viewDidLoad()

		orderTableView.delegate = self
		orderTableView.dataSource = self
		// Do any additional setup after loading the view.
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 8
	}
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let cellNewProduct:OrderTableViewCell = self.orderTableView.dequeueReusableCell(withIdentifier: "orderCellIdentifier") as! OrderTableViewCell
		
//		let celll = self.orderTableView.cellForRow(at: indexPath)
		cellNewProduct.lbQuantity.text = source[indexPath.row]
		cellNewProduct.onAddTapped = {
			let quantity:NSString = cellNewProduct.lbQuantity!.text! as NSString
			
			let value = quantity.intValue + 1
			
			//cellNewProduct.lbQuantity.text = String(value)
			
			print("Update value")
			print("index path")
			print(indexPath.row)
			self.source[indexPath.row] = String(value)
			
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
