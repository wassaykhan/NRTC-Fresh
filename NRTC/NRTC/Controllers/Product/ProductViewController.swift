//
//  ProductViewController.swift
//  NRTC
//
//  Created by Wassay Khan on 01/10/2018.
//  Copyright © 2018 Netpace. All rights reserved.
//

import UIKit
import ImageSlideshow
import Alamofire
import SDWebImage

class ProductViewController: UIViewController {

	@IBOutlet weak var bgStockView: UIView!
	@IBOutlet weak var slideShowView: ImageSlideshow!
	@IBOutlet weak var lbTitle: UILabel!
	@IBOutlet weak var lbPrice: UILabel!
	@IBOutlet weak var lbQuantity: UILabel!
	@IBOutlet weak var lbDescription: UILabel!
	@IBOutlet weak var imgProduct: UIImageView!
	
//	var productID:Int?
	
	var productID:NSNumber?
	var product:Product?
	var arrProducts:Array<Product>?
	
	override func viewDidLoad() {
        super.viewDidLoad()
		self.getProductDetail()
		self.bgStockView.layer.cornerRadius = 10
		self.bgStockView.clipsToBounds = true
		slideShowView.setImageInputs([
			ImageSource(image: UIImage(named: "Image_47")!)
			])
		slideShowView.pageIndicatorPosition = .init(horizontal: .center, vertical: .under)
		slideShowView.contentScaleMode = UIView.ContentMode.scaleAspectFill
		
		let pageControl = UIPageControl()
		pageControl.currentPageIndicatorTintColor = UIColor.lightGray
		pageControl.pageIndicatorTintColor = UIColor.black
		slideShowView.pageIndicator = pageControl
		slideShowView.pageIndicator?.numberOfPages = 2
		
		slideShowView.activityIndicator = DefaultActivityIndicator()
		slideShowView.currentPageChanged = { page in
			print("current page:", page)
		}

		let recognizer = UITapGestureRecognizer(target: self, action: #selector(self.didTap))
		slideShowView.addGestureRecognizer(recognizer)
		
        // Do any additional setup after loading the view.
    }
	
	@objc func didTap() {
		let fullScreenController = slideShowView.presentFullScreenController(from: self)
		// set the activity indicator for full screen controller (skipping the line will show no activity indicator)
		fullScreenController.slideshow.activityIndicator = DefaultActivityIndicator(style: .white, color: nil)
	}
	
	@IBAction func btnBackAction(_ sender: Any) {
		self.navigationController?.popViewController(animated: true)
	}
	
	fileprivate func getProductDetail() {
		if Reachability.isConnectedToInternet() {
			print("Yes! internet is available.")
			//			SVProgressHUD.show(withStatus: "Loading Request")
			
			let urlString = KBaseUrl + KProductDetail + (productID!.stringValue)
			Alamofire.request(urlString, method: .get, parameters: nil, encoding: JSONEncoding.default)
				.downloadProgress(queue: DispatchQueue.global(qos: .utility)) { progress in
					print("Progress: \(progress.fractionCompleted)")
				}
				.validate { request, response, data in
					return .success
				}
				.responseJSON { response in
					debugPrint(response)
					
					//SVProgressHUD.dismiss()
					if	response.result.value == nil {
						
					//self.alerts(title: "Alert", message: "Response time out")
						return
					}
					
					if response.response!.statusCode == 200 {
						
						let JSON:[String:Any] = response.result.value  as! [String : Any]
						print(JSON["data"]!)
						self.product = Product(dictionary: JSON["data"] as! NSDictionary)
						print(self.product!)
						
						self.lbTitle.text = self.product?.title
						self.lbPrice.text = "AED " + (self.product?.oldPrice)!
						self.lbDescription.text = self.product?.productDescription?.html2String
						self.lbQuantity.text = "1"
						self.imgProduct.sd_setImage(with: URL(string: (self.product?.productImage!)!), placeholderImage: UIImage(named: ""))
						
						
					}else if response.response!.statusCode == 401{
						
						//						self.alerts(title: "Alert", message: KInvalidKey)
						
					}else if response.response!.statusCode == 400{
						//						self.alerts(title: "Alert", message: KNoResourceFound)
						
					}else{
						//						self.alerts(title: "Alert", message: KUnknown)
					}
					
			}
		}else{
			//			alerts(title: "Network", message: KNoNetwork)
		}
	}
	
	@IBAction func btnDeleteAction(_ sender: Any) {
		
		let quantity:NSString = self.lbQuantity.text! as NSString
		if quantity.intValue > 1 {
			let value = quantity.intValue - 1
			self.lbQuantity.text = String(value)
		}
		
	}
	
	@IBAction func btnAddAction(_ sender: Any) {

		
		let quantity:NSString = self.lbQuantity.text! as NSString
		let value = quantity.intValue + 1
		self.lbQuantity.text = String(value)
		
	}
	
	
	
	
	@IBAction func btnAddToCartAction(_ sender: Any) {
		
		self.product?.productQuantity = self.lbQuantity.text
		
		let userDefaults = UserDefaults.standard
		self.arrProducts = []
		let decoded  = userDefaults.object(forKey: "Products") as? Data
//		let decodedTeams?
		if decoded != nil {
			let selectedProducts = NSKeyedUnarchiver.unarchiveObject(with: decoded!) as! [Product]
			print(selectedProducts)
			
			if selectedProducts.count > 0 {
				for product:Product in selectedProducts{
					
					if	product.title == self.product?.title{
						print("Already Exists")
					}else{
						self.arrProducts?.append(product)
					}
					
					
				}
			}
		}
		
		
		
		
		self.arrProducts?.append(self.product!)
		
		let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: arrProducts!)
		userDefaults.set(encodedData, forKey: "Products")
		userDefaults.synchronize()
		
		//orderIdentifier
		let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "orderIdentifier") as! OrderViewController
		nextViewController.arrProduct = self.arrProducts
//		nextViewController.productID = NSNumber(value: Int(productID!)!)
		self.navigationController?.pushViewController(nextViewController, animated: true)
		
		
		
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


extension Data {
	var html2AttributedString: NSAttributedString? {
		do {
			return try NSAttributedString(data: self, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
		} catch {
			print("error:", error)
			return  nil
		}
	}
	var html2String: String {
		return html2AttributedString?.string ?? ""
	}
}

extension String {
	var html2AttributedString: NSAttributedString? {
		return Data(utf8).html2AttributedString
	}
	var html2String: String {
		return html2AttributedString?.string ?? ""
	}
}
