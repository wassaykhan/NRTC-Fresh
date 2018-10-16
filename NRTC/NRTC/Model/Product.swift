//
//  Product.swift
//  NRTC
//
//  Created by Wassay Khan on 12/10/2018.
//  Copyright © 2018 Netpace. All rights reserved.
//

import UIKit

class Product: NSObject, NSCoding {
	
	var productId:String?
	var productImage:String?
	var productTimeCreated:String?
	var productTimeUpdated:String?
	var productQuantityAvailable:String?
	var title:String?
	var price:String?
	var oldPrice:String?
	var productUrl:String?
	var basicDescription:String?
	var productDescription:String?
	var productPosition:String?
	var productVisibility:String?
	var productCategory:String?
	var productQuantity:String?
	var weight:String?
	var packaging:String?
	var origin:String?
	var notes:String?
	var productColor:String?
	
	
	init(dictionary : NSDictionary){
		self.productId = dictionary["product_id"] as? String
		self.productImage = dictionary["product_image"] as? String
		self.productQuantityAvailable = dictionary["product_quantity_available"] as? String
		self.title = dictionary["title"] as? String
		self.price = dictionary["price"] as? String
		self.oldPrice = dictionary["old_price"] as? String
		self.productUrl = dictionary["product_url"] as? String
		self.productTimeCreated = dictionary["product_time_created"] as? String
		self.productTimeUpdated = dictionary["product_time_updated"] as? String
		self.productDescription = dictionary["description"] as? String
		self.productPosition = dictionary["product_position"] as? String
		self.basicDescription = dictionary["basic_description"] as? String
		self.productVisibility = dictionary["product_visibility"] as? String
		self.productCategory = dictionary["product_category"] as? String
		
		self.weight = dictionary["weight"] as? String
		self.productColor = dictionary["color"] as? String
		self.packaging = dictionary["packaging"] as? String
		self.origin = dictionary["origin"] as? String
		self.notes = dictionary["notes"] as? String
		
	}
	
	func encode(with aCoder: NSCoder) {
		aCoder.encode(self.productId, forKey: "productId")
		aCoder.encode(self.productImage, forKey: "productImage")
		aCoder.encode(self.productQuantityAvailable, forKey: "productQuantityAvailable")
		aCoder.encode(self.title, forKey: "title")
		aCoder.encode(self.price, forKey: "price")
		aCoder.encode(self.oldPrice, forKey: "oldPrice")
		aCoder.encode(self.productUrl, forKey: "productUrl")
		aCoder.encode(self.productTimeCreated, forKey: "productTimeCreated")
		aCoder.encode(self.productTimeUpdated, forKey: "productTimeUpdated")
		aCoder.encode(self.productDescription, forKey: "productDescription")
		aCoder.encode(self.productPosition, forKey: "productPosition")
		aCoder.encode(self.basicDescription, forKey: "basicDescription")
		aCoder.encode(self.productVisibility, forKey: "productVisibility")
		aCoder.encode(self.productCategory, forKey: "productCategory")
		aCoder.encode(self.productQuantity,forKey: "productQuantity")
	}
	
	required init?(coder aDecoder: NSCoder) {
		
		self.productId = aDecoder.decodeObject(forKey: "productId") as? String
		self.productImage = aDecoder.decodeObject(forKey: "productImage") as? String
		self.productQuantityAvailable = aDecoder.decodeObject(forKey: "productQuantityAvailable") as? String
		self.title = aDecoder.decodeObject(forKey: "title") as? String
		self.price = aDecoder.decodeObject(forKey: "price") as? String
		self.oldPrice = aDecoder.decodeObject(forKey: "oldPrice") as? String
		self.productUrl = aDecoder.decodeObject(forKey: "productUrl") as? String
		self.productTimeCreated = aDecoder.decodeObject(forKey: "productTimeCreated") as? String
		self.productTimeUpdated = aDecoder.decodeObject(forKey: "productTimeUpdated") as? String
		self.productDescription = aDecoder.decodeObject(forKey: "productDescription") as? String
		self.productPosition = aDecoder.decodeObject(forKey: "productPosition") as? String
		self.basicDescription = aDecoder.decodeObject(forKey: "basicDescription") as? String
		self.productVisibility = aDecoder.decodeObject(forKey: "productVisibility") as? String
		self.productCategory = aDecoder.decodeObject(forKey: "productCategory") as? String
		self.productQuantity = aDecoder.decodeObject(forKey: "productQuantity") as? String
	}
	
	
	
	
}
