//
//  HomeViewController.swift
//  NRTC
//
//  Created by Waqas Haider Sheikh on 27/09/2018.
//  Copyright © 2018 Netpace. All rights reserved.
//

import UIKit
import SideMenu

class HomeViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
	@IBOutlet var fullImageTableView: UITableView!
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 4
	}
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		if indexPath.row == 0 || (indexPath.row % 2 == 0){
			let cellFullImage:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "fullImageCellIdentifier", for: indexPath)
			return cellFullImage
		}
		
		
		let cellNewProduct:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "newProductCellIdentifier", for: indexPath)
		//newProductCellIdentifier
		return cellNewProduct
		
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
		
		
		
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
	@IBAction func btnMenuAction(_ sender: Any) {
		present(SideMenuManager.default.menuLeftNavigationController!, animated: true, completion: nil)
		
		// Similarly, to dismiss a menu programmatically, you would do this:
		//dismiss(animated: true, completion: nil)
	}
	
}
