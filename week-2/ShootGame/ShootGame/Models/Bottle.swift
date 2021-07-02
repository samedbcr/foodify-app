//
//  Bottle.swift
//  ShootGame
//
//  Created by Samed Biçer on 30.06.2021.
//

import Foundation

enum BottleState: Int {
    case vertical = 1 // alive
    case horizontal = 0 // dead
}

struct Bottle {
    var position: Double = 750.0 { // (d) 0...1500
        didSet { checkPosition() }
    }
    var volume: Double = 0.3 { // (delta) 0,1...1
        didSet { checkVolume() }
    }
    var state: BottleState = .vertical

    mutating func checkPosition() {
        // checking for position range in 0...1500
        if position < 0 || position > 1500 {
            position = 750
        }
    }

    mutating func checkVolume() {
        // checking for volume range in 0,1...1
        if volume < 0.1 || volume > 1 {
            volume = 0.3
        }
    }

}
