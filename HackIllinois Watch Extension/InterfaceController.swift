//
//  InterfaceController.swift
//  HackIllinois Watch Extension
//
//  Created by Kevin Rajan on 2/13/18.
//  Copyright © 2018 HackIllinois. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity

class InterfaceController: WKInterfaceController, WCSessionDelegate {
    var qrCodeImage: UIImage?
    @IBOutlet var loginLabel: WKInterfaceLabel!
    @IBOutlet var imageGroup: WKInterfaceGroup!
    @IBOutlet var qrCode: WKInterfaceImage!
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        // Configure interface objects here.
        self.setTitle("Countdown")
        guard let image = qrCodeImage else {
            loginLabel.setTextColor(HIApplication.Color.hotPink)
            let font = UIFont.systemFont(ofSize: 13, weight: .light)
            let attributeString = NSAttributedString( string: "Get started by logging in.",
                                                      attributes: [NSAttributedStringKey.font: font] )
            loginLabel.setAttributedText(attributeString)
            return
        }
        imageGroup.setBackgroundColor(HIApplication.Color.darkIndigo)
        qrCode.setImage(image)
    }
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        if WCSession.isSupported() {
            WCSession.default.delegate = self
            WCSession.default.activate()
        }
    }
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    func session(_ session: WCSession, didReceiveMessageData message: Data) {
        guard let image = UIImage(data: message) else { return }
        DispatchQueue.main.async { [weak self] in
            self?.qrCodeImage = image
            self?.loginLabel.setHidden(true)
            self?.imageGroup.setBackgroundColor(HIApplication.Color.darkIndigo)
            self?.qrCode.setImage(image)
        }
    }
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {}
    #if os(iOS)
    func sessionDidBecomeInactive(_ session: WCSession) {}
    func sessionDidDeactivate(_ session: WCSession) {}
    #endif
}
