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
import SVProgressHUD
import BadgeSwift
import MessageUI

class HomeViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UISearchBarDelegate,MFMailComposeViewControllerDelegate  {
	@IBOutlet var fullImageTableView: UITableView!
	@IBOutlet weak var lbBadgeCount: BadgeSwift!
	@IBOutlet weak var btnReload: UIButton!
	
	
	var recommendedProduct:Array<CategoryProduct> = []
	var newProduct:Array<CategoryProduct> = []
	var bestSellingProduct:Array<CategoryProduct> = []
	
	var arrProducts:Array<Product> = []
	
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		
		if recommendedProduct.count > 0 {
			return 6
		}
		return 0
	}
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	@IBAction func btnCartAction(_ sender: Any) {
		
		let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "orderIdentifier") as! OrderViewController
		nextViewController.arrProduct = self.arrProducts
		//		nextViewController.productID = NSNumber(value: Int(productID!)!)
		self.navigationController?.pushViewController(nextViewController, animated: true)
	}
	
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		if indexPath.row == 0 || (indexPath.row % 2 == 0){
			
			if indexPath.row == 0 {
				let cellFullImage:BannerTableViewCell = tableView.dequeueReusableCell(withIdentifier: "fullImageCellIdentifier", for: indexPath) as! BannerTableViewCell
//				cellFullImage.imgBanner.sd_setImage(with: URL(string: "https://nrtcfresh.com/assets/mobileapp/1.png"), placeholderImage: UIImage(named: ""))
				cellFullImage.imgBanner.sd_setImage(with: URL(string: "https://nrtcfresh.com/assets/mobileapp/1.png"), placeholderImage: UIImage(named: ""), options: .refreshCached, completed: nil)
				cellFullImage.selectionStyle = UITableViewCell.SelectionStyle.none
				return cellFullImage
			}else if indexPath.row == 2 {
				let cellFullImage:BannerTableViewCell = tableView.dequeueReusableCell(withIdentifier: "fullImageCellIdentifier", for: indexPath) as! BannerTableViewCell
//				cellFullImage.imgBanner.sd_setImage(with: URL(string: "https://nrtcfresh.com/assets/mobileapp/2.png"), placeholderImage: UIImage(named: ""))
				cellFullImage.imgBanner.sd_setImage(with: URL(string: "https://nrtcfresh.com/assets/mobileapp/2.png"), placeholderImage: UIImage(named: ""), options: .refreshCached, completed: nil)
				cellFullImage.selectionStyle = UITableViewCell.SelectionStyle.none
				return cellFullImage
			}else {
				let cellFullImage:BannerTableViewCell = tableView.dequeueReusableCell(withIdentifier: "fullImageCellIdentifier", for: indexPath) as! BannerTableViewCell
//				cellFullImage.imgBanner.sd_setImage(with: URL(string: "https://nrtcfresh.com/assets/mobileapp/3.png"), placeholderImage: UIImage(named: ""))
				cellFullImage.imgBanner.sd_setImage(with: URL(string: "https://nrtcfresh.com/assets/mobileapp/3.png"), placeholderImage: UIImage(named: ""), options: .refreshCached, completed: nil)
				cellFullImage.selectionStyle = UITableViewCell.SelectionStyle.none
				return cellFullImage
			}
			
			
		}
		//Recommended Products
		if indexPath.row == 3 {
			let cellNewProduct:NewProductTableViewCell = tableView.dequeueReusableCell(withIdentifier: "newProductCellIdentifier", for: indexPath) as! NewProductTableViewCell
			cellNewProduct.selectionStyle = UITableViewCell.SelectionStyle.none
			cellNewProduct.lbProductType.text = "Recommended Products"
			cellNewProduct.btnViewMore.tag = 21
			if (self.recommendedProduct.count >= 6){
				let recommendedProd1:CategoryProduct = self.recommendedProduct[0]
				let recommendedProd2:CategoryProduct = self.recommendedProduct[1]
				let recommendedProd3:CategoryProduct = self.recommendedProduct[2]
				let recommendedProd4:CategoryProduct = self.recommendedProduct[3]
				let recommendedProd5:CategoryProduct = self.recommendedProduct[4]
				let recommendedProd6:CategoryProduct = self.recommendedProduct[5]
				cellNewProduct.lbFirstTitle.text = recommendedProd1.title
//				cellNewProduct.lbFisrtPrice.text = getPrice(prod: recommendedProd1)
				cellNewProduct.btnfirstProduct.sd_setBackgroundImage(with: URL(string:recommendedProd1.image!), for: .normal)
				let ifDiscount1 = recommendedProd1.discountPercentage! as NSString
				if ifDiscount1.floatValue > 0.0 {
					cellNewProduct.viewDiscount1.isHidden = false
					cellNewProduct.lbDiscount1.text = recommendedProd1.discountPercentage! + "% OFF"
				}else{
					cellNewProduct.viewDiscount1.isHidden = true
				}
				
				let ifPrice1 = recommendedProd1.price! as NSString
				if ifPrice1.floatValue > 0.0 {
					cellNewProduct.lbFisrtPrice.text = getPriceNew(prod: recommendedProd1)
					cellNewProduct.lbOldPrice1.isHidden = false
					cellNewProduct.viewRemoveOldPrice1.isHidden = false
					cellNewProduct.lbOldPrice1.text = self.getPriceOld(prod: recommendedProd1)
				}else{
					cellNewProduct.lbFisrtPrice.text = getPriceOld(prod: recommendedProd1)
					cellNewProduct.lbOldPrice1.isHidden = true
					cellNewProduct.viewRemoveOldPrice1.isHidden = true
				}
				
				cellNewProduct.btnfirstProduct.tag = Int(recommendedProd1.id!)!
				cellNewProduct.lbSecondTitle.text = recommendedProd2.title
				//cellNewProduct.lbSecondPrice.text = getPrice(prod: recommendedProd2)
				cellNewProduct.btnSecondProduct.sd_setBackgroundImage(with: URL(string:recommendedProd2.image!), for: .normal)
				let ifDiscount2 = recommendedProd2.discountPercentage! as NSString
				if ifDiscount2.floatValue > 0.0 {
					cellNewProduct.viewDiscount2.isHidden = false
					cellNewProduct.lbDiscount2.text = recommendedProd2.discountPercentage! + "% OFF"
				}else{
					cellNewProduct.viewDiscount2.isHidden = true
				}
				let ifPrice2 = recommendedProd2.price! as NSString
				if ifPrice2.floatValue > 0.0 {
					cellNewProduct.lbSecondPrice.text = getPriceNew(prod: recommendedProd2)
					cellNewProduct.lbOldPrice2.isHidden = false
					cellNewProduct.viewRemoveOldPrice2.isHidden = false
					cellNewProduct.lbOldPrice2.text = self.getPriceOld(prod: recommendedProd2)
				}else{
					cellNewProduct.lbSecondPrice.text = getPriceOld(prod: recommendedProd2)
					cellNewProduct.lbOldPrice2.isHidden = true
					cellNewProduct.viewRemoveOldPrice2.isHidden = true
				}
				
				cellNewProduct.btnSecondProduct.tag = Int(recommendedProd2.id!)!
				cellNewProduct.lbThirdTitle.text = recommendedProd3.title
//				cellNewProduct.lbThirdPrice.text = getPrice(prod: recommendedProd3)
				cellNewProduct.btnThirdProduct.sd_setBackgroundImage(with: URL(string:recommendedProd3.image!), for: .normal)
				let ifDiscount3 = recommendedProd3.discountPercentage! as NSString
				if ifDiscount3.floatValue > 0.0 {
					cellNewProduct.lbDiscount3.text = recommendedProd3.discountPercentage! + "% OFF"
				}else{
					cellNewProduct.viewDiscount3.isHidden = true
				}
				
				let ifPrice3 = recommendedProd3.price! as NSString
				if ifPrice3.floatValue > 0.0 {
					cellNewProduct.lbThirdPrice.text = getPriceNew(prod: recommendedProd3)
					cellNewProduct.lbOldPrice3.isHidden = false
					cellNewProduct.viewRemoveOldPrice3.isHidden = false
					cellNewProduct.lbOldPrice3.text = self.getPriceOld(prod: recommendedProd3)
				}else{
					cellNewProduct.lbThirdPrice.text = getPriceOld(prod: recommendedProd3)
					cellNewProduct.lbOldPrice3.isHidden = true
					cellNewProduct.viewRemoveOldPrice3.isHidden = true
				}

				cellNewProduct.btnThirdProduct.tag = Int(recommendedProd3.id!)!
				cellNewProduct.lbFourthTitle.text = recommendedProd4.title
//				cellNewProduct.lbFourthPrice.text = getPrice(prod: recommendedProd4)
				cellNewProduct.btnFourthProduct.sd_setBackgroundImage(with: URL(string:recommendedProd4.image!), for: .normal)
				let ifDiscount4 = recommendedProd4.discountPercentage! as NSString
				if ifDiscount4.floatValue > 0.0 {
					cellNewProduct.lbDiscount4.text = recommendedProd4.discountPercentage! + "% OFF"
				}else{
					cellNewProduct.viewDiscount4.isHidden = true
				}

				let ifPrice4 = recommendedProd4.price! as NSString
				if ifPrice4.floatValue > 0.0 {
					cellNewProduct.lbFourthPrice.text = getPriceNew(prod: recommendedProd4)
					cellNewProduct.lbOldPrice4.isHidden = false
					cellNewProduct.viewRemoveOldPrice4.isHidden = false
					cellNewProduct.lbOldPrice4.text = self.getPriceOld(prod: recommendedProd4)
				}else{
					cellNewProduct.lbFourthPrice.text = getPriceOld(prod: recommendedProd4)
					cellNewProduct.lbOldPrice4.isHidden = true
					cellNewProduct.viewRemoveOldPrice4.isHidden = true
				}
				
				cellNewProduct.btnFourthProduct.tag = Int(recommendedProd4.id!)!
				cellNewProduct.lbFifthTitle.text = recommendedProd5.title
//				cellNewProduct.lbFifthPrice.text = getPrice(prod: recommendedProd5)
				cellNewProduct.btnFifth.sd_setBackgroundImage(with: URL(string:recommendedProd5.image!), for: .normal)
				let ifDiscount5 = recommendedProd5.discountPercentage! as NSString
				if ifDiscount5.floatValue > 0.0 {
					cellNewProduct.lbDiscount5.text =  recommendedProd5.discountPercentage! + "% OFF"
				}else{
					cellNewProduct.viewDiscount5.isHidden = true
				}

				let ifPrice5 = recommendedProd5.price! as NSString
				if ifPrice5.floatValue > 0.0 {
					cellNewProduct.lbFifthPrice.text = getPriceNew(prod: recommendedProd5)
					cellNewProduct.lbOldPrice5.isHidden = false
					cellNewProduct.viewRemoveOldPrice5.isHidden = false
					cellNewProduct.lbOldPrice5.text = self.getPriceOld(prod: recommendedProd5)
				}else{
					cellNewProduct.lbFifthPrice.text = getPriceOld(prod: recommendedProd5)
					cellNewProduct.lbOldPrice5.isHidden = true
					cellNewProduct.viewRemoveOldPrice5.isHidden = true
				}
				
				cellNewProduct.btnFifth.tag = Int(recommendedProd5.id!)!
				cellNewProduct.lbSixthTitle.text = recommendedProd6.title
//				cellNewProduct.lbSixthPrice.text = getPrice(prod: recommendedProd6)
				cellNewProduct.btnSixth.sd_setBackgroundImage(with: URL(string:recommendedProd6.image!), for: .normal)
				let ifDiscount6 = recommendedProd6.discountPercentage! as NSString
				if ifDiscount6.floatValue > 0.0 {
					cellNewProduct.lbDiscount6.text = recommendedProd6.discountPercentage! + "% OFF"
				}else{
					cellNewProduct.viewDiscount6.isHidden = true
				}

				let ifPrice6 = recommendedProd6.price! as NSString
				if ifPrice6.floatValue > 0.0 {
					cellNewProduct.lbSixthPrice.text = getPriceNew(prod: recommendedProd6)
					cellNewProduct.lbOldPrice6.isHidden = false
					cellNewProduct.viewRemoveOldPrice6.isHidden = false
					cellNewProduct.lbOldPrice6.text = self.getPriceOld(prod: recommendedProd6)
				}else{
					cellNewProduct.lbSixthPrice.text = getPriceOld(prod: recommendedProd6)
					cellNewProduct.lbOldPrice6.isHidden = true
					cellNewProduct.viewRemoveOldPrice6.isHidden = true
				}
				
				cellNewProduct.btnSixth.tag = Int(recommendedProd6.id!)!
			}
			
			
			cellNewProduct.lbProductType.text = "Recommended Products"
			//newProductCellIdentifier
			return cellNewProduct
		}
		if indexPath.row == 5 {
			let cellNewProduct:NewProductTableViewCell = tableView.dequeueReusableCell(withIdentifier: "newProductCellIdentifier", for: indexPath) as! NewProductTableViewCell
			cellNewProduct.selectionStyle = UITableViewCell.SelectionStyle.none
			cellNewProduct.lbProductType.text = "In Season"
			cellNewProduct.btnViewMore.tag = 22
			
			if (self.bestSellingProduct.count >= 6){
				let bestSellingProd1:CategoryProduct = self.bestSellingProduct[0]
				let bestSellingProd2:CategoryProduct = self.bestSellingProduct[1]
				let bestSellingProd3:CategoryProduct = self.bestSellingProduct[2]
				let bestSellingProd4:CategoryProduct = self.bestSellingProduct[3]
				let bestSellingProd5:CategoryProduct = self.bestSellingProduct[4]
				let bestSellingProd6:CategoryProduct = self.bestSellingProduct[5]
				cellNewProduct.lbFirstTitle.text = bestSellingProd1.title!
//				cellNewProduct.lbFisrtPrice.text = getPrice(prod: bestSellingProd1)
				cellNewProduct.btnfirstProduct.sd_setBackgroundImage(with: URL(string:bestSellingProd1.image!), for: .normal)
				let ifDiscount1 = bestSellingProd1.discountPercentage! as NSString
				if ifDiscount1.floatValue > 0.0 {
					cellNewProduct.lbDiscount1.text = bestSellingProd1.discountPercentage! + "% OFF"
				}else{
					cellNewProduct.viewDiscount1.isHidden = true
				}
				
				let ifPrice1 = bestSellingProd1.price! as NSString
				if ifPrice1.floatValue > 0.0 {
					cellNewProduct.lbFisrtPrice.text = getPriceNew(prod: bestSellingProd1)
					cellNewProduct.lbOldPrice1.isHidden = false
					cellNewProduct.viewRemoveOldPrice1.isHidden = false
					cellNewProduct.lbOldPrice1.text = self.getPriceOld(prod: bestSellingProd1)
				}else{
					cellNewProduct.lbFisrtPrice.text = getPriceOld(prod: bestSellingProd1)
					cellNewProduct.lbOldPrice1.isHidden = true
					cellNewProduct.viewRemoveOldPrice1.isHidden = true
				}
				
				cellNewProduct.btnfirstProduct.tag = Int(bestSellingProd1.id!)!
				cellNewProduct.lbSecondTitle.text = bestSellingProd2.title!
//				cellNewProduct.lbSecondPrice.text = getPrice(prod: bestSellingProd2)
				cellNewProduct.btnSecondProduct.sd_setBackgroundImage(with: URL(string:bestSellingProd2.image!), for: .normal)
				let ifDiscount2 = bestSellingProd2.discountPercentage! as NSString
				if ifDiscount2.floatValue > 0.0 {
					cellNewProduct.lbDiscount2.text = bestSellingProd2.discountPercentage! + "% OFF"
				}else{
					cellNewProduct.viewDiscount2.isHidden = true
				}
				
				let ifPrice2 = bestSellingProd2.price! as NSString
				if ifPrice2.floatValue > 0.0 {
					cellNewProduct.lbSecondPrice.text = getPriceNew(prod: bestSellingProd2)
					cellNewProduct.lbOldPrice2.isHidden = false
					cellNewProduct.viewRemoveOldPrice2.isHidden = false
					cellNewProduct.lbOldPrice2.text = self.getPriceOld(prod: bestSellingProd2)
				}else{
					cellNewProduct.lbSecondPrice.text = getPriceOld(prod: bestSellingProd2)
					cellNewProduct.lbOldPrice2.isHidden = true
					cellNewProduct.viewRemoveOldPrice2.isHidden = true
				}
				
				cellNewProduct.btnSecondProduct.tag = Int(bestSellingProd2.id!)!
				cellNewProduct.lbThirdTitle.text =  bestSellingProd3.title!
//				cellNewProduct.lbThirdPrice.text = getPrice(prod: bestSellingProd3)
				cellNewProduct.btnThirdProduct.sd_setBackgroundImage(with: URL(string:bestSellingProd3.image!), for: .normal)
				let ifDiscount3 = bestSellingProd3.discountPercentage! as NSString
				if ifDiscount3.floatValue > 0.0 {
					cellNewProduct.lbDiscount3.text = bestSellingProd3.discountPercentage! + "% OFF"
				}else{
					cellNewProduct.viewDiscount3.isHidden = true
				}
				
				let ifPrice3 = bestSellingProd3.price! as NSString
				if ifPrice3.floatValue > 0.0 {
					cellNewProduct.lbThirdPrice.text = getPriceNew(prod: bestSellingProd3)
					cellNewProduct.lbOldPrice3.isHidden = false
					cellNewProduct.viewRemoveOldPrice3.isHidden = false
					cellNewProduct.lbOldPrice3.text = self.getPriceOld(prod: bestSellingProd3)
				}else{
					cellNewProduct.lbThirdPrice.text = getPriceOld(prod: bestSellingProd3)
					cellNewProduct.lbOldPrice3.isHidden = true
					cellNewProduct.viewRemoveOldPrice3.isHidden = true
				}
				
				cellNewProduct.btnThirdProduct.tag = Int(bestSellingProd3.id!)!
				cellNewProduct.lbFourthTitle.text = bestSellingProd4.title!
//				cellNewProduct.lbFourthPrice.text = getPrice(prod: bestSellingProd4)
				cellNewProduct.btnFourthProduct.sd_setBackgroundImage(with: URL(string:bestSellingProd4.image!), for: .normal)
				let ifDiscount4 = bestSellingProd4.discountPercentage! as NSString
				if ifDiscount4.floatValue > 0.0 {
					cellNewProduct.lbDiscount4.text = bestSellingProd4.discountPercentage! + "% OFF"
				}else{
					cellNewProduct.viewDiscount4.isHidden = true
				}
				
				let ifPrice4 = bestSellingProd4.price! as NSString
				if ifPrice4.floatValue > 0.0 {
					cellNewProduct.lbFourthPrice.text = getPriceNew(prod: bestSellingProd4)
					cellNewProduct.lbOldPrice4.isHidden = false
					cellNewProduct.viewRemoveOldPrice4.isHidden = false
					cellNewProduct.lbOldPrice4.text = self.getPriceOld(prod: bestSellingProd4)
				}else{
					cellNewProduct.lbFourthPrice.text = getPriceOld(prod: bestSellingProd4)
					cellNewProduct.lbOldPrice4.isHidden = true
					cellNewProduct.viewRemoveOldPrice4.isHidden = true
				}
				
				cellNewProduct.btnFourthProduct.tag = Int(bestSellingProd4.id!)!
				cellNewProduct.lbFifthTitle.text = bestSellingProd5.title
//				cellNewProduct.lbFifthPrice.text = getPrice(prod: bestSellingProd5)
				cellNewProduct.btnFifth.sd_setBackgroundImage(with: URL(string:bestSellingProd5.image!), for: .normal)
				let ifDiscount5 = bestSellingProd5.discountPercentage! as NSString
				if ifDiscount5.floatValue > 0.0 {
					cellNewProduct.lbDiscount5.text = bestSellingProd5.discountPercentage! + "% OFF"
				}else{
					cellNewProduct.viewDiscount2.isHidden = true
				}
				
				let ifPrice5 = bestSellingProd5.price! as NSString
				if ifPrice5.floatValue > 0.0 {
					cellNewProduct.lbFifthPrice.text = getPriceNew(prod: bestSellingProd5)
					cellNewProduct.lbOldPrice5.isHidden = false
					cellNewProduct.viewRemoveOldPrice5.isHidden = false
					cellNewProduct.lbOldPrice5.text = self.getPriceOld(prod: bestSellingProd5)
				}else{
					cellNewProduct.lbFifthPrice.text = getPriceOld(prod: bestSellingProd5)
					cellNewProduct.lbOldPrice5.isHidden = true
					cellNewProduct.viewRemoveOldPrice5.isHidden = true
				}
				
				cellNewProduct.btnFifth.tag = Int(bestSellingProd5.id!)!
				cellNewProduct.lbSixthTitle.text = bestSellingProd6.title
//				cellNewProduct.lbSixthPrice.text = getPrice(prod: bestSellingProd6)
				cellNewProduct.btnSixth.sd_setBackgroundImage(with: URL(string:bestSellingProd6.image!), for: .normal)
				let ifDiscount6 = bestSellingProd6.discountPercentage! as NSString
				if ifDiscount6.floatValue > 0.0 {
					cellNewProduct.lbDiscount6.text = bestSellingProd6.discountPercentage! + "% OFF"
				}else{
					cellNewProduct.viewDiscount6.isHidden = true
				}
				
				let ifPrice6 = bestSellingProd6.price! as NSString
				if ifPrice6.floatValue > 0.0 {
					cellNewProduct.lbSixthPrice.text = getPriceNew(prod: bestSellingProd6)
					cellNewProduct.lbOldPrice6.isHidden = false
					cellNewProduct.viewRemoveOldPrice6.isHidden = false
					cellNewProduct.lbOldPrice6.text = self.getPriceOld(prod: bestSellingProd6)
				}else{
					cellNewProduct.lbSixthPrice.text = getPriceOld(prod: bestSellingProd6)
					cellNewProduct.lbOldPrice6.isHidden = true
					cellNewProduct.viewRemoveOldPrice6.isHidden = true
				}
				
				cellNewProduct.btnSixth.tag = Int(bestSellingProd6.id!)!
			}
			
			//newProductCellIdentifier
			return cellNewProduct
		}
		if indexPath.row == 1 {
			let cellNewProduct:NewProductTableViewCell = tableView.dequeueReusableCell(withIdentifier: "newProductCellIdentifier", for: indexPath) as! NewProductTableViewCell
			cellNewProduct.selectionStyle = UITableViewCell.SelectionStyle.none
			cellNewProduct.lbProductType.text = "New Arrivals"
			cellNewProduct.btnViewMore.tag = 23
			
			if (self.newProduct.count >= 6){
				let newProd1:CategoryProduct = self.newProduct[0]
				let newProd2:CategoryProduct = self.newProduct[1]
				let newProd3:CategoryProduct = self.newProduct[2]
				let newProd4:CategoryProduct = self.newProduct[3]
				let newProd5:CategoryProduct = self.newProduct[4]
				let newProd6:CategoryProduct = self.newProduct[5]
				cellNewProduct.lbFirstTitle.text = newProd1.title
//				cellNewProduct.lbFisrtPrice.text = getPrice(prod: newProd1)
				cellNewProduct.btnfirstProduct.sd_setBackgroundImage(with: URL(string:newProd1.image!), for: .normal)
				let ifDiscount1 = newProd1.discountPercentage! as NSString
				if ifDiscount1.floatValue > 0.0 {
					cellNewProduct.lbDiscount1.text = newProd1.discountPercentage! + "% OFF"
				}else{
					cellNewProduct.viewDiscount1.isHidden = true
				}
				
				let ifPrice1 = newProd1.price! as NSString
				if ifPrice1.floatValue > 0.0 {
					cellNewProduct.lbFisrtPrice.text = getPriceNew(prod: newProd1)
					cellNewProduct.lbOldPrice1.isHidden = false
					cellNewProduct.viewRemoveOldPrice1.isHidden = false
					cellNewProduct.lbOldPrice1.text = self.getPriceOld(prod: newProd1)
				}else{
					cellNewProduct.lbFisrtPrice.text = getPriceOld(prod: newProd1)
					cellNewProduct.lbOldPrice1.isHidden = true
					cellNewProduct.viewRemoveOldPrice1.isHidden = true
				}
				
				cellNewProduct.btnfirstProduct.tag = Int(newProd1.id!)!
				cellNewProduct.lbSecondTitle.text = newProd2.title
//				cellNewProduct.lbSecondPrice.text = getPrice(prod: newProd2)
				cellNewProduct.btnSecondProduct.sd_setBackgroundImage(with: URL(string:newProd2.image!), for: .normal)
				let ifDiscount2 = newProd2.discountPercentage! as NSString
				if ifDiscount2.floatValue > 0.0 {
					cellNewProduct.lbDiscount2.text = newProd2.discountPercentage! + "% OFF"
				}else{
					cellNewProduct.viewDiscount2.isHidden = true
				}
				
				let ifPrice2 = newProd2.price! as NSString
				if ifPrice2.floatValue > 0.0 {
					cellNewProduct.lbSecondPrice.text = getPriceNew(prod: newProd2)
					cellNewProduct.lbOldPrice2.isHidden = false
					cellNewProduct.viewRemoveOldPrice2.isHidden = false
					cellNewProduct.lbOldPrice2.text = self.getPriceOld(prod: newProd2)
				}else{
					cellNewProduct.lbSecondPrice.text = getPriceOld(prod: newProd2)
					cellNewProduct.lbOldPrice2.isHidden = true
					cellNewProduct.viewRemoveOldPrice2.isHidden = true
				}
				
				cellNewProduct.btnSecondProduct.tag = Int(newProd2.id!)!
				cellNewProduct.lbThirdTitle.text = newProd3.title
//				cellNewProduct.lbThirdPrice.text = getPrice(prod: newProd3)
				cellNewProduct.btnThirdProduct.sd_setBackgroundImage(with: URL(string:newProd3.image!), for: .normal)
				let ifDiscount3 = newProd3.discountPercentage! as NSString
				if ifDiscount3.floatValue > 0.0 {
					cellNewProduct.lbDiscount3.text = newProd3.discountPercentage! + "% OFF"
				}else{
					cellNewProduct.viewDiscount3.isHidden = true
				}
				
				let ifPrice3 = newProd3.price! as NSString
				if ifPrice3.floatValue > 0.0 {
					cellNewProduct.lbThirdPrice.text = getPriceNew(prod: newProd3)
					cellNewProduct.lbOldPrice3.isHidden = false
					cellNewProduct.viewRemoveOldPrice3.isHidden = false
					cellNewProduct.lbOldPrice3.text = self.getPriceOld(prod: newProd3)
				}else{
					cellNewProduct.lbThirdPrice.text = getPriceOld(prod: newProd3)
					cellNewProduct.lbOldPrice3.isHidden = true
					cellNewProduct.viewRemoveOldPrice3.isHidden = true
				}
				
				cellNewProduct.btnThirdProduct.tag = Int(newProd3.id!)!
				cellNewProduct.lbFourthTitle.text = newProd4.title
//				cellNewProduct.lbFourthPrice.text = getPrice(prod: newProd4)
				cellNewProduct.btnFourthProduct.sd_setBackgroundImage(with: URL(string:newProd4.image!), for: .normal)
				let ifDiscount4 = newProd4.discountPercentage! as NSString
				if ifDiscount4.floatValue > 0.0 {
					cellNewProduct.lbDiscount4.text = newProd4.discountPercentage! + "% OFF"
				}else{
					cellNewProduct.viewDiscount4.isHidden = true
				}
				
				let ifPrice4 = newProd4.price! as NSString
				if ifPrice4.floatValue > 0.0 {
					cellNewProduct.lbFourthPrice.text = getPriceNew(prod: newProd4)
					cellNewProduct.lbOldPrice4.isHidden = false
					cellNewProduct.viewRemoveOldPrice4.isHidden = false
					cellNewProduct.lbOldPrice4.text = self.getPriceOld(prod: newProd4)
				}else{
					cellNewProduct.lbFourthPrice.text = getPriceOld(prod: newProd4)
					cellNewProduct.lbOldPrice4.isHidden = true
					cellNewProduct.viewRemoveOldPrice4.isHidden = true
				}
				
				cellNewProduct.btnFourthProduct.tag = Int(newProd4.id!)!
				cellNewProduct.lbFifthTitle.text = newProd5.title
//				cellNewProduct.lbFifthPrice.text = getPrice(prod: newProd5)
				cellNewProduct.btnFifth.sd_setBackgroundImage(with: URL(string:newProd5.image!), for: .normal)
				let ifDiscount5 = newProd5.discountPercentage! as NSString
				if ifDiscount5.floatValue > 0.0 {
					cellNewProduct.lbDiscount5.text = newProd5.discountPercentage! + "% OFF"
				}else{
					cellNewProduct.viewDiscount5.isHidden = true
				}
				
				let ifPrice5 = newProd5.price! as NSString
				if ifPrice5.floatValue > 0.0 {
					cellNewProduct.lbFifthPrice.text = getPriceNew(prod: newProd5)
					cellNewProduct.lbOldPrice5.isHidden = false
					cellNewProduct.viewRemoveOldPrice5.isHidden = false
					cellNewProduct.lbOldPrice5.text = self.getPriceOld(prod: newProd5)
				}else{
					cellNewProduct.lbFifthPrice.text = getPriceOld(prod: newProd5)
					cellNewProduct.lbOldPrice5.isHidden = true
					cellNewProduct.viewRemoveOldPrice5.isHidden = true
				}
				
				cellNewProduct.btnFifth.tag = Int(newProd5.id!)!
				cellNewProduct.lbSixthTitle.text = newProd6.title
//				cellNewProduct.lbSixthPrice.text = getPrice(prod: newProd6)
				cellNewProduct.btnSixth.sd_setBackgroundImage(with: URL(string:newProd6.image!), for: .normal)
				let ifDiscount6 = newProd6.discountPercentage! as NSString
				if ifDiscount6.floatValue > 0.0 {
					cellNewProduct.lbDiscount6.text = newProd6.discountPercentage! + "% OFF"
				}else{
					cellNewProduct.viewDiscount6.isHidden = true
				}
				
				let ifPrice6 = newProd6.price! as NSString
				if ifPrice6.floatValue > 0.0 {
					cellNewProduct.lbSixthPrice.text = getPriceNew(prod: newProd6)
					cellNewProduct.lbOldPrice6.isHidden = false
					cellNewProduct.viewRemoveOldPrice6.isHidden = false
					cellNewProduct.lbOldPrice6.text = self.getPriceOld(prod: newProd6)
				}else{
					cellNewProduct.lbSixthPrice.text = getPriceOld(prod: newProd6)
					cellNewProduct.lbOldPrice6.isHidden = true
					cellNewProduct.viewRemoveOldPrice6.isHidden = true
				}
				
				cellNewProduct.btnSixth.tag = Int(newProd6.id!)!
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
		return 618
	}
	

    override func viewDidLoad() {
        super.viewDidLoad()
		self.lbBadgeCount.text = "15"
		self.fullImageTableView.delegate = self
		self.fullImageTableView.dataSource = self
		SideMenuManager.default.menuLeftNavigationController = storyboard!.instantiateViewController(withIdentifier: "LeftMenuNavigationController") as? UISideMenuNavigationController
		SideMenuManager.default.menuLeftNavigationController?.menuWidth = 150
		self.getRecommendedProducts()
		self.hideKeyboard()
		
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
	
	
	fileprivate func getRecommendedProducts() {
		
		if Reachability.isConnectedToInternet() {
			print("Yes! internet is available.")
			SVProgressHUD.show(withStatus: "Loading Request")
			
			let urlString = KBaseUrl + KRecommendedProduct
			Alamofire.request(urlString, method: .get, parameters: nil, encoding: JSONEncoding.default)
				.downloadProgress(queue: DispatchQueue.global(qos: .utility)) { progress in
//					print("Progress: \(progress.fractionCompleted)")
				}
				.validate { request, response, data in
					return .success
				}
				.responseJSON { response in
//					debugPrint(response)
					
					SVProgressHUD.dismiss()
					if	response.result.value == nil {
						self.btnReload.isHidden = false
						self.alerts(title: "Alert", message: "Response time out")
						return
					}
					
					if response.response!.statusCode == 200 {
						self.btnReload.isHidden = true
						let JSON:NSDictionary = (response.result.value as! NSDictionary?)!
						self.recommendedProduct = []
						self.bestSellingProduct = []
						self.newProduct = []
						for dictionary in JSON["recommended_products"] as! NSArray{
							let product:CategoryProduct = CategoryProduct(dictionary: dictionary as! NSDictionary)
							self.recommendedProduct.append(product)
						}
//						print(self.recommendedProduct)
						for dictionary in JSON["best_selling_products"] as! NSArray{
							let product:CategoryProduct = CategoryProduct(dictionary: dictionary as! NSDictionary)
							self.bestSellingProduct.append(product)
						}
//						print(self.bestSellingProduct)
						for dictionary in JSON["new_products"] as! NSArray{
							let product:CategoryProduct = CategoryProduct(dictionary: dictionary as! NSDictionary)
							self.newProduct.append(product)
						}
//						print(self.newProduct)
						self.fullImageTableView.reloadData()
						
						
						
					}else if response.response!.statusCode == 401{
						SVProgressHUD.dismiss()
						self.btnReload.isHidden = false
						self.alerts(title: "Alert", message: "KInvalidKey")
						
					}else if response.response!.statusCode == 400{
						SVProgressHUD.dismiss()
						self.btnReload.isHidden = false
						self.alerts(title: "Alert", message: "KNoResourceFound")
						
					}else{
						SVProgressHUD.dismiss()
						self.btnReload.isHidden = false
						self.alerts(title: "Alert", message: "KUnknown")
					}
					
			}
		}else{
			SVProgressHUD.dismiss()
			self.btnReload.isHidden = false
			alerts(title: "Network", message: KNoNetwork)
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
			destinationVC?.categoryType = 29
		case "categoryPreBoxIdentifier":
			destinationVC?.categoryType = 39
		default:
			destinationVC?.categoryType = 1
		}
    }
	
	
	@IBAction func btnMenuAction(_ sender: Any) {
		present(SideMenuManager.default.menuLeftNavigationController!, animated: true, completion: nil)
	}
	
	@IBAction func btnViewMoreAction(_ sender: UIButton) {
		
		switch sender.tag {
		case 21:
			print("Recommended View More")
			if self.recommendedProduct.count > 0 {
				let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "viewMoreID") as! ViewMoreViewController
				nextViewController.arrCategoryProduct = self.recommendedProduct
				nextViewController.heading = "Recommended Products"
				self.navigationController?.pushViewController(nextViewController, animated: true)
			}
		case 22:
			print("Best Selling View More")
			if self.bestSellingProduct.count > 0 {
				let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "viewMoreID") as! ViewMoreViewController
				nextViewController.arrCategoryProduct = self.bestSellingProduct
				nextViewController.heading = "In Season"
				self.navigationController?.pushViewController(nextViewController, animated: true)
			}
		case 23:
			print("New View More")
			if self.newProduct.count > 0 {
				let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "viewMoreID") as! ViewMoreViewController
				nextViewController.arrCategoryProduct = self.newProduct
				nextViewController.heading = "New Arrivals"
				self.navigationController?.pushViewController(nextViewController, animated: true)
			}
		default:
			print("None Selected")
		}
		
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

