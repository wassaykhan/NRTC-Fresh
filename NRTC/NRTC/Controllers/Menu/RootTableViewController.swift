//
//  RootTableViewController.swift
//  NRTC
//
//  Created by Waqas Haider Sheikh on 27/09/2018.
//  Copyright © 2018 Netpace. All rights reserved.
//

import UIKit

class RootTableViewController: UITableViewController {

	var arrProducts:Array<Product> = []
	
    override func viewDidLoad() {
        super.viewDidLoad()
		self.edgesForExtendedLayout = UIRectEdge.init(rawValue: 0)
//		self.tableView.contentInset = UIEdgeInsets(top: -36, left: 0, bottom: 0, right: 0);
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
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
		}
	}
	

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		
		if UserDefaults.standard.string(forKey: "first_name") == nil {
			return 3
		}
		
        return 4
    }

	override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		return 0
	}
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		if indexPath.row == 1 {
			
			if UserDefaults.standard.string(forKey: "first_name") == nil {
				let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "loginID") as! LoginViewController
				////			nextViewController.searchText = sender.text
				self.navigationController?.pushViewController(nextViewController, animated: true)
			}else{
				//myOrderID
				let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "myOrderID") as! MyOrderViewController
				////			nextViewController.searchText = sender.text
				self.navigationController?.pushViewController(nextViewController, animated: true)
			}
			
			
			
		}else if indexPath.row == 3 {
			
			self.alerts(title: "Logout", message: "User is logged out")
			
			let prefs = UserDefaults.standard
			prefs.removeObject(forKey:"Products")
			prefs.removeObject(forKey:"first_name")
			
//			let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "homeID") as! HomeViewController
////			nextViewController.arrProduct = self.arrProducts
//			//		nextViewController.productID = NSNumber(value: Int(productID!)!)
//			self.navigationController?.pushViewController(nextViewController, animated: true)
			
//			self.performSegue(withIdentifier: "loginButton", sender: self)
			
		}else if indexPath.row == 2 {
			
			
			let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "orderIdentifier") as! OrderViewController
			nextViewController.arrProduct = self.arrProducts
			//		nextViewController.productID = NSNumber(value: Int(productID!)!)
			self.navigationController?.pushViewController(nextViewController, animated: true)
		}
		
	}
	
	
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		if indexPath.row == 0 {
			let cell = tableView.dequeueReusableCell(withIdentifier: "logoCellIdentifier", for: indexPath)
			return cell
		}else if indexPath.row == 1{
			let cell = tableView.dequeueReusableCell(withIdentifier: "menuItemCellIdentifier", for: indexPath) as! MenuTableViewCell
			cell.lbMenuItem.text = "My Orders"
			cell.imgMenuItem.image = UIImage(named: "MyOrder")
			return cell
		}else if indexPath.row == 2{
			let cell = tableView.dequeueReusableCell(withIdentifier: "menuItemCellIdentifier", for: indexPath) as! MenuTableViewCell
			cell.lbMenuItem.text = "View My Cart"
			cell.imgMenuItem.image = UIImage(named: "ViewCart")
			return cell
		}else{
			let cell = tableView.dequeueReusableCell(withIdentifier: "menuItemCellIdentifier", for: indexPath) as! MenuTableViewCell
			cell.lbMenuItem.text = "Logout"
			cell.imgMenuItem.image = UIImage(named: "Logout")
			return cell
		}
		
		
    }
	

	override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		if indexPath.row == 0 {
			return 112
		}else{
			return 47
		}
	}
	
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
