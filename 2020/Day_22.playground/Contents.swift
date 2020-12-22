import Cocoa

let input = """
Player 1:
31
24
5
33
7
12
30
22
48
14
16
26
18
45
4
42
25
20
46
21
40
38
34
17
50

Player 2:
1
3
41
8
37
35
28
39
43
29
10
27
11
36
49
32
2
23
19
9
13
15
47
6
44
""".components(separatedBy: "\n\n")

print(input)

func partOne() -> Int {
    var player1: [Int] = input[0].components(separatedBy: .newlines).compactMap{Int($0)}
    var player2: [Int] = input[1].components(separatedBy: .newlines).compactMap{Int($0)}

    var index = 0

    while true {
        index += 1
        let p1 = player1.first!
        let p2 = player2.first!
        player1 = Array(player1.dropFirst())
        player2 = Array(player2.dropFirst())

        if p1 > p2 {
            player1.append(contentsOf: [p1,p2])
        }
        else {
            player2.append(contentsOf: [p2,p1])
        }

        if player1.isEmpty || player2.isEmpty {
            break
        }
    }

    let winner = player1.isEmpty ? player2 : player1

    var ans = 0

    for (i,x) in winner.reversed().enumerated() {
        ans += ((i+1)*x)
    }

    return ans
}

func partTwo() -> Int {
    let player1: [Int] = input[0].components(separatedBy: .newlines).compactMap{Int($0)}
    let player2: [Int] = input[1].components(separatedBy: .newlines).compactMap{Int($0)}

    var w1: [Int] = []
    var w2: [Int] = []

    struct Deck: Hashable {
        var p1: [Int]
        var p2: [Int]
    }

    func play(_ p1: [Int],_ p2: [Int]) -> (Bool,Bool) {
        var p1 = p1
        var p2 = p2
        var visited: Set<Deck> = []
        var index = 0
        while true {
            index += 1

            let deck = Deck.init(p1: p1, p2: p2)
            if visited.contains(deck) {
                return (true, false)
            }
            visited.insert(deck)

            let pl1 = p1.first!
            let pl2 = p2.first!
            p1 = Array(p1.dropFirst())
            p2 = Array(p2.dropFirst())

            var result: (Bool, Bool) = (false,false)
            if pl1 <= p1.count && pl2 <= p2.count {
                let newP1 = Array(p1[0..<pl1])
                let newP2 = Array(p2[0..<pl2])
                result = play(newP1,newP2)
            }
            else {
                if pl1 > pl2 {
                    result = (true, false)
                }
                else {
                    result = (false, true)
                }
            }

            if result.0 {
                p1.append(contentsOf: [pl1,pl2])
            }
            else {
                p2.append(contentsOf: [pl2,pl1])
            }

            if p1.isEmpty || p2.isEmpty {
                break
            }
        }

        w1 = p1
        w2 = p2

        return p1.isEmpty ? (false,true) : (true, false)
    }

    let result = play(player1, player2)

    let winner = result.0 ? w1 : w2
    var ans = 0

    for (i,x) in winner.reversed().enumerated() {
        ans += ((i+1)*x)
    }

    return ans
}

print("Part One answer is: \(partOne())")
print("Part Two answer is: \(partTwo())")