//	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
////		print("hoja  bhai")
//		return true
//	}
	@IBAction func searchClicked(_ sender: UITextField) {
		print("Search clicked")
		print(sender.text!)
		let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "searchID") as! SearchViewController
		nextViewController.searchText = sender.text
		self.navigationController?.pushViewController(nextViewController, animated: true)
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
	
	@IBAction func reloadDataAction(_ sender: Any) {
		getRecommendedProducts()
	}
	@IBAction func btnContactAction(_ sender: Any) {
		self.callUs()
	}
}


extension UIViewController {
	func callUs(){
		if let url = URL(string: "tel://80067823"), UIApplication.shared.canOpenURL(url) {
			if #available(iOS 10, *) {
				UIApplication.shared.open(url)
			} else {
				UIApplication.shared.openURL(url)
			}
		}
	}
	
	func getPrice(prod:CategoryProduct) -> String {
		
		let ifPrice = prod.price! as NSString
		if ifPrice.floatValue > 0.0 {
			prod.oldPrice = prod.price
		}
		
		
		if prod.packaging == "KG" || prod.packaging == "kg"{
			//for Unit Price
			let quarterPrice = prod.oldPrice! as NSString
			let kgPrice = quarterPrice.floatValue * 4
			
			return "AED " + String(format: "%.2f", kgPrice) + "/KG"
		}else if prod.packaging == "Precut" || prod.packaging == "precut"{
			return "AED " + prod.oldPrice! + "/Pack"
		}else{
			return "AED " + prod.oldPrice! + "/" + prod.packaging!
		}
		
		
	}
	
	func getPriceOld(prod:CategoryProduct) -> String {
		
		let ifPrice = prod.price! as NSString
		if ifPrice.floatValue > 0.0 {
			if prod.packaging == "KG" || prod.packaging == "kg"{
				//for Unit Price
				let quarterPrice = prod.oldPrice! as NSString
				let kgPrice = quarterPrice.floatValue * 4
				
				return "AED" + String(format: "%.2f", kgPrice) //+ "/KG"
			}else if prod.packaging == "Precut" || prod.packaging == "precut"{
				return "AED" + prod.oldPrice!// + "/Pack"
			}else{
				return "AED" + prod.oldPrice! //+ "/" + prod.packaging!
			}
		}else{
			if prod.packaging == "KG" || prod.packaging == "kg"{
				//for Unit Price
				let quarterPrice = prod.oldPrice! as NSString
				let kgPrice = quarterPrice.floatValue * 4
				
				return "AED" + String(format: "%.2f", kgPrice) + "/KG"
			}else if prod.packaging == "Precut" || prod.packaging == "precut"{
				return "AED" + prod.oldPrice! + "/Pack"
			}else{
				return "AED" + prod.oldPrice! + "/" + prod.packaging!
			}
		}
		
		
		
		
		
	}
	
	func getPriceNew(prod:CategoryProduct) -> String {
		
		if prod.packaging == "KG" || prod.packaging == "kg"{
			//for Unit Price
			let quarterPrice = prod.price! as NSString
			let kgPrice = quarterPrice.floatValue * 4
			
			return "AED" + String(format: "%.2f", kgPrice) + "/KG"
		}else if prod.packaging == "Precut" || prod.packaging == "precut"{
			return "AED" + prod.price! + "/Pack"
		}else{
			return "AED" + prod.price! + "/" + prod.packaging!
		}
		
		
	}
	
	
}


