import XCTest

@testable import AdventOfCode

final class Day24Tests: XCTestCase {
    let testData = """
        19, 13, 30 @ -2,  1, -2
        18, 19, 22 @ -1, -1, -2
        20, 25, 34 @ -2, -2, -4
        12, 31, 28 @ -1, -2, -1
        20, 19, 15 @  1, -5, -3
        """

    func testPart1() throws {
        let challenge = Day24(data: testData)
        let ans = challenge.intersectionAtTestArea(7, 27)
        XCTAssertEqual(String(describing: ans), "2")
    }

    func testPart2() throws {
        let challenge = Day24(data: testData)
        XCTAssertEqual(String(describing: challenge.part2()), "")
    }
}
