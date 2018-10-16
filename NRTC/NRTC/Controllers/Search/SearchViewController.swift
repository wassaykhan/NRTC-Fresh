//
//  SearchViewController.swift
//  NRTC
//
//  Created by Wassay Khan on 13/10/2018.
//  Copyright © 2018 Netpace. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage
import SVProgressHUD
import BadgeSwift
import MessageUI

class SearchViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,MFMailComposeViewControllerDelegate {

	@IBOutlet weak var categoryCollectionView: UICollectionView!
	@IBOutlet weak var lbCategoryHeading: UILabel!
	@IBOutlet weak var lbBadgeCount: BadgeSwift!
	
	var categoryData:CategoryProduct?
	var arrCategoryProduct:Array<CategoryProduct> = []
	var searchText:String?
	var arrProducts:Array<Product> = []
	
	
    override func viewDidLoad() {
        super.viewDidLoad()
		self.getProductCategory()
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
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return arrCategoryProduct.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		//categoryCellIdentifier
		let cellCategory:CategoryCollectionViewCell = categoryCollectionView.dequeueReusableCell(withReuseIdentifier: "categoryCellIdentifier", for: indexPath) as! CategoryCollectionViewCell
		cellCategory.lbTitle.text =  self.arrCategoryProduct[indexPath.row].title!
		cellCategory.lbPrice.text = "AED " + self.arrCategoryProduct[indexPath.row].oldPrice!
		cellCategory.imgProduct.sd_setImage(with: URL(string: self.arrCategoryProduct[indexPath.row].image!), placeholderImage: UIImage(named: ""))
		//newProductCellIdentifier
		return cellCategory
		
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		//		if UIScreen.main.nativeBounds.height == 1136{
		//			return CGSize(width: UIScreen.main.bounds.width/2 - 20, height: 216)
		//		}
		return CGSize(width: UIScreen.main.bounds.width/2 - 20, height: UIScreen.main.bounds.height/3 + 20)
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
			
			let urlString = KBaseUrl + KSearchQuery + searchText!
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
	/*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
