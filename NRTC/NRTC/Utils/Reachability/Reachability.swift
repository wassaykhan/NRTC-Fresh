//
//  Reachability.swift
//  NRTC
//
//  Created by Wassay Khan on 10/10/2018.
//  Copyright © 2018 Netpace. All rights reserved.
//

import Foundation
import Alamofire
import SystemConfiguration

class Reachability {
	class func isConnectedToInternet() ->Bool {
		return NetworkReachabilityManager()!.isReachable
	}
}
