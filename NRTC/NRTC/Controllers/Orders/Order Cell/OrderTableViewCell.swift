//
//  OrderTableViewCell.swift
//  NRTC
//
//  Created by Wassay Khan on 03/10/2018.
//  Copyright © 2018 Netpace. All rights reserved.
//

import UIKit

class OrderTableViewCell: UITableViewCell {
	
	@IBOutlet weak var orderView: UIView!
	@IBOutlet weak var lbQuantity: UILabel!
	@IBOutlet weak var imgProduct: UIImageView!
	@IBOutlet weak var lbTitle: UILabel!
	@IBOutlet weak var lbPrice: UILabel!
	
	var onAddTapped : (() -> Void)? = nil
	var onSubTapped : (() -> Void)? = nil
	
	override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
		self.orderView.layer.cornerRadius = 10
		self.orderView.clipsToBounds = true
    }
	@IBAction func btnAddAction(_ sender: Any) {
		
		if let onAddTapped = self.onAddTapped {
			onAddTapped()
		}		
		//print(quantity)
	}
	@IBAction func btnSubtractAction(_ sender: Any) {
		
		if let onSubTapped = self.onSubTapped {
			onSubTapped()
		}
		
	}
	
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
