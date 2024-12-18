import Testing

@testable import AdventOfCode

struct Day18Tests {
  let testData = """
    5,4
    4,2
    4,5
    3,0
    2,1
    6,3
    2,4
    1,5
    0,6
    3,3
    2,6
    5,1
    1,2
    5,5
    2,5
    6,5
    1,4
    0,4
    6,4
    1,1
    6,1
    1,0
    0,5
    1,6
    2,0
    """

  @Test func testPart1() async throws {
    let challenge = Day18(data: testData)
    #expect(String(describing: challenge.simulate(12, 7, 7).count) == "22")
  }

  @Test func testPart2() async throws {
    let challenge = Day18(data: testData)
    #expect(String(describing: challenge.simulate(7)) == "6,1")
  }
}
