import XCTest
@testable import SwiftInterviewQuestions

final class LetterCountTests: XCTestCase {

    // countLetters
 func testCountLetters_withSingleLetter_returnsOneCount() {
    let input = "x"
    let expected: [Character: Int] = ["x": 1]

    let result = Question08.countLetters(input)

    XCTAssertEqual(result, expected)
}

func testCountLetters_withLettersNumbersAndPunctuation_ignoresNonLetters() {
    let input = "a1!b2?a"
    let expected:[Character: Int] = ["a": 2, "b": 1]

    let result = Question08.countLetters(input)

    XCTAssertEqual(result, expected)
}

func testCountLetters_withOnlyWhitespace_returnsEmptyDictionary() {
    let input = "    \n\t"

    let result = Question08.countLetters(input)

    XCTAssertTrue(result.isEmpty)
}

func testCountLetters_withAccentedLetters_countsThemAsDistinctCharacters() {
    let input = "aáaÁA"
    let expected: [Character: Int] = ["a": 2, "á": 1, "Á": 1, "A": 1]

    let result = Question08.countLetters(input)

    XCTAssertEqual(result, expected)
}

func testCountLetters_withSimpleString_returnsCorrectCounts() {
    let input = "hello"
    let expected: [Character: Int] = ["h": 1, "e": 1, "l": 2, "o": 1]

    let result = Question08.countLetters(input)

    XCTAssertEqual(result, expected)
}

func testCountLetters_withSpaces_returnsCorrectCounts() {
    let input = "bye bye"
    let expected: [Character: Int] = ["b": 2, "y": 2, "e": 2]

    let result = Question08.countLetters(input)

    XCTAssertEqual(result, expected)
}

func testCountLetters_onlyNonLetters_returnsEmptyDictionary() {
    let input = "123 !+-/@#"
    let expected: [Character: Int] = [:]

    let result = Question08.countLetters(input)

    XCTAssertEqual(result, expected)
}

func testCountLetters_withStringAndEmojis_returnsCorrectCounts() {
    let input = "I love Swift! ❤️🐼🏎️🖥️"
    let expected: [Character: Int] = [
        "I": 1,
        "l": 1,
        "o": 1,
        "v": 1,
        "e": 1,
        "S": 1,
        "w": 1,
        "i": 1,
        "f": 1,
        "t": 1
    ]

    let result = Question08.countLetters(input)

    XCTAssertEqual(result, expected)
}

func testCountLetters_withEmptyString_returnsEmptyDictionary() {
    let input = ""
    let expected: [Character: Int] = [:]

    let result = Question08.countLetters(input)

    XCTAssertEqual(result, expected)
}

func testCountLetters_withSameLettersInDifferentOrder_returnsSameCounts() {
    let input1 = "rome"
    let input2 = "more"

    let result1 = Question08.countLetters(input1)
    let result2 = Question08.countLetters(input2)

    XCTAssertEqual(result1, result2)
}

func testCountLetters_withMixedCaseString_returnsCorrectCounts() {
    let input = "AaBbCc"
    let expected: [Character: Int] = ["A": 1, "a": 1, "B": 1, "b": 1, "C": 1, "c": 1]

    let result = Question08.countLetters(input)

    XCTAssertEqual(result, expected)
}

func testCountLetters_withChineseCharacters_returnsCorrectCounts() {
    let input = "好好学习，天天向上"
    let expected: [Character: Int] = ["好": 2, "学": 1, "习": 1, "天": 2, "向": 1, "上": 1]

    let result = Question08.countLetters(input)

    XCTAssertEqual(result, expected)
}

func testCountLetters_withLongString_returnsCorrectCounts() {
    let input = String(repeating: "abcde", count: 1000)
    let expected: [Character: Int] = ["a": 1000, "b": 1000, "c": 1000, "d": 1000, "e": 1000]

    let result = Question08.countLetters(input)

    XCTAssertEqual(result, expected)
}

func testCountLetters_withSpanishCharacters_returnsCorrectCounts() {
    let input = "¿¡pingüino ñandú!?"
    let expected: [Character: Int] = [
        "p": 1,
        "i": 2,
        "n": 3,
        "g": 1,
        "ü": 1,
        "o": 1,
        "ñ": 1,
        "a": 1,
        "d": 1,
        "ú": 1
    ]

    let result = Question08.countLetters(input)

    XCTAssertEqual(result, expected)
}

}