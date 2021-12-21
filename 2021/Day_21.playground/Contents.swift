import Cocoa

let input = load(.input, runFromTerminal:false).trimmingCharacters(in: .newlines).components(separatedBy: .newlines)

extension String {
    var numbers: [Int] {
        split(whereSeparator: { "-0123456789".contains($0) == false })
            .map { Int($0)! }
    }
}

let numbers = input.map { $0.numbers }

let p1 = numbers[0]
let p2 = numbers[1]
var s1 = p1[1]
var s2 = p2[1]


func partOne() -> Int {
    var players: [Int: Int] = [:]
    players[0] = s1
    players[1] = s2

    var scores: [Int: Int] = [:]
    scores[0] = 0
    scores[1] = 0

    var die: Int = 0
    var dieRolled: Int = 0
    func roll() -> [Int] {
        (1...3).map { _ -> Int in
            dieRolled += 1
            die = die + 1
            if die > 100 {
                die = 1
            }
            return die
        }
    }

    var curp = 0
    var loserScore = 0

    while true {
        let r = roll()
        let s = players[curp]! + r.reduce(0, +)
        players[curp] = s > 10 ? (s % 10 == 0 ? 10 : s % 10)  : s
        scores[curp] = scores[curp]! + players[curp]!

        if scores[curp]! >= 1000 {
            let loser = curp == 0 ? 1 : 0
            loserScore = scores[loser]!
            break
        }

        curp = curp == 0 ? 1 : 0
    }

    return dieRolled * loserScore
}

func partTwo() -> Int {
    struct Player: Hashable {
        var position: Int
        var score: Int

        init(position: Int, score: Int) {
            self.position = position
            self.score = score
        }
    }

    struct Universe: Hashable {
        var p1: Player
        var p2: Player

        init(_ p1: Int, _ p2: Int, _ s1: Int, _ s2: Int) {
            self.p1 = Player.init(position: p1, score: s1)
            self.p2 = Player.init(position: p2, score: s2)
        }

        init(_ p1: Player, _ p2: Player) {
            self.p1 = p1
            self.p2 = p2
        }
    }

    var universes: [Universe: (Int,Int)] = [:]

    func play(_ uni: Universe) -> (Int,Int) {
        if uni.p1.score >= 21 {
            return (1,0)
        }

        if uni.p2.score >= 21 {
            return (0,1)
        }

        if universes.keys.contains(uni) {
            return universes[uni]!
        }

        var winner: (Int, Int) = (0,0)
        for r1 in [1,2,3] {
            for r2 in [1,2,3] {
                for r3 in [1,2,3] {
                    let newP1 = (uni.p1.position + r1 + r2 + r3) % 10
                    let newS1 = uni.p1.score + (newP1 == 0 ? 10 : newP1)

                    let nextP1 = Player(position: uni.p2.position, score: uni.p2.score)
                    let nextP2 = Player(position:newP1, score: newS1)
                    let nextUni = Universe(nextP1, nextP2)
                    let pair = play(nextUni)
                    winner = (winner.0 + pair.1, winner.1 + pair.0)
                }
            }
        }

        universes[uni] = winner
        return winner
    }

    let playerOne = Player(position: p1[1], score: 0)
    let playerTwo = Player(position: p2[1], score: 0)
    let universe = Universe(playerOne,playerTwo)
    let winner = play(universe)

    return max(winner.0, winner.1)
}

print("Part One answer is: \(partOne())")
print("Part Two answer is: \(partTwo())")

enum PuzzleInput: String {
    case input = "input"
    case test  = "test_input"
}

func load(_ input: PuzzleInput, runFromTerminal: Bool = false) -> String {
    switch input {
    case .input:
        return load(file: "input", runFromTerminal)
    default:
        return load(file: "test_input", runFromTerminal)
    }
}

func load(file name: String, _ runFromTerminal: Bool = false) -> String {

    if runFromTerminal {
        let projectURL = URL(fileURLWithPath: #file)
                .deletingLastPathComponent()
                .appendingPathComponent("Resources")
        let fileURL = projectURL.appendingPathComponent(name+".txt")
        guard let content = try? String(contentsOf: fileURL, encoding: .utf8) else {
            fatalError("Cannot convert file contents to string for file :\(name)")
        }

        return content
    }

    guard let url = Bundle.main.url(forResource: name, withExtension: "txt") else {
        fatalError("Cannot load file with name :\(name)")
    }

    guard let content = try? String(contentsOf: url, encoding: .utf8) else {
        fatalError("Cannot convert file contents to string for file :\(name)")
    }

    return content
}
