import Foundation

/**
 Day-2 Question-5
 */

func findGCD(of firstNumber: Int, and secondNumber: Int) -> Int {
    if firstNumber == 0 {
        return secondNumber
    } else {
        return findGCD(of: secondNumber % firstNumber, and: firstNumber)
    }
}

func findLCD(of firstNumber: Int, and secondNumber: Int) -> Int {
    return (firstNumber * secondNumber) / findGCD(of: firstNumber, and: secondNumber)
}

func findSmallestMultiple() -> Int {
    var smallestMultiple = 1
    
    for number in 1...20 {
        if smallestMultiple % number != 0 {
            smallestMultiple = findLCD(of: smallestMultiple, and: number)
        }
    }
    
    return smallestMultiple
}

findSmallestMultiple() // 232792560
