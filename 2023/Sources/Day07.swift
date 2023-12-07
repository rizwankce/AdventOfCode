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
        var rank: Int = 0

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

        func kindWithJoker() -> Kind {  // KTJJT
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
            let uniques = Set(cards)
            if uniques.count == 1 {
                return .fiveOfKind
            }

            if uniques.count == 2 {
                let ua = Array(uniques)
                let f = cards.filter({ $0 == ua.first }).count
                let s = cards.filter({ $0 == ua.last }).count
                if f == 4 || s == 4 {
                    return .fourOfKind
                }

                if [3, 2].contains(f) || [3, 2].contains(s) {
                    return .fullHouse
                }
                assert(true, "failed \(cards) \(ua) ")
            }

            if uniques.count == 3 {
                /*
                 Three of a kind, where three cards have the same label, and the remaining two cards are each different from any other card in the hand: TTT98
                 Two pair, where two cards share one label, two other cards share a second label, and the remaining card has a third label: 23432
                 */
                let ua = Array(uniques)
                let f = cards.filter({ $0 == ua[0] }).count
                let s = cards.filter({ $0 == ua[1] }).count
                let t = cards.filter({ $0 == ua[2] }).count

                if f == 3 || s == 3 || t == 3 {
                    return .threeOfKind
                }

                if [2, 1].contains(f) || [2, 1].contains(s) || [2, 1].contains(t) {
                    return .twoPair
                }
                assert(true, "failed \(cards) \(ua) ")
            }

            if uniques.count == 4 {
                return .onePair
            }

            if uniques.count == 5 {
                return .highCard
            }

            assert(true, "failed \(cards)")
            fatalError()
        }
    }

    struct CamelCards {
        let hands: [Hand]
        let strengths: [Character] = [
            "A", "K", "Q", "J", "T", "9", "8", "7", "6", "5", "4", "3", "2", "J",
        ].compactMap { $0.first }.reversed()
        let rankedKinds: [Hand.Kind] = Hand.Kind.allCases.reversed()

        func secondOrderRule(for h1: Hand, _ h2: Hand) -> Bool {
            var result: Bool = false
            for (c1, c2) in zip(h1.cards, h2.cards) {
                let s1 = strengths.firstIndex(of: c1)!
                let d1 = strengths.distance(from: strengths.startIndex, to: s1)
                let s2 = strengths.firstIndex(of: c2)!
                let d2 = strengths.distance(from: strengths.startIndex, to: s2)

                if d1 > d2 {
                    result = false
                    break
                }
                else if d1 < d2 {
                    result = true
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

                guard hand.count != 0 else { continue }

                if hand.count == 1 {
                    orderedHands.append(hand[0])
                }
                else {
                    hand = hand.sorted { h1, h2 in
                        secondOrderRule(for: h1, h2)
                    }
                    orderedHands.append(contentsOf: hand)
                }
            }
            var total = 0
            for (i, hand) in orderedHands.enumerated() {
                total += hand.bid * (i + 1)
            }
            return total
        }
    }

    func parse() -> CamelCards {
        var hands: [Hand] = []
        for line in input {
            let com = line.components(separatedBy: " ")
            hands.append(Hand.init(cards: com[0].map { $0 }, bid: Int(com[1])!))
        }
        return CamelCards(hands: hands)
    }

    func part1() -> Any {
        parse().totalWinings()
    }

    func part2() -> Any {
        parse().totalWinings(includeJoker: true)
    }
}
