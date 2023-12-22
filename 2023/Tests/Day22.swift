import XCTest

@testable import AdventOfCode

final class Day22Tests: XCTestCase {
    let testData = """
        1,0,1~1,2,1
        0,0,2~2,0,2
        0,2,3~2,2,3
        0,0,4~0,2,4
        2,0,5~2,2,5
        0,1,6~2,1,6
        1,1,8~1,1,9
        """

    func testPart1() throws {
        let challenge = Day22(data: testData)
        XCTAssertEqual(String(describing: challenge.part1()), "5")
    }

    func testPart2() throws {
        let challenge = Day22(data: testData)
        XCTAssertEqual(String(describing: challenge.part2()), "7")
    }
}
