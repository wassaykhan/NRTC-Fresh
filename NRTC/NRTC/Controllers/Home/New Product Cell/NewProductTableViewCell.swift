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
	@IBOutlet weak var btnFifth: UIButton!
	@IBOutlet weak var btnSixth: UIButton!
	@IBOutlet weak var lbFifthTitle: UILabel!
	@IBOutlet weak var lbFifthPrice: UILabel!
	@IBOutlet weak var lbSixthTitle: UILabel!
	@IBOutlet weak var lbSixthPrice: UILabel!
	//Discount
	@IBOutlet weak var viewDiscount1: UIView!
	@IBOutlet weak var lbDiscount1: UILabel!
	@IBOutlet weak var viewDiscount2: UIView!
	@IBOutlet weak var lbDiscount2: UILabel!
	@IBOutlet weak var viewDiscount3: UIView!
	@IBOutlet weak var lbDiscount3: UILabel!
	@IBOutlet weak var viewDiscount4: UIView!
	@IBOutlet weak var lbDiscount4: UILabel!
	@IBOutlet weak var viewDiscount5: UIView!
	@IBOutlet weak var lbDiscount5: UILabel!
	@IBOutlet weak var viewDiscount6: UIView!
	@IBOutlet weak var lbDiscount6: UILabel!
	//Old Value
	@IBOutlet weak var lbOldPrice1: UILabel!
	@IBOutlet weak var viewRemoveOldPrice1: UIView!
	@IBOutlet weak var lbOldPrice2: UILabel!
	@IBOutlet weak var viewRemoveOldPrice2: UIView!
	@IBOutlet weak var lbOldPrice3: UILabel!
	@IBOutlet weak var viewRemoveOldPrice3: UIView!
	@IBOutlet weak var lbOldPrice4: UILabel!
	@IBOutlet weak var viewRemoveOldPrice4: UIView!
	@IBOutlet weak var lbOldPrice5: UILabel!
	@IBOutlet weak var viewRemoveOldPrice5: UIView!
	@IBOutlet weak var lbOldPrice6: UILabel!
	@IBOutlet weak var viewRemoveOldPrice6: UIView!
	
	
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
