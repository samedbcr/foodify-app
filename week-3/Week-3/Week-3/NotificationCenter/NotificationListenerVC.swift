//
//  NotificationListenerVC.swift
//  Week-3
//
//  Created by Samed Biçer on 15.07.2021.
//

import UIKit

class NotificationListenerVC: UIViewController {
    @IBOutlet weak var incomingDataLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(handleData(notification:)), name: .sendDataNotification, object: nil)
    }

    @objc func handleData(notification: Notification) {
        if let name = notification.userInfo?["data"] as? String {
            incomingDataLabel.text = name
        }
    }
    
}
