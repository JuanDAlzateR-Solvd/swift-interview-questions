import XCTest
@testable import SwiftInterviewQuestions

final class Question03Tests: XCTestCase {

    func testDecodeEncodedString_withSimpleEncodedString_returnsRepeatedContent() {
        let input = "3[abc]"

        let result = Question03.decodeEncodedString(input)

        XCTAssertEqual(result, "abcabcabc")
    }

    func testDecodeEncodedString_withNestedEncodedString_returnsExpectedResult() {
        let input = "2[a3[b]]"

        let result = Question03.decodeEncodedString(input)

        XCTAssertEqual(result, "abbbabbb")
    }

    func testDecodeEncodedString_withPrefixAndSuffix_returnsExpectedResult() {
        let input = "start2[b3[cd]middle5[f]]end"

        let result = Question03.decodeEncodedString(input)

        XCTAssertEqual(
            result,
            "startbcdcdcdmiddlefffffbcdcdcdmiddlefffffend"
        )
    }

    func testDecodeEncodedString_withoutBrackets_returnsSameString() {
        let input = "plainText"

        let result = Question03.decodeEncodedString(input)

        XCTAssertEqual(result, "plainText")
    }

    func testSplitWordAndNumber_withTrailingNumber_returnsExpectedParts() {
        let result = Question03.splitWordAndNumber("start2")

        XCTAssertEqual(result.word, "start")
        XCTAssertEqual(result.number, 2)
    }

    func testFirstBalancedBracketContentRange_withNestedBrackets_returnsCorrectRange() {
        let input = "x[a2[b]c]y"

        let range = Question03.firstBalancedBracketContentRange(input)

        XCTAssertNotNil(range)

        if let range {
            let content = String(input[range.startIndex..<range.endIndex])
            XCTAssertEqual(content, "a2[b]c")
        }
    }
}