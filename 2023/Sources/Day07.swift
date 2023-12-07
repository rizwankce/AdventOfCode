import Algorithms

struct Day07: AdventDay {
    var data: String

    var input: [String] {
        data.lines
    }

    struct Hand: Hashable, CustomStringConvertible {

        var description: String {
            "\(cards) : \(bid)"
        }

        let cards: [Character]
        let bid: Int

        enum Kind: CaseIterable {
            case fiveOfKind
            case fourOfKind
            case fullHouse
            case threeOfKind
            case twoPair
            case onePair
            case highCard
        }

        /*
         Five of a kind, where all five cards have the same label: AAAAA
         Four of a kind, where four cards have the same label and one card has a different label: AA8AA
         Full house, where three cards have the same label, and the remaining two cards share a different label: 23332
         Three of a kind, where three cards have the same label, and the remaining two cards are each different from any other card in the hand: TTT98
         Two pair, where two cards share one label, two other cards share a second label, and the remaining card has a third label: 23432
         One pair, where two cards share one label, and the other three cards have a different label from the pair and each other: A23A4
         High card, where all cards' labels are distinct: 23456
         */

        func kindWithJoker() -> Kind {
            guard cards.contains("J".first!) else { return kind() }

            let jCount = cards.filter { $0 == "J".first! }.count
            switch kind() {
            case .fiveOfKind: return .fiveOfKind
            case .fourOfKind: return .fiveOfKind
            case .fullHouse: return .fiveOfKind
            case .threeOfKind: return .fourOfKind
            case .twoPair:
                if jCount == 1 {
                    return .fullHouse
                }
                else {
                    return .fourOfKind
                }
            case .onePair: return .threeOfKind
            case .highCard: return .onePair
            }
        }

        func kind() -> Kind {
            let counts = Dictionary(grouping: cards, by: { $0 }).mapValues(\.count)

            switch counts.values.sorted() {
            case [5]: return .fiveOfKind
            case [1, 4]: return .fourOfKind
            case [2, 3]: return .fullHouse
            case [1, 1, 3]: return .threeOfKind
            case [1, 2, 2]: return .twoPair
            case [1, 1, 1, 2]: return .onePair
            case [1, 1, 1, 1, 1]: return .highCard
            default: fatalError()
            }
        }
    }

    struct CamelCards {
        let hands: [Hand]
        let strengths: [Character] = [
            "A", "K", "Q", "J", "T", "9", "8", "7", "6", "5", "4", "3", "2", "J",
        ].compactMap { $0.first }.reversed()
        let rankedKinds: [Hand.Kind] = Hand.Kind.allCases.reversed()

        init(_ input: [String]) {
            self.hands = input.map { line in
                let com = line.components(separatedBy: " ")
                return Hand(cards: Array(com[0]), bid: Int(com[1])!)
            }
        }

        func secondOrderRule(for h1: Hand, _ h2: Hand) -> Bool {
            var result: Bool = false
            for (c1, c2) in zip(h1.cards, h2.cards) {
                let s1 = strengths.firstIndex(of: c1)!
                let s2 = strengths.firstIndex(of: c2)!

                if s1 != s2 {
                    result = s1 < s2
                    break
                }
            }
            return result
        }

        func totalWinings(includeJoker: Bool = false) -> Int {
            var orderedHands: [Hand] = []
            for kind in rankedKinds {
                var hand = hands.filter {
                    if includeJoker {
                        $0.kindWithJoker() == kind
                    }
                    else {
                        $0.kind() == kind
                    }
                }

                hand = hand.sorted { h1, h2 in
                    secondOrderRule(for: h1, h2)
                }
                orderedHands.append(contentsOf: hand)
            }
            var total = 0
            for (i, hand) in orderedHands.enumerated() {
                total += hand.bid * (i + 1)
            }
            return total
        }
    }

    func part1() -> Any {
        CamelCards(input).totalWinings()
    }

    func part2() -> Any {
        CamelCards(input).totalWinings(includeJoker: true)
    }
}
