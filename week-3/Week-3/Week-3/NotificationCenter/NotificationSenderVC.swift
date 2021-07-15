//
//  NotificationSenderVC.swift
//  Week-3
//
//  Created by Samed Biçer on 15.07.2021.
//

import UIKit

class NotificationSenderVC: UIViewController {
    @IBOutlet weak var sendDataTextField: UITextField!
    
    var notificationData = [String: Any]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func sendBtnClick(_ sender: UIButton) {
        notificationData["data"] = sendDataTextField.text
        NotificationCenter.default.post(name: .sendDataNotification, object: nil, userInfo: notificationData)
        dismiss(animated: true, completion: nil)
    }
    
}
