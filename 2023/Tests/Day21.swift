import XCTest

@testable import AdventOfCode

final class Day21Tests: XCTestCase {
    let testData = """
        ...........
        .....###.#.
        .###.##..#.
        ..#.#...#..
        ....#.#....
        .##..S####.
        .##..#...#.
        .......##..
        .##.#.####.
        .##..##.##.
        ...........
        """

    func testPart1() throws {
        let challenge = Day21(data: testData)
        XCTAssertEqual(String(describing: challenge.part1()), "42")
    }

    func testPart2() throws {
        let challenge = Day21(data: testData)
        XCTAssertEqual(String(describing: challenge.part2()), "")
    }
}
