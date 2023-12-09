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
            var next: [Int] = []
            for pair in cur.adjacentPairs() {
                next.append(pair.1 - pair.0)
            }
            pyramid.append(next)
            if next.allSatisfy({ $0 == 0 }) {
                break
            }
            cur = next
        }

        var next = 0
        for pair in pyramid.reversed().adjacentPairs() {
            let prev = pair.1
            if fromStart {
                next = prev.first! - next
            }
            else {
                next = next + prev.last!
            }
        }
        return fromStart ? numbers.first! - next : next + numbers.last!
    }

    func parse() -> [[Int]] {
        var numbersArray: [[Int]] = []
        for line in input {
            numbersArray.append(line.numbers)
        }
        return numbersArray
    }

    func part1() -> Any {
        parse().map { extrapolate($0) }.reduce(0, +)
    }

    func part2() -> Any {
        parse().map { extrapolate($0, fromStart: true) }.reduce(0, +)
    }
}
