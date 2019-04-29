//
//  BannerTableViewCell.swift
//  NRTC
//
//  Created by Wassay Khan on 15/11/2018.
//  Copyright © 2018 Netpace. All rights reserved.
//

import UIKit

class BannerTableViewCell: UITableViewCell {

	@IBOutlet weak var imgBanner: UIImageView!
	override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
