import XCTest

@testable import AdventOfCode

final class Day10Tests: XCTestCase {
    func testPart1() throws {
        let testData = """
            7-F7-
            .FJ|7
            SJLL7
            |F--J
            LJ.LJ
            """
        let challenge = Day10(data: testData)
        XCTAssertEqual(String(describing: challenge.part1()), "8")
    }

    func testPart2() throws {
        let testData = """
            FF7FSF7F7F7F7F7F---7
            L|LJ||||||||||||F--J
            FL-7LJLJ||||||LJL-77
            F--JF--7||LJLJIF7FJ-
            L---JF-JLJIIIIFJLJJ7
            |F|F-JF---7IIIL7L|7|
            |FFJF7L7F-JF7IIL---7
            7-L-JL7||F7|L7F-7F7|
            L.L7LFJ|||||FJL7||LJ
            L7JLJL-JLJLJL--JLJ.L
            """
        let challenge = Day10(data: testData)
        XCTAssertEqual(String(describing: challenge.part2()), "10")

        let tc2 = """
            ...........
            .S-------7.
            .|F-----7|.
            .||.....||.
            .||.....||.
            .|L-7.F-J|.
            .|..|.|..|.
            .L--J.L--J.
            ...........
            """
        let c2 = Day10(data: tc2)
        XCTAssertEqual(String(describing: c2.part2()), "4")
    }
}
