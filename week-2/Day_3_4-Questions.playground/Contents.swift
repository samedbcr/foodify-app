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
