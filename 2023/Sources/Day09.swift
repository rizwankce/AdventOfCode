import Algorithms

struct Day09: AdventDay {
    var data: String

    var input: [String] {
        data.lines
    }

    func extrapolate(_ numbers: [Int], fromStart: Bool = false) -> Int {
        var pyramid: [[Int]] = []
        var cur = numbers
        while true {
            let next: [Int] = cur.adjacentPairs().map { $0.1 - $0.0 }
            if next.allSatisfy({ $0 == 0 }) {
                break
            }
            cur = next
            pyramid.append(next)
        }

        var next = 0
        for num in pyramid.reversed() {
            if fromStart {
                next = num.first! - next
            }
            else {
                next = next + num.last!
            }
        }

        return fromStart ? numbers.first! - next : next + numbers.last!
    }

    func parse() -> [[Int]] {
        input.map { $0.numbers }
    }

    func part1() -> Any {
        parse().map { extrapolate($0) }.reduce(0, +)
    }

    func part2() -> Any {
        parse().map { extrapolate($0, fromStart: true) }.reduce(0, +)
    }
}
