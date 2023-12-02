import Algorithms

struct Day02: AdventDay {
    var data: String

    var input: [String] {
        data.lines
    }

    /*
     Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
     Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue
     Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red
     Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red
     Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green
     */

    struct Round {
        var red: Int
        var green: Int
        var blue: Int
    }

    struct Game {
        let id: Int
        var rounds: [Round]

        func isPossible() -> Bool {
            let r = 12
            let g = 13
            let b = 14

            var possible = true
            for round in rounds {
                if round.red > r || round.blue > b || round.green > g {
                    possible = false
                }
            }
            return possible
        }

        func power() -> Int {
            var r = 0
            var g = 0
            var b = 0
            for round in rounds {
                r = max(round.red, r)
                g = max(round.green, g)
                b = max(round.blue, b)
            }
            return r * g * b
        }
    }

    func parse() -> [Game] {
        var games: [Game] = []
        for line in input {
            let com = line.components(separatedBy: ": ")
            let id = Int(com[0].components(separatedBy: " ")[1])!
            let sets = com[1].components(separatedBy: "; ")
            var rounds: [Round] = []
            for set in sets {
                //1 red, 2 green, 6 blue
                let cubes = set.components(separatedBy: ", ")
                var round: Round = Round(red: 0, green: 0, blue: 0)
                for cube in cubes {
                    let c = cube.components(separatedBy: " ")
                    switch c[1] {
                    case "red": round.red = Int(c[0])!
                    case "green": round.green = Int(c[0])!
                    case "blue": round.blue = Int(c[0])!
                    default: fatalError("unknown")
                    }
                }
                rounds.append(round)
            }
            games.append(Game(id: id, rounds: rounds))
        }
        return games
    }

    func part1() -> Any {
        parse()
            .filter { $0.isPossible() }
            .map { $0.id }
            .reduce(0, +)
    }

    func part2() -> Any {
        parse()
            .map { $0.power() }
            .reduce(0, +)
    }
}
