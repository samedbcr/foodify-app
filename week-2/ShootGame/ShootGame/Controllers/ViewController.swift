//
//  ViewController.swift
//  ShootGame
//
//  Created by Samed Biçer on 29.06.2021.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var angleLabel: UILabel!
    @IBOutlet var velocityLabel: UILabel!
    @IBOutlet var angleSlider: UISlider!
    @IBOutlet var velocitySlider: UISlider!
    @IBOutlet var nicknameLabel: UILabel!
    @IBOutlet var positionLabel: UILabel!
    @IBOutlet var stateLabel: UILabel!

    var game: Game

    required init?(coder: NSCoder) {
        let player = Player(nickname: "Unknown Player", point: 2)
        let cannon = Cannon(angle: 47, velocity: 87)
        let bottle = Bottle(position: 750, volume: 0.3, state: .vertical)
        game = Game(player: player, cannon: cannon, bottle: bottle)

        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func angleValueChanged(_ sender: UISlider) {
        angleLabel.text = "Angle: \(angleSlider.value)"
        game.cannon.angle = Double(angleSlider.value)
    }

    @IBAction func velocityValueChanged(_ sender: UISlider) {
        velocityLabel.text = "Velocity: \(velocitySlider.value)"
        game.cannon.velocity = Double(velocitySlider.value)
    }

    @IBAction func shootClick(_ sender: UIButton) {
        let returnData = game.shoot()
        if returnData.isSucceed {
            stateLabel.text = "✅ SUCCEED!"
        } else {
            stateLabel.text = "❌ FAILED!\n\nYou've throwed \(returnData.throwDistance.roundDecimal(of: 3)) meters!"
        }
    }

    @IBAction func configureBtnClick(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let configureVC = storyboard.instantiateViewController(identifier: "ConfigureVC") as! ConfigureVC
        configureVC.nickname = game.player.nickname
        configureVC.position = String(game.bottle.position)
        configureVC.delegate = self

        present(configureVC, animated: true)
    }
}

extension ViewController: ConfigureGameDelegate {
    func gameConfigurationChange(config data: (nickname: String, position: String)) {
        print("nickname: \(data.nickname), position: \(data.position)")
        nicknameLabel.text = "👤 Dear, \(data.nickname)"
        positionLabel.text = "⛳️ Target distance of bottle: \(data.position)m"
        game.player.nickname = data.nickname
        game.bottle.position = Double(data.position) ?? 750.0
    }
}
