import Foundation

/**
 Day-2 Question-1
 */

func multiplesOf3And5() -> Int {
    var sum = 0

    for number in 1..<1000 {
        if number % 3 == 0 || number % 5 == 0 {
            sum += number
        }
    }
    return sum
}

multiplesOf3And5() //233168
