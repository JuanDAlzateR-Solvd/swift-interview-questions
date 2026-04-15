import XCTest
@testable import SwiftInterviewQuestions

final class PalindromeTests: XCTestCase {

    // areReverseOfEachOther

    func testAreReverseOfEachOther_withSimpleReverseStrings_returnsTrue() {
        XCTAssertTrue(Question04.areReverseOfEachOther("abc", "cba"))
    }

    func testAreReverseOfEachOther_withMixedCase_returnsTrue() {
        XCTAssertTrue(Question04.areReverseOfEachOther("AbC", "cBa"))
    }

    func testAreReverseOfEachOther_withSpacesAndPunctuation_returnsTrue() {
        XCTAssertTrue(Question04.areReverseOfEachOther("A man, a plan", "nalp a ,nam A"))
    }

    func testAreReverseOfEachOther_withNumbers_returnsTrue() {
        XCTAssertTrue(Question04.areReverseOfEachOther("12345", "54321"))
    }

    func testAreReverseOfEachOther_withDifferentLengths_returnsFalse() {
        XCTAssertFalse(Question04.areReverseOfEachOther("abc", "dcba"))
    }

    func testAreReverseOfEachOther_withSameStringNotReversed_returnsFalse() {
        XCTAssertFalse(Question04.areReverseOfEachOther("abcd", "abcd"))
    }

    func testAreReverseOfEachOther_withNonReverseStrings_returnsFalse() {
        XCTAssertFalse(Question04.areReverseOfEachOther("abc", "xyz"))
    }

    func testAreReverseOfEachOther_withBothEmptyStrings_returnsTrue() {
        XCTAssertTrue(Question04.areReverseOfEachOther("", ""))
    }

    func testAreReverseOfEachOther_withOnlyIgnoredCharacters_returnsTrue() {
        XCTAssertTrue(Question04.areReverseOfEachOther("!!!", "???"))
    }

    // isPalindrome

    func testIsPalindrome_withSimplePalindrome_returnsTrue() {
        XCTAssertTrue(Question04.isPalindrome("racecar"))
    }

    func testIsPalindrome_withMixedCasePalindrome_returnsTrue() {
        XCTAssertTrue(Question04.isPalindrome("RaceCar"))
    }

    func testIsPalindrome_withSpacesAndPunctuation_returnsTrue() {
        XCTAssertTrue(Question04.isPalindrome("A man, a plan, a canal: Panama!"))
    }

    func testIsPalindrome_withNumbers_returnsTrue() {
        XCTAssertTrue(Question04.isPalindrome("12321"))
    }

    func testIsPalindrome_withNonPalindrome_returnsFalse() {
        XCTAssertFalse(Question04.isPalindrome("hello"))
    }

    func testIsPalindrome_withEmptyString_returnsTrue() {
        XCTAssertTrue(Question04.isPalindrome(""))
    }

    func testIsPalindrome_withOnlyIgnoredCharacters_returnsTrue() {
        XCTAssertTrue(Question04.isPalindrome(" ,.! "))
    }

    func testIsPalindrome_withSingleCharacter_returnsTrue() {
        XCTAssertTrue(Question04.isPalindrome("a"))
    }

}