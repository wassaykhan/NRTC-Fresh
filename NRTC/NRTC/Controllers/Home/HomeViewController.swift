//
//  HomeViewController.swift
//  NRTC
//
//  Created by Wassay Muhammad Khan on 27/09/2018.
//  Copyright © 2018 Netpace. All rights reserved.
//

import UIKit
import SideMenu
import Alamofire
import SDWebImage

class HomeViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
	@IBOutlet var fullImageTableView: UITableView!
	var recommendedProduct:Array<CategoryProduct> = []
	var newProduct:Array<CategoryProduct> = []
	var bestSellingProduct:Array<CategoryProduct> = []
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 6
	}
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		if indexPath.row == 0 || (indexPath.row % 2 == 0){
			let cellFullImage:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "fullImageCellIdentifier", for: indexPath)
			return cellFullImage
		}
		//Recommended Products
		if indexPath.row == 1 {
			let cellNewProduct:NewProductTableViewCell = tableView.dequeueReusableCell(withIdentifier: "newProductCellIdentifier", for: indexPath) as! NewProductTableViewCell
			cellNewProduct.lbProductType.text = "Recommended Products"
			if (self.recommendedProduct.count >= 3){
				let recommendedProd1:CategoryProduct = self.recommendedProduct[0]
				let recommendedProd2:CategoryProduct = self.recommendedProduct[1]
				let recommendedProd3:CategoryProduct = self.recommendedProduct[2]
				let recommendedProd4:CategoryProduct = self.recommendedProduct[3]
				cellNewProduct.lbFirstTitle.text = recommendedProd1.title
				cellNewProduct.lbFisrtPrice.text = "AED " + recommendedProd1.price!
				cellNewProduct.btnfirstProduct.sd_setBackgroundImage(with: URL(string:recommendedProd1.image!), for: .normal)
				cellNewProduct.btnfirstProduct.tag = Int(recommendedProd1.id!)!
				cellNewProduct.lbSecondTitle.text = recommendedProd2.title
				cellNewProduct.lbSecondPrice.text = "AED " + recommendedProd2.price!
				cellNewProduct.btnSecondProduct.sd_setBackgroundImage(with: URL(string:recommendedProd2.image!), for: .normal)
				cellNewProduct.btnSecondProduct.tag = Int(recommendedProd2.id!)!
				cellNewProduct.lbThirdTitle.text = recommendedProd3.title
				cellNewProduct.lbThirdPrice.text = "AED " + recommendedProd3.price!
				cellNewProduct.btnThirdProduct.sd_setBackgroundImage(with: URL(string:recommendedProd3.image!), for: .normal)
				cellNewProduct.btnThirdProduct.tag = Int(recommendedProd3.id!)!
				cellNewProduct.lbFourthTitle.text = recommendedProd4.title
				cellNewProduct.lbFourthPrice.text = "AED " + recommendedProd4.price!
				cellNewProduct.btnFourthProduct.sd_setBackgroundImage(with: URL(string:recommendedProd4.image!), for: .normal)
				cellNewProduct.btnFourthProduct.tag = Int(recommendedProd4.id!)!
			}
			
			
			cellNewProduct.lbProductType.text = "Recommended Products"
			//newProductCellIdentifier
			return cellNewProduct
		}
		if indexPath.row == 3 {
			let cellNewProduct:NewProductTableViewCell = tableView.dequeueReusableCell(withIdentifier: "newProductCellIdentifier", for: indexPath) as! NewProductTableViewCell
			cellNewProduct.lbProductType.text = "Best Selling Products"
			
			if (self.bestSellingProduct.count >= 3){
				let bestSellingProd1:CategoryProduct = self.bestSellingProduct[0]
				let bestSellingProd2:CategoryProduct = self.bestSellingProduct[1]
				let bestSellingProd3:CategoryProduct = self.bestSellingProduct[2]
				let bestSellingProd4:CategoryProduct = self.bestSellingProduct[3]
				cellNewProduct.lbFirstTitle.text = bestSellingProd1.title!
				cellNewProduct.lbFisrtPrice.text = "AED " +  bestSellingProd1.price!
				cellNewProduct.btnfirstProduct.sd_setBackgroundImage(with: URL(string:bestSellingProd1.image!), for: .normal)
				cellNewProduct.btnfirstProduct.tag = Int(bestSellingProd1.id!)!
				cellNewProduct.lbSecondTitle.text = bestSellingProd2.title!
				cellNewProduct.lbSecondPrice.text = "AED " +  bestSellingProd2.price!
				cellNewProduct.btnSecondProduct.sd_setBackgroundImage(with: URL(string:bestSellingProd2.image!), for: .normal)
				cellNewProduct.btnSecondProduct.tag = Int(bestSellingProd2.id!)!
				cellNewProduct.lbThirdTitle.text =  bestSellingProd3.title!
				cellNewProduct.lbThirdPrice.text = "AED " + bestSellingProd3.price!
				cellNewProduct.btnThirdProduct.sd_setBackgroundImage(with: URL(string:bestSellingProd3.image!), for: .normal)
				cellNewProduct.btnThirdProduct.tag = Int(bestSellingProd3.id!)!
				cellNewProduct.lbFourthTitle.text = bestSellingProd4.title!
				cellNewProduct.lbFourthPrice.text = "AED " + bestSellingProd4.price!
				cellNewProduct.btnFourthProduct.sd_setBackgroundImage(with: URL(string:bestSellingProd4.image!), for: .normal)
				cellNewProduct.btnFourthProduct.tag = Int(bestSellingProd4.id!)!
			}
			
			//newProductCellIdentifier
			return cellNewProduct
		}
		if indexPath.row == 5 {
			let cellNewProduct:NewProductTableViewCell = tableView.dequeueReusableCell(withIdentifier: "newProductCellIdentifier", for: indexPath) as! NewProductTableViewCell
			cellNewProduct.lbProductType.text = "New Products"
			
			if (self.newProduct.count >= 3){
				let newProd1:CategoryProduct = self.newProduct[0]
				let newProd2:CategoryProduct = self.newProduct[1]
				let newProd3:CategoryProduct = self.newProduct[2]
				let newProd4:CategoryProduct = self.newProduct[3]
				cellNewProduct.lbFirstTitle.text = newProd1.title
				cellNewProduct.lbFisrtPrice.text = "AED " + newProd1.price!
				cellNewProduct.btnfirstProduct.sd_setBackgroundImage(with: URL(string:newProd1.image!), for: .normal)
				cellNewProduct.btnfirstProduct.tag = Int(newProd1.id!)!
				cellNewProduct.lbSecondTitle.text = newProd2.title
				cellNewProduct.lbSecondPrice.text = "AED " + newProd2.price!
				cellNewProduct.btnSecondProduct.sd_setBackgroundImage(with: URL(string:newProd2.image!), for: .normal)
				cellNewProduct.btnSecondProduct.tag = Int(newProd2.id!)!
				cellNewProduct.lbThirdTitle.text = newProd3.title
				cellNewProduct.lbThirdPrice.text = "AED " + newProd3.price!
				cellNewProduct.btnThirdProduct.sd_setBackgroundImage(with: URL(string:newProd3.image!), for: .normal)
				cellNewProduct.btnThirdProduct.tag = Int(newProd3.id!)!
				cellNewProduct.lbFourthTitle.text = newProd4.title
				cellNewProduct.lbFourthPrice.text = "AED " + newProd4.price!
				cellNewProduct.btnFourthProduct.sd_setBackgroundImage(with: URL(string:newProd4.image!), for: .normal)
				cellNewProduct.btnFourthProduct.tag = Int(newProd4.id!)!
			}
			
			//newProductCellIdentifier
			return cellNewProduct
		}
		
		let cellFullImage:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "fullImageCellIdentifier", for: indexPath)
		return cellFullImage
		
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		if indexPath.row == 0 || (indexPath.row % 2 == 0){
			return 170
		}
		return 450
	}
	

    override func viewDidLoad() {
        super.viewDidLoad()

		self.fullImageTableView.delegate = self
		self.fullImageTableView.dataSource = self
		SideMenuManager.default.menuLeftNavigationController = storyboard!.instantiateViewController(withIdentifier: "LeftMenuNavigationController") as? UISideMenuNavigationController
		self.getRecommendedProducts()
    }
	
	
	fileprivate func getRecommendedProducts() {
		
		if Reachability.isConnectedToInternet() {
			print("Yes! internet is available.")
			//			SVProgressHUD.show(withStatus: "Loading Request")
			
			let urlString = KBaseUrl + KRecommendedProduct
			Alamofire.request(urlString, method: .get, parameters: nil, encoding: JSONEncoding.default)
				.downloadProgress(queue: DispatchQueue.global(qos: .utility)) { progress in
					print("Progress: \(progress.fractionCompleted)")
				}
				.validate { request, response, data in
					return .success
				}
				.responseJSON { response in
					debugPrint(response)
					
					//					SVProgressHUD.dismiss()
					if	response.result.value == nil {
						
						//						self.alerts(title: "Alert", message: "Response time out")
						return
					}
					
					if response.response!.statusCode == 200 {
						
						let JSON:NSDictionary = (response.result.value as! NSDictionary?)!
						self.recommendedProduct = []
						self.bestSellingProduct = []
						self.newProduct = []
						for dictionary in JSON["recommended_products"] as! NSArray{
							let product:CategoryProduct = CategoryProduct(dictionary: dictionary as! NSDictionary)
							self.recommendedProduct.append(product)
						}
						print(self.recommendedProduct)
						for dictionary in JSON["best_selling_products"] as! NSArray{
							let product:CategoryProduct = CategoryProduct(dictionary: dictionary as! NSDictionary)
							self.bestSellingProduct.append(product)
						}
						print(self.bestSellingProduct)
						for dictionary in JSON["new_products"] as! NSArray{
							let product:CategoryProduct = CategoryProduct(dictionary: dictionary as! NSDictionary)
							self.newProduct.append(product)
						}
						print(self.newProduct)
						self.fullImageTableView.reloadData()
						
						
						
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

	
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		
		let destinationVC = segue.destination as? ProductCategoryViewController
		switch segue.identifier {
		case "categoryFruitIdentifier":
			destinationVC?.categoryType = 3
		case "categoryVegetablesIdentifier":
			destinationVC?.categoryType = 4
		case "categoryPrecutIdentifier":
			destinationVC?.categoryType = 2
		case "categoryJuicesIdentifier":
			destinationVC?.categoryType = 3
		default:
			destinationVC?.categoryType = 1
		}
    }
	
	
	@IBAction func btnMenuAction(_ sender: Any) {
		present(SideMenuManager.default.menuLeftNavigationController!, animated: true, completion: nil)
	}
	
	@IBAction func btnFirstProdAction(_ sender: UIButton) {
		print(sender.tag)
		let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "productID") as! ProductViewController
		nextViewController.productID = sender.tag as NSNumber
		self.navigationController?.pushViewController(nextViewController, animated: true)
	}
	
	@IBAction func btnSecondProdAction(_ sender: UIButton) {
		print(sender.tag)
		let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "productID") as! ProductViewController
		nextViewController.productID = sender.tag as NSNumber
		self.navigationController?.pushViewController(nextViewController, animated: true)
	}
	
	@IBAction func btnThirdProdAction(_ sender: UIButton) {
		print(sender.tag)
		let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "productID") as! ProductViewController
		nextViewController.productID = sender.tag as NSNumber
		self.navigationController?.pushViewController(nextViewController, animated: true)
	}
	
	@IBAction func btnFourthProdAction(_ sender: UIButton) {
		print(sender.tag)
		let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "productID") as! ProductViewController
		nextViewController.productID = sender.tag as NSNumber
		self.navigationController?.pushViewController(nextViewController, animated: true)
		
	}
}
