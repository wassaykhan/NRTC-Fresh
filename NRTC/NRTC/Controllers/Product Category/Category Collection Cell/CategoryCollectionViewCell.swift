//
//  CategoryCollectionViewCell.swift
//  NRTC
//
//  Created by Wassay Khan on 02/10/2018.
//  Copyright © 2018 Netpace. All rights reserved.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
	@IBOutlet weak var categoryView: UIView!
	override func awakeFromNib() {
		super.awakeFromNib()
		self.categoryView.layer.cornerRadius = 10
		self.categoryView.clipsToBounds = true
		// Initialization code
	}
	
}
