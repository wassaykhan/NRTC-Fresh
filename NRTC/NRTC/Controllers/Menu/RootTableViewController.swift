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
//	var userState = 0
	
	
    override func viewDidLoad() {
        super.viewDidLoad()
		self.edgesForExtendedLayout = UIRectEdge.init(rawValue: 0)
    }
	
	override func viewWillAppear(_ animated: Bool) {
		print("view will appear")
		self.tableView.reloadData()
//		if UserDefaults.standard.string(forKey: "first_name") == nil {
//			userState = 1
//		}else{
//			userState = 0
//		}
		
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
		
//		if UserDefaults.standard.string(forKey: "first_name") == nil {
//			return 2
//		}
		
        return 3
    }

	override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		return 0
	}
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		if indexPath.row == 0 {
			
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
			
			
			
		}else if indexPath.row == 2 {

			
			if UserDefaults.standard.string(forKey: "first_name") == nil {
				let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "loginID") as! LoginViewController
				////			nextViewController.searchText = sender.text
				self.navigationController?.pushViewController(nextViewController, animated: true)
			}else{
				let prefs = UserDefaults.standard
				prefs.removeObject(forKey:"Products")
				prefs.removeObject(forKey:"first_name")
				dismiss(animated: true, completion: nil)
				self.alerts(title: "Logout", message: "User is logged out")
			}
			
			
			
			
			
		}else if indexPath.row == 1 {
			
			
			let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "orderIdentifier") as! OrderViewController
			nextViewController.arrProduct = self.arrProducts
			//		nextViewController.productID = NSNumber(value: Int(productID!)!)
			self.navigationController?.pushViewController(nextViewController, animated: true)
		}
		
	}
	
	
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		if indexPath.row == 0 {
			let cell = tableView.dequeueReusableCell(withIdentifier: "menuItemCellIdentifier", for: indexPath) as! MenuTableViewCell
//			cell.lbMenuItem.text = "My Orders"
			
			
			cell.lbMenu.text = "My Orders"
			cell.imgMenuItem.image = UIImage(named: "my-order")
			return cell
		}else if indexPath.row == 1 {
			let cell = tableView.dequeueReusableCell(withIdentifier: "menuItemCellIdentifier", for: indexPath) as! MenuTableViewCell
			cell.lbMenu.text = "My Cart"
			cell.imgMenuItem.image = UIImage(named: "my-cart")
			return cell
		}else{
			let cell = tableView.dequeueReusableCell(withIdentifier: "menuItemCellIdentifier", for: indexPath) as! MenuTableViewCell
			
			if UserDefaults.standard.string(forKey: "first_name") == nil {
				cell.lbMenu.text = "Login"
			}else{
				cell.lbMenu.text = "Logout"
			}
			
//			cell.lbMenu.text = "Logout"
			cell.imgMenuItem.image = UIImage(named: "my-logout")
			return cell
		}
		
		
    }
	

	override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		
		return 112
		
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
