import XCTest

@testable import AdventOfCode

final class Day10Tests: XCTestCase {
    let testData = """
        7-F7-
        .FJ|7
        SJLL7
        |F--J
        LJ.LJ
        """

    func testPart1() throws {
        let challenge = Day10(data: testData)
        XCTAssertEqual(String(describing: challenge.part1()), "8")
    }

    func testPart2() throws {
        let challenge = Day10(data: testData)
        XCTAssertEqual(String(describing: challenge.part2()), "")
    }
}
