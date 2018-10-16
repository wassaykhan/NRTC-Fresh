//
//  ItemOrderTableViewCell.swift
//  NRTC
//
//  Created by Wassay Khan on 15/10/2018.
//  Copyright © 2018 Netpace. All rights reserved.
//

import UIKit

class ItemOrderTableViewCell: UITableViewCell {

	@IBOutlet weak var imgOrderItem: UIImageView!
	@IBOutlet weak var lbItemTitle: UILabel!
	@IBOutlet weak var lbQuantity: UILabel!
	@IBOutlet weak var lbTotal: UILabel!
	
	
	override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
