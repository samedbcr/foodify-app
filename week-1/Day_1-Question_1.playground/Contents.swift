import Foundation

/**
 Day-1 Question-1
 */
func removeChars(characters: String, count: Int) -> String {
    var characterCounts = [String.Element: Int]()
    var removedCharacters = characters

    for character in characters {
        if character != " " {
            if let characterCount = characterCounts[character] {
                characterCounts[character] = characterCount + 1
            } else {
                characterCounts[character] = 1
            }

            if characterCounts[character]! >= count {
                removedCharacters.removeAll { char in
                    return char == character
                }
            }
        }
    }

    return removedCharacters.trimmingCharacters(in: .whitespaces)
}

removeChars(characters: "aaba kouq bux", count: 2) // koq x
