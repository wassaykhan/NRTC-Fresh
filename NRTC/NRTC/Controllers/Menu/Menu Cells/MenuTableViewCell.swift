//
//  MenuTableViewCell.swift
//  NRTC
//
//  Created by Wassay Khan on 14/10/2018.
//  Copyright © 2018 Netpace. All rights reserved.
//

import UIKit

class MenuTableViewCell: UITableViewCell {

	@IBOutlet weak var imgMenuItem: UIImageView!
	@IBOutlet weak var lbMenuItem: UILabel!
	@IBOutlet weak var webImage: UIWebView!
	@IBOutlet weak var lbMenu: UILabel!
	override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
