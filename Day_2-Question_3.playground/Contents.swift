import Foundation

/**
 Day-2 Question-3
 */

func findLargestPrimeFactor() -> Int {
    var number = 600851475143
    var largestPrime = 2

    while number > 1 {
        if number % largestPrime == 0 {
            number /= largestPrime
        } else {
            largestPrime += 1
        }
    }

    return largestPrime
}

findLargestPrimeFactor()
