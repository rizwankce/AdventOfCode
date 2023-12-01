import Algorithms

struct Day01: AdventDay {
    var data: String

    var input: [String.SubSequence] {
        data.split(separator: "\n")
    }

    var entities: [[Int]] {
        data.split(separator: "\n\n").map {
            $0.split(separator: "\n").compactMap { Int($0) }
        }
    }

    func part1() -> Any {
        input
            .map { $0.filter { $0.isNumber } }
            .map {
                if $0.count == 1 {
                    return $0 + $0
                }
                return "\($0.first!)\($0.last!)"
            }
            .compactMap { Int($0) }
            .reduce(0, +)
    }

    func part2() -> Any {
        let numbers = [
            "one": 1, "two": 2, "three": 3, "four": 4, "five": 5, "six": 6, "seven": 7, "eight": 8,
            "nine": 9,
        ]
        var values: [String.SubSequence] = []
        func feed(_ char: String.Element, _ cur: [String.Element]) -> Int? {
            if char.isNumber {
                return char.wholeNumberValue
            }

            for n in numbers.keys {
                if String(cur).contains(n) {
                    return numbers[n]
                }
            }

            return nil
        }

        for line in input {
            var first = 0
            var last = 0
            var cur: [String.Element] = []

            for i in line {
                cur.append(i)
                let r = feed(i, cur)
                if r != nil {
                    first = r!
                    cur.removeAll()
                    break
                }
            }

            for i in line.reversed() {
                cur.insert(i, at: 0)
                let r = feed(i, cur)
                if r != nil {
                    last = r!
                    cur.removeAll()
                    break
                }
            }
            values.append("\(first)\(last)")
        }
        return values.compactMap { Int($0) }.reduce(0, +)
    }
}
