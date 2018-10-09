//
//  NewProductTableViewCell.swift
//  NRTC
//
//  Created by Wassay Khan on 28/09/2018.
//  Copyright © 2018 Netpace. All rights reserved.
//

import UIKit

class NewProductTableViewCell: UITableViewCell {
	@IBOutlet weak var newProductView: UIView!
	
    override func awakeFromNib() {
        super.awakeFromNib()
		self.newProductView.layer.cornerRadius = 10
		self.newProductView.clipsToBounds = true
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
