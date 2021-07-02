//
//  Cannon.swift
//  ShootGame
//
//  Created by Samed Biçer on 29.06.2021.
//

import Foundation

struct Cannon {
    var angle: Double = 45.0 { // (teta)
        didSet { checkAngle() }
    }

    var velocity: Double = 50.0 { // (v)
        didSet { checkVelocity() }
    }

    mutating func changeAngle() {
        angle = angle + 1
    }

    mutating func checkAngle() {
        // checking for angle range in 0...90
        if angle < 0 || angle > 90 {
            angle = 45
        }
    }

    mutating func checkVelocity() {
        // checking for velocity range in 0...100
        if velocity < 0 || velocity > 100 {
            velocity = 50
        }
    }
}
