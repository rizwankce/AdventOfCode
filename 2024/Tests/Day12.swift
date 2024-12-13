import Testing

@testable import AdventOfCode

struct Day12Tests {
  let testData = """
    RRRRIICCFF
    RRRRIICCCF
    VVRRRCCFFF
    VVRCCCJFFF
    VVVVCJJCFE
    VVIVCCJJEE
    VVIIICJJEE
    MIIIIIJJEE
    MIIISIJEEE
    MMMISSJEEE
    """

  @Test func testPart1() async throws {
    let challenge = Day12(data: testData)
    #expect(String(describing: challenge.part1()) == "1930")
  }

  @Test func testPart2() async throws {
    let challenge = Day12(data: testData)
    #expect(String(describing: challenge.part2()) == "0")
  }
}
