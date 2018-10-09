//
//  ProductViewController.swift
//  NRTC
//
//  Created by Wassay Khan on 01/10/2018.
//  Copyright © 2018 Netpace. All rights reserved.
//

import UIKit
import ImageSlideshow

class ProductViewController: UIViewController {

	@IBOutlet weak var bgStockView: UIView!
	@IBOutlet weak var slideShowView: ImageSlideshow!
	override func viewDidLoad() {
        super.viewDidLoad()
		self.bgStockView.layer.cornerRadius = 10
		self.bgStockView.clipsToBounds = true
		slideShowView.setImageInputs([
			ImageSource(image: UIImage(named: "Image_47")!),
			ImageSource(image: UIImage(named: "Image_38")!),
			ImageSource(image: UIImage(named: "Image_37")!)
			])
		slideShowView.pageIndicatorPosition = .init(horizontal: .center, vertical: .under)
		slideShowView.contentScaleMode = UIView.ContentMode.scaleAspectFill
		
		let pageControl = UIPageControl()
		pageControl.currentPageIndicatorTintColor = UIColor.lightGray
		pageControl.pageIndicatorTintColor = UIColor.black
		slideShowView.pageIndicator = pageControl
		slideShowView.pageIndicator?.numberOfPages = 2
		
		slideShowView.activityIndicator = DefaultActivityIndicator()
		slideShowView.currentPageChanged = { page in
			print("current page:", page)
		}

		let recognizer = UITapGestureRecognizer(target: self, action: #selector(self.didTap))
		slideShowView.addGestureRecognizer(recognizer)
		
        // Do any additional setup after loading the view.
    }
	
	@objc func didTap() {
		let fullScreenController = slideShowView.presentFullScreenController(from: self)
		// set the activity indicator for full screen controller (skipping the line will show no activity indicator)
		fullScreenController.slideshow.activityIndicator = DefaultActivityIndicator(style: .white, color: nil)
	}
	
	@IBAction func btnBackAction(_ sender: Any) {
		self.navigationController?.popViewController(animated: true)
	}
	
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
