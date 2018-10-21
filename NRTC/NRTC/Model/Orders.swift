//
//  Orders.swift
//  NRTC
//
//  Created by Wassay Khan on 17/10/2018.
//  Copyright © 2018 Netpace. All rights reserved.
//

import UIKit

class Orders: NSObject {
	
	var userID:String?
	var orderID:String?
	var insertTime:String?
	var preferredDateOfDelivery:String?
	var orderStatus:String?
	var grandTotal:String?
	var productArr: Array<Product> = []
	
	init(orderDictinary : NSDictionary) {
		userID = orderDictinary["id"] as? String
		orderID = orderDictinary["order_id"] as? String
		preferredDateOfDelivery = orderDictinary["preferred_date_of_delivery"] as? String
		orderStatus = orderDictinary["order_status"] as? String
		grandTotal = orderDictinary["grand_total"] as? String
		
		//Getting all the items from Order
		self.productArr = []
		for dict in orderDictinary["items"] as! NSArray{
			let product:Product = Product(dictionary: dict as! NSDictionary)
			self.productArr.append(product)
		}
		
	}
}
