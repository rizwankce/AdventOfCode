import Algorithms

struct Day04: AdventDay {
    var data: String

    var input: [String] {
        data.lines
    }

    struct Card {
        let id: Int
        let wins: [Int]
        let haves: [Int]
        var count = 1

        init(_ line: String) {
            //Card 1: 41 48 83 86 17 | 83 86  6 31 17  9 48 53
            let com = line.components(separatedBy: ": ")
            let nums = com[1].components(separatedBy: " | ")
            self.id = com[0].numbers.first!
            self.wins = nums[0].numbers
            self.haves = nums[1].numbers
        }

        func point() -> Int {
            let count = matches()
            var point = 0
            (0..<count).forEach { _ in
                if point == 0 {
                    point = 1
                }
                else {
                    point = point * 2
                }
            }
            return point
        }

        func matches() -> Int {
            wins.filter { haves.contains($0) }.count
        }
    }

    func parse() -> [Card] {
        input.map { Card($0) }
    }

    func part1() -> Any {
        return parse().map { $0.point() }.reduce(0, +)
    }

    func part2() -> Any {
        var cards = parse()
        var index = 0

        while index < cards.count {
            let card = cards[index]
            let match = card.matches()

            if match > 0 {
                for _ in 1...card.count {
                    for id in card.id..<card.id + match {
                        cards[id].count += 1
                    }
                }
            }

            index += 1
        }

        return cards.map { $0.count }.reduce(0, +)
    }
}
