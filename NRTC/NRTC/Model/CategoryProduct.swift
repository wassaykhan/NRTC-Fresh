//
//  CategoryProduct.swift
//  NRTC
//
//  Created by Wassay Khan on 11/10/2018.
//  Copyright © 2018 Netpace. All rights reserved.
//

import UIKit

class CategoryProduct: NSObject {
	
	var id:String?
	var image:String?
	var quantity:String?
	var title:String?
	var price:String?
	var oldPrice:String?
	var url:String?
	var notes:String?
	var origin:String?
	var productDescription:String?
	var packaging:String?
	var weight:String?
	var productVisibility:String?
	var productCategory:String?

	init(dictionary : NSDictionary){
		self.id = dictionary["id"] as? String
		self.image = dictionary["image"] as? String
		self.quantity = dictionary["quantity"] as? String
		self.title = dictionary["title"] as? String
		self.price = dictionary["price"] as? String
		self.oldPrice = dictionary["old_price"] as? String
		self.url = dictionary["url"] as? String
		self.notes = dictionary["notes"] as? String
		self.origin = dictionary["origin"] as? String
		self.productDescription = dictionary["description"] as? String
		self.packaging = dictionary["packaging"] as? String
		self.weight = dictionary["weight"] as? String
		self.productVisibility = dictionary["product_visibility"] as? String
		self.productCategory = dictionary["product_category"] as? String
	}
	
}
