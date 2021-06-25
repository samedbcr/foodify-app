import Foundation

/**
 Day-2 Question-2
 */

func evenFibonacciNumbers() -> Int {
    var previousNumber = 1
    var presentNumber = 2
    var sum = 0
    var temp: Int

    while presentNumber < 4_000_000 {
        if presentNumber % 2 == 0 {
            sum += presentNumber
        }

        temp = previousNumber
        previousNumber = presentNumber
        presentNumber = temp + previousNumber
    }

    return sum
}

evenFibonacciNumbers() //4613732
