import XCTest

@testable import AdventOfCode

final class Day07Tests: XCTestCase {
    let testData = """
        32T3K 765
        T55J5 684
        KK677 28
        KTJJT 220
        QQQJA 483
        """
    /*
     Five of a kind, where all five cards have the same label: AAAAA
     Four of a kind, where four cards have the same label and one card has a different label: AA8AA
     Full house, where three cards have the same label, and the remaining two cards share a different label: 23332
     Three of a kind, where three cards have the same label, and the remaining two cards are each different from any other card in the hand: TTT98
     Two pair, where two cards share one label, two other cards share a second label, and the remaining card has a third label: 23432
     One pair, where two cards share one label, and the other three cards have a different label from the pair and each other: A23A4
     High card, where all cards' labels are distinct: 23456
     */

    func testKinds() throws {
        XCTAssertEqual(Day07.Hand(cards: "AAAAA".map { $0 }, bid: 0).kind(), .fiveOfKind)
        XCTAssertEqual(Day07.Hand(cards: "AA8AA".map { $0 }, bid: 0).kind(), .fourOfKind)
        XCTAssertEqual(Day07.Hand(cards: "23332".map { $0 }, bid: 0).kind(), .fullHouse)
        XCTAssertEqual(Day07.Hand(cards: "TTT98".map { $0 }, bid: 0).kind(), .threeOfKind)
        XCTAssertEqual(Day07.Hand(cards: "23432".map { $0 }, bid: 0).kind(), .twoPair)
        XCTAssertEqual(Day07.Hand(cards: "A23A4".map { $0 }, bid: 0).kind(), .onePair)
        XCTAssertEqual(Day07.Hand(cards: "23456".map { $0 }, bid: 0).kind(), .highCard)
    }

    func testKindsWithJoker() throws {
        XCTAssertEqual(Day07.Hand(cards: "KTJJT".map { $0 }, bid: 0).kindWithJoker(), .fourOfKind)
        XCTAssertEqual(Day07.Hand(cards: "QQQJA".map { $0 }, bid: 0).kindWithJoker(), .fourOfKind)
        XCTAssertEqual(Day07.Hand(cards: "T55J5".map { $0 }, bid: 0).kindWithJoker(), .fourOfKind)
    }

    func testPart1() throws {
        let challenge = Day07(data: testData)
        XCTAssertEqual(String(describing: challenge.part1()), "6440")
    }

    func testPart2() throws {
        let challenge = Day07(data: testData)
        XCTAssertEqual(String(describing: challenge.part2()), "5905")
    }
}
