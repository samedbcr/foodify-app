//
//  ConfigureVC.swift
//  ShootGame
//
//  Created by Samed Biçer on 2.07.2021.
//

import UIKit

protocol ConfigureGameDelegate {
    func gameConfigurationChange(config data: (nickname: String, position: String))
}

class ConfigureVC: UIViewController {
    @IBOutlet var nicknameTextField: UITextField!
    @IBOutlet var positionTextField: UITextField!

    var nickname: String?
    var position: String?
    var delegate: ConfigureGameDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        nicknameTextField.text = nickname
        positionTextField.text = position
    }

    @IBAction func applyButtonClick(_ sender: UIButton) {
        let nicknameText = nicknameTextField.text ?? "Unknown Player"
        let positionText = positionTextField.text ?? "750"
        delegate?.gameConfigurationChange(config: (nickname: nicknameText, position: positionText))

        self.dismiss(animated: true, completion: nil)
    }
}
