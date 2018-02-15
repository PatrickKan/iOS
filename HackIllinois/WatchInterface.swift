//
//  WatchInterface.swift
//  HackIllinois
//
//  Created by Kevin Rajan on 2/14/18.
//  Copyright © 2018 HackIllinois. All rights reserved.
//

import Foundation
import UIKit
import WatchConnectivity

class WatchInterface {
    
    static let shared = WatchInterface()
    var image: UIImage? {
        didSet {
            guard let image = image else { return }
            if let imageData = UIImagePNGRepresentation(image) {
                WCSession.default.activate()
                WCSession.default.sendMessageData(imageData, replyHandler: { (data) -> Void in
                    // handle the response from the device
                }) { (error) -> Void in
                    print("error: \(error.localizedDescription)")
                }
            }
        }
    }
}
