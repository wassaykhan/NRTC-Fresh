//
//  ProductCategoryViewController.swift
//  NRTC
//
//  Created by Wassay Khan on 02/10/2018.
//  Copyright © 2018 Netpace. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage
import SVProgressHUD
import BadgeSwift
import MessageUI

class ProductCategoryViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,MFMailComposeViewControllerDelegate {
	@IBOutlet weak var categoryCollectionView: UICollectionView!
	@IBOutlet weak var lbCategoryHeading: UILabel!
	@IBOutlet weak var lbBadgeCount: BadgeSwift!
	
	var categoryType:NSNumber?
	var categoryData:CategoryProduct?
	var arrCategoryProduct:Array<CategoryProduct> = []
	var arrProducts:Array<Product> = []
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.getProductCategory()
		
		switch categoryType {
		case 3:
			self.lbCategoryHeading.text = "Fruits"
		case 4:
			self.lbCategoryHeading.text = "Vegetables"
		case 2:
			self.lbCategoryHeading.text = "Precut"
		case 29:
			self.lbCategoryHeading.text = "Juices"
		case 39:
			self.lbCategoryHeading.text = "Pre-Box"
		default:
			self.lbCategoryHeading.text = "Fruits"
		}
		
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
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return arrCategoryProduct.count
	}
	
	@IBAction func btnCartAction(_ sender: Any) {
		
		let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "orderIdentifier") as! OrderViewController
		nextViewController.arrProduct = self.arrProducts
		//		nextViewController.productID = NSNumber(value: Int(productID!)!)
		self.navigationController?.pushViewController(nextViewController, animated: true)
		
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		//categoryCellIdentifier
		let cellCategory:CategoryCollectionViewCell = categoryCollectionView.dequeueReusableCell(withReuseIdentifier: "categoryCellIdentifier", for: indexPath) as! CategoryCollectionViewCell
		cellCategory.lbTitle.text =  self.arrCategoryProduct[indexPath.row].title!
//		cellCategory.lbPrice.text = getPrice(prod: (self.arrCategoryProduct[indexPath.row]))
		
		let ifPrice = self.arrCategoryProduct[indexPath.row].price! as NSString
		if ifPrice.floatValue > 0.0 {
			cellCategory.lbOldPrice.isHidden = false
			cellCategory.viewRemove.isHidden = false
			cellCategory.lbPrice.text = getPriceNew(prod: (self.arrCategoryProduct[indexPath.row]))
			cellCategory.lbOldPrice.text = getPriceOld(prod: (self.arrCategoryProduct[indexPath.row]))
		}else{
			cellCategory.lbOldPrice.isHidden = true
			cellCategory.viewRemove.isHidden = true
//			cellCategory.lbPrice.text = "AED" + self.arrCategoryProduct[indexPath.row].oldPrice!
			cellCategory.lbPrice.text = getPriceOld(prod: (self.arrCategoryProduct[indexPath.row]))
		}
		
		let ifDiscount = self.arrCategoryProduct[indexPath.row].discountPercentage! as NSString
		if ifDiscount.floatValue > 0.0 {
			cellCategory.viewDiscount.isHidden = false
			cellCategory.lbDiscount.text = self.arrCategoryProduct[indexPath.row].discountPercentage! + "% OFF"
		}else{
			//			cellCategory.lbDiscount.isHidden = true
			cellCategory.viewDiscount.isHidden = true
		}
		
		
		
		cellCategory.imgProduct.sd_setImage(with: URL(string: self.arrCategoryProduct[indexPath.row].image!), placeholderImage: UIImage(named: ""))
		//newProductCellIdentifier
		return cellCategory

	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//		if UIScreen.main.nativeBounds.height == 1136{
//			return CGSize(width: UIScreen.main.bounds.width/2 - 20, height: 216)
//		}
		//iphone X XS
		if UIScreen.main.nativeBounds.height == 2436 {
			return CGSize(width: UIScreen.main.bounds.width/2 - 20, height: UIScreen.main.bounds.height/3.5 + 20 + 40)
		}//2688 iphone XS_Max
		if UIScreen.main.nativeBounds.height == 2688 {
			return CGSize(width: UIScreen.main.bounds.width/2 - 20, height: UIScreen.main.bounds.height/3.5 + 20 + 40)
		}//1792 iphone XR
		if UIScreen.main.nativeBounds.height == 1792 {
			return CGSize(width: UIScreen.main.bounds.width/2 - 20, height: UIScreen.main.bounds.height/3.8 + 30 + 40)
		}
		return CGSize(width: UIScreen.main.bounds.width/2 - 20, height: UIScreen.main.bounds.height/3 + 60)
	}
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		
		let productID = self.arrCategoryProduct[indexPath.item].id
		
		let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "productID") as! ProductViewController
		nextViewController.productID = NSNumber(value: Int(productID!)!)
		self.navigationController?.pushViewController(nextViewController, animated: true)
		
	}
	
	fileprivate func getProductCategory() {
		
		if Reachability.isConnectedToInternet() {
			print("Yes! internet is available.")
			SVProgressHUD.show(withStatus: "Loading Request")
			
			let urlString = KBaseUrl + KCategoryProduct + (categoryType?.stringValue)!
			Alamofire.request(urlString, method: .get, parameters: nil, encoding: JSONEncoding.default)
				.downloadProgress(queue: DispatchQueue.global(qos: .utility)) { progress in
					print("Progress: \(progress.fractionCompleted)")
				}
				.validate { request, response, data in
					return .success
				}
				.responseJSON { response in
					debugPrint(response)
					
					SVProgressHUD.dismiss()
					if	response.result.value == nil {
						
						self.alerts(title: "Alert", message: "Response time out")
						return
					}
					
					if response.response!.statusCode == 200 {
						
						let JSON:NSDictionary = (response.result.value as! NSDictionary?)!
						self.arrCategoryProduct = []
						for dictionary in JSON["data"] as! NSArray{
							let product:CategoryProduct = CategoryProduct(dictionary: dictionary as! NSDictionary)
							self.arrCategoryProduct.append(product)
						}
						print(self.arrCategoryProduct)
						self.categoryCollectionView.reloadData()
						
						
					}else if response.response!.statusCode == 401{
						
						self.alerts(title: "Alert", message: "KInvalidKey")
						
					}else if response.response!.statusCode == 400{
						self.alerts(title: "Alert", message: "KNoResourceFound")
						
					}else if response.response!.statusCode == 404{
						self.alerts(title: "Alert", message: "No Data")
						
					}else{
						self.alerts(title: "Alert", message: "KUnknown")
					}
					
			}
		}else{
			alerts(title: "Network", message: KNoNetwork)
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
	@IBAction func btnContactAction(_ sender: Any) {
		self.callUs()
	}
	
}

extension UIImage {
	convenience init?(url: URL?) {
		guard let url = url else { return nil }
		
		do {
			let data = try Data(contentsOf: url)
			self.init(data: data)
		} catch {
			print("Cannot load image from url: \(url) with error: \(error)")
			return nil
		}
	}
}
