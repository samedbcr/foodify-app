//
//  Double+Extensions.swift
//  ShootGame
//
//  Created by Samed Biçer on 2.07.2021.
//

import Foundation

extension Double {
    func roundDecimal(of number: Int) -> Double {
        let multiplier = pow(10.0, Double(number))
        return (self * multiplier).rounded() / multiplier
    }
}
