import Testing

@testable import AdventOfCode

struct Day03Tests {
  // Smoke test data provided in the challenge question
  let testData = """
    987654321111111
    811111111111119
    234234234234278
    818181911112111
    """

  @Test func testPart1() async throws {
    let challenge = Day03(data: testData)
    #expect(String(describing: challenge.part1()) == "357")
  }

  @Test func testPart2() async throws {
    let challenge = Day03(data: testData)
    #expect(String(describing: challenge.part2()) == "3121910778619")
  }
}
