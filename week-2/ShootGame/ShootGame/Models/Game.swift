//
//  Game.swift
//  ShootGame
//
//  Created by Samed Biçer on 30.06.2021.
//

import Foundation

class Game {
    var player: Player
    var cannon: Cannon
    var bottle: Bottle

    init(player: Player, cannon: Cannon, bottle: Bottle) {
        self.player = player
        self.cannon = cannon
        self.bottle = bottle
    }

    func enterNickname(name: String) {
        player.nickname = name
    }

    func enterPlayerNickname(name: String) {
        player.nickname = name
    }

    func enterBottlePosition(position: Double) {
        bottle.position = position
    }

    func enterCannonAngleAndVelocity(angle: Double, velocity: Double) {
        cannon.angle = angle
        cannon.velocity = velocity
    }


    func shoot() -> (isSucceed: Bool, throwDistance: Double) {
        // R=V*V*sin(2*teta)/g
        let r = pow(cannon.velocity, 2.0) * sin(2 * cannon.angle * .pi / 180) / 10.0

        print("R: \(r)")

        var returnData = (isSucceed: false, throwDistance: r)

        // d-delta ≤ R ≤ d+delta
        if bottle.position - bottle.volume <= r && r <= bottle.position + bottle.volume {
            player.point += 1
            returnData.isSucceed = true
        }
        return returnData
    }
}
