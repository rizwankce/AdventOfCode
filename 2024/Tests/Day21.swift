import Testing

@testable import AdventOfCode

struct Day21Tests {
	let testData = """

		"""

	@Test func testPart1() async throws {
		let challenge = Day21(data: testData)
		#expect(String(describing: challenge.part1()) == "0")
	}

	@Test func testPart2() async throws {
		let challenge = Day21(data: testData)
		#expect(String(describing: challenge.part2()) == "0")
	}
}
