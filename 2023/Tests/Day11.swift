import XCTest

@testable import AdventOfCode

final class Day11Tests: XCTestCase {
    let testData = """
        ...#......
        .......#..
        #.........
        ..........
        ......#...
        .#........
        .........#
        ..........
        .......#..
        #...#.....
        """

    func testPart1() throws {
        let challenge = Day11(data: testData)
        XCTAssertEqual(String(describing: challenge.part1()), "374")
    }

    func testPart2() throws {
        let challenge = Day11(data: testData)
        XCTAssertEqual(String(describing: challenge.part2()), "82000210")
    }
}
