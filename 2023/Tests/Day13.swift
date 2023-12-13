import XCTest

@testable import AdventOfCode

final class Day13Tests: XCTestCase {
    let testData = """
        #.##..##.
        ..#.##.#.
        ##......#
        ##......#
        ..#.##.#.
        ..##..##.
        #.#.##.#.

        #...##..#
        #....#..#
        ..##..###
        #####.##.
        #####.##.
        ..##..###
        #....#..#
        """

    func testPart1() throws {
        let challenge = Day13(data: testData)
        XCTAssertEqual(String(describing: challenge.part1()), "405")
    }

    func testPart2() throws {
        let challenge = Day13(data: testData)
        XCTAssertEqual(String(describing: challenge.part2()), "400")
    }
}
