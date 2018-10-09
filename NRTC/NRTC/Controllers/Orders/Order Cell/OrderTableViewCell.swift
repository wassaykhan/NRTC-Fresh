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
	
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
		self.orderView.layer.cornerRadius = 10
		self.orderView.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
