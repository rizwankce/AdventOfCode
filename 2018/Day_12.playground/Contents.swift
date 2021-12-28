import Cocoa
import Foundation

let input = """
initial state: #...#####.#..##...##...#.##.#.##.###..##.##.#.#..#...###..####.#.....#..##..#.##......#####..####...

#.#.# => #
..### => .
#..#. => #
.#... => #
..##. => #
##.#. => #
##..# => #
####. => #
...#. => #
..#.# => #
.#### => #
#.### => .
...## => .
..#.. => .
#...# => .
.###. => #
.#.## => .
.##.. => #
....# => .
#..## => .
##.## => #
#.##. => .
#.... => .
##... => #
.#.#. => .
###.# => #
##### => #
#.#.. => .
..... => .
.##.# => .
###.. => .
.#..# => .
""".components(separatedBy: "\n\n")

//print(input)

struct Rule: CustomStringConvertible {
    let left: [Character]
    let right: Character
    let line: String

    init(_ line: String) {
        let com = line.components(separatedBy: " => ")
        self.line = line
        self.left = com[0].map { $0 }
        self.right = com[1].first!
    }

    func verify(_ given: [Character]) -> Bool {
        given == left
    }

    var description: String {
        line
    }
}

let pots = input[0].components(separatedBy: " ")[2].map { $0 }
let rules = input[1].components(separatedBy: .newlines).map { Rule.init($0) }

func tick(_ pots: [Int: Character]) -> [Int: Character] {
    let minX = pots.keys.min()!
    let maxX = pots.keys.max()!
    var new: [Int: Character] = [:]
    var index = minX - 4
    while index < maxX + 4 {
        let chunk = (index ..< index+5).map { pots[$0, default: "."] }
        for rule in rules {
            if rule.verify(chunk) {
                let j = index+2
                if rule.right == "#" {
                    new[j] = rule.right
                }
            }
        }
        index += 1
    }

    return new
}

func partOne() -> Int {
    var next: [Int: Character] = [:]
    for (i,c) in pots.enumerated() {
        next[i] = c
    }

    for _ in 1...20 {
        next = tick(next)
    }

    return next.keys.reduce(0, +)
}

func partTwo() -> Int {
    var next: [Int: Character] = [:]
    for (i,c) in pots.enumerated() {
        next[i] = c
    }

    for _ in 1...150 {
        next = tick(next)
    }
    var result = next.keys.reduce(0, +)
    result += (50000000000 - 150)*86
    return result
}

print("Part 1 answer is \(partOne())")
print("Part 2 answer is \(partTwo())")
