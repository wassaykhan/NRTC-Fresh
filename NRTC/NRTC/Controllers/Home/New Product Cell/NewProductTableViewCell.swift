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
	@IBOutlet weak var lbProductType: UILabel!
	@IBOutlet weak var lbFirstTitle: UILabel!
	@IBOutlet weak var lbFisrtPrice: UILabel!
	@IBOutlet weak var lbSecondTitle: UILabel!
	@IBOutlet weak var lbSecondPrice: UILabel!
	@IBOutlet weak var lbThirdTitle: UILabel!
	@IBOutlet weak var lbThirdPrice: UILabel!
	@IBOutlet weak var lbFourthTitle: UILabel!
	@IBOutlet weak var lbFourthPrice: UILabel!
	@IBOutlet weak var btnfirstProduct: UIButton!
	@IBOutlet weak var btnSecondProduct: UIButton!
	@IBOutlet weak var btnThirdProduct: UIButton!
	@IBOutlet weak var btnFourthProduct: UIButton!
	@IBOutlet weak var btnViewMore: UIButton!
	
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
