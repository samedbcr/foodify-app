import Foundation

/**
 Day-3 Question-1
 MARK: Girilen bir sayının asal olup olmadığını bulan bir extension yazınız
 */
extension Int {
    func isPrime() -> Bool {
        var number = self

        if self < 2 {
            return false
        }

        if self == 2 {
            return true
        }

        if self % 2 == 0 {
            return false
        }
        // reduce number limit in order to optimization
        number = Int(sqrt(Double(number)))

        for i in stride(from: 3, through: number, by: 2) {
            if self % i == 0 {
                return false
            }
        }
        return true
    }
}

7.isPrime() // true

/**
 Day-3 Question-2
 MARK:- İki parametreli ve FARKLI tipli bir generic örneği yapınız... (T, U)
 */

/**
 Day-3 Project Euler Question-7
 MARK:- What is the 10 001st prime number?
 */
func findNthPrimeNumber(number: UInt32) -> Int {
    // Note that prime numbers always conform (6n - 1) and (6n + 1) rule
    var count = 2 // 2 and 3
    var n = 1
    var lowerNumber: Int
    var upperNumber: Int

    if number == 0 {
        return 0
    } else if number == 1 {
        return 2
    } else if number == 2 {
        return 3
    }

    while true {
        lowerNumber = (6 * n) - 1
        upperNumber = (6 * n) + 1

        if lowerNumber.isPrime() {
            count += 1
            if count == number {
                return lowerNumber
            }
        }

        if upperNumber.isPrime() {
            count += 1
            if count == number {
                return upperNumber
            }
        }

        n += 1
    }
}

findNthPrimeNumber(number: 10_001) // 104743
