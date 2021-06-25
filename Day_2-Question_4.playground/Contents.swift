import Foundation

/**
 Day-2 Question-4
 */

func findLargestPalindrome() -> Int {
    var largestPalindrome = 0
    var multiply: Int

    for firstNumber in (100...999).reversed() {
        for secondNumber in (100...999).reversed() {
            multiply = firstNumber * secondNumber

            // check if multiply is palindrome
            if String(multiply) == String(String(multiply).reversed()) {
                if multiply > largestPalindrome {
                    largestPalindrome = multiply
                    break
                }
            }
        }
    }

    return largestPalindrome
}

findLargestPalindrome() // 906609
