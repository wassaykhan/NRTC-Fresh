//
//  MyOrderTableViewCell.swift
//  NRTC
//
//  Created by Wassay Khan on 15/10/2018.
//  Copyright © 2018 Netpace. All rights reserved.
//

import UIKit

class MyOrderTableViewCell: UITableViewCell {
	
	

	@IBOutlet weak var lbOrderID: UILabel!
	@IBOutlet weak var lbStatus: UILabel!
	@IBOutlet weak var lbDeliveredOn: UILabel!
	@IBOutlet weak var itemTableView: UITableView!
	@IBOutlet weak var lbTotal: UILabel!
	@IBOutlet weak var lbItems: UILabel!
	@IBOutlet weak var viewBackground: UIView!
	
	override func awakeFromNib() {
        super.awakeFromNib()
		self.viewBackground.layer.cornerRadius = 10
		self.viewBackground.clipsToBounds = true
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
