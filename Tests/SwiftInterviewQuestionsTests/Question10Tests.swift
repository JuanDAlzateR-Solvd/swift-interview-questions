import XCTest
@testable import SwiftInterviewQuestions

final class BracketValidationTests: XCTestCase {

    typealias Sut = Question10

    private func extractedContent(from input: String) -> String? {
        guard let (startIndex, endIndex) = Sut.firstBalancedBracketContentRange(input) else {
            return nil
        }
        return String(input[startIndex..<endIndex])
    }

    // MARK: - pairCharacters

    func testPairCharacters_withOpeningSquareBracket_returnsClosingSquareBracket() {
        XCTAssertEqual(Sut.pairCharacters("["), "]")
    }

    func testPairCharacters_withOpeningParenthesis_returnsClosingParenthesis() {
        XCTAssertEqual(Sut.pairCharacters("("), ")")
    }

    func testPairCharacters_withOpeningCurlyBracket_returnsClosingCurlyBracket() {
        XCTAssertEqual(Sut.pairCharacters("{"), "}")
    }

    func testPairCharacters_withInvalidCharacter_returnsSpace() {
        XCTAssertEqual(Sut.pairCharacters("a"), " ")
    }

    // MARK: - firstBalancedBracketContentRange

    func testFirstBalancedBracketContentRange_withEmptyString_returnsNil() {
        XCTAssertNil(Sut.firstBalancedBracketContentRange(""))
    }

    func testFirstBalancedBracketContentRange_withNonOpeningCharacter_returnsNil() {
        XCTAssertNil(Sut.firstBalancedBracketContentRange("abc"))
    }

    func testFirstBalancedBracketContentRange_withSimpleSquareBrackets_returnsInnerContent() {
        XCTAssertEqual(extractedContent(from: "[abc]"), "abc")
    }

    func testFirstBalancedBracketContentRange_withSimpleParentheses_returnsInnerContent() {
        XCTAssertEqual(extractedContent(from: "(abc)"), "abc")
    }

    func testFirstBalancedBracketContentRange_withSimpleCurlyBrackets_returnsInnerContent() {
        XCTAssertEqual(extractedContent(from: "{abc}"), "abc")
    }

    func testFirstBalancedBracketContentRange_withNestedSameTypeBrackets_returnsOuterContent() {
        XCTAssertEqual(extractedContent(from: "[a[b]c]"), "a[b]c")
    }

    func testFirstBalancedBracketContentRange_withNestedMixedBrackets_returnsOuterContent() {
        XCTAssertEqual(extractedContent(from: "{[()]}"), "[()]")
    }

    func testFirstBalancedBracketContentRange_withEmptyContent_returnsEmptyString() {
        XCTAssertEqual(extractedContent(from: "[]"), "")
    }

    func testFirstBalancedBracketContentRange_withMissingClosingBracket_returnsNil() {
        XCTAssertNil(Sut.firstBalancedBracketContentRange("[abc"))
    }

    func testFirstBalancedBracketContentRange_withWrongClosingBracket_returnsNil() {
        XCTAssertNil(Sut.firstBalancedBracketContentRange("[abc)"))
    }

    // MARK: - checkRightOrder

    func testCheckRightOrder_withEmptyString_returnsTrue() {
        XCTAssertTrue(Sut.checkRightOrder(""))
    }

    func testCheckRightOrder_withSimplePair_returnsTrue() {
        XCTAssertTrue(Sut.checkRightOrder("[]"))
    }

    func testCheckRightOrder_withMultipleSequentialPairs_returnsTrue() {
        XCTAssertTrue(Sut.checkRightOrder("()[]{}"))
    }

    func testCheckRightOrder_withNestedPairs_returnsTrue() {
        XCTAssertTrue(Sut.checkRightOrder("[()]"))
    }

    func testCheckRightOrder_withDeeplyNestedPairs_returnsTrue() {
        XCTAssertTrue(Sut.checkRightOrder("{[()]}"))
    }

    func testCheckRightOrder_withMixedNestedPairs_returnsTrue() {
        XCTAssertTrue(Sut.checkRightOrder("([{}])"))
    }

    func testCheckRightOrder_withMissingClosingBracket_returnsFalse() {
        XCTAssertFalse(Sut.checkRightOrder("["))
    }

    func testCheckRightOrder_withWrongOrder_returnsFalse() {
        XCTAssertFalse(Sut.checkRightOrder("([)]"))
    }

    func testCheckRightOrder_withClosingBracketFirst_returnsFalse() {
        XCTAssertFalse(Sut.checkRightOrder("]["))
    }

    func testCheckRightOrder_withInvalidCharactersInside_returnsFalse() {
        XCTAssertFalse(Sut.checkRightOrder("[abc]"))
    }

    func testCheckRightOrder_withValidPairFollowedByInvalidSuffix_returnsFalse() {
        XCTAssertFalse(Sut.checkRightOrder("[]("))
    }
}