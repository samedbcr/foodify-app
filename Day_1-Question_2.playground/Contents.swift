import Foundation

/**
 Day-1 Question-2
 */

func findWordCountInSentence(sentence: String) -> [Substring: Int] {
    var wordCount = [Substring: Int]()
    let splittedSentence = sentence.split(separator: " ")

    for word in splittedSentence {
        if let count = wordCount[word] {
            wordCount[word] = count + 1
        } else {
            wordCount[word] = 1
        }
    }

    return wordCount
}

findWordCountInSentence(sentence: "Merhaba ben samed naber samed selam ben") // ["Merhaba": 1, "naber": 1, "samed": 2, "selam": 1, "ben": 2]
