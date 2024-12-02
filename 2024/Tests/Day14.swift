import Testing

@testable import AdventOfCode

struct Day14Tests {
	let testData = """

		"""

	@Test func testPart1() async throws {
		let challenge = Day14(data: testData)
		#expect(String(describing: challenge.part1()) == "0")
	}

	@Test func testPart2() async throws {
		let challenge = Day14(data: testData)
		#expect(String(describing: challenge.part2()) == "0")
	}
}
