import XCTest

@testable import AdventOfCode

final class Day25Tests: XCTestCase {
    let testData = """
        jqt: rhn xhk nvd
        rsh: frs pzl lsr
        xhk: hfx
        cmg: qnr nvd lhk bvb
        rhn: xhk bvb hfx
        bvb: xhk hfx
        pzl: lsr hfx nvd
        qnr: nvd
        ntq: jqt hfx bvb xhk
        nvd: lhk
        lsr: lhk
        rzs: qnr cmg lsr rsh
        frs: qnr lhk lsr
        """

    func testPart1() throws {
        let challenge = Day25(data: testData)
        XCTAssertEqual(String(describing: challenge.part1()), "54")
    }

    func testPart2() throws {
        let challenge = Day25(data: testData)
        XCTAssertEqual(String(describing: challenge.part2()), "")
    }
}
