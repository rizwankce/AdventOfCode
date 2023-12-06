import XCTest

@testable import AdventOfCode

final class Day06Tests: XCTestCase {
    let testData = """
        Time:      7  15   30
        Distance:  9  40  200
        """

    func testGetDistance() throws {
        let challenge = Day06(data: testData)
        XCTAssertEqual(challenge.getdistances(for: 7), [0,6,10,12,12,10,6,0])
        XCTAssertEqual(challenge.getdistances(for: 15).count, 16)
        XCTAssertEqual(challenge.getdistances(for: 30).count, 31)
    }

    func testPart1() throws {
        let challenge = Day06(data: testData)
        XCTAssertEqual(String(describing: challenge.part1()), "288")
    }

    func testPart2() throws {
        let challenge = Day06(data: testData)
        XCTAssertEqual(String(describing: challenge.part2()), "71503")
    }
}
