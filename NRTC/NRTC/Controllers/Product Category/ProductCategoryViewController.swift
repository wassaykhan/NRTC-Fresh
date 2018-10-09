//
//  ProductCategoryViewController.swift
//  NRTC
//
//  Created by Wassay Khan on 02/10/2018.
//  Copyright © 2018 Netpace. All rights reserved.
//

import UIKit

class ProductCategoryViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
	@IBOutlet weak var categoryCollectionView: UICollectionView!
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return 8
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		//categoryCellIdentifier
		let cellCategory:UICollectionViewCell = categoryCollectionView.dequeueReusableCell(withReuseIdentifier: "categoryCellIdentifier", for: indexPath)
		//newProductCellIdentifier
		return cellCategory

	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		if UIScreen.main.nativeBounds.height == 1136{
			return CGSize(width: 140, height: 216)
		}
		return CGSize(width: 165, height: 236)
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
