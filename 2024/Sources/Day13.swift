import Algorithms
import RegexBuilder

struct Day13: AdventDay {
  var data: String

  /*
     Button A: X+94, Y+34
     Button B: X+22, Y+67
     Prize: X=8400, Y=5400

     94a+22b=8400
     34a+67b=5400
     */

  struct Game: CustomStringConvertible {
    let a: Point
    let b: Point
    let prize: Point

    var description: String {
      "A: \(a) B: \(b) Prize: \(prize)"
    }

    func solve2() -> Int? {
      let m = (prize.y * a.x - prize.x * a.y)
      let n = (b.y * a.x - b.x * a.y)

      guard m % n == 0 else { return nil }

      let bCount = m / n
      let aCount = (prize.x - bCount * b.x) / a.x

      return aCount * 3 + bCount
    }

    func solve1() -> Int? {
      var ans: Int? = nil
      outer: for x in 0...100 {
        for y in 0...100 {
          if (prize.x == (a.x * x) + (b.x * y)) && (prize.y == (a.y * x) + (b.y * y)) {
            ans = x * 3 + y * 1
            break outer
          }
        }
      }
      return ans
    }
  }

  func getGames(_ isError: Bool = false) -> [Game] {
    let regex = Regex {
      "X+"
      Capture {
        OneOrMore(.digit)
      }
      /./
      " Y+"
      Capture {
        OneOrMore(.digit)
      }
    }
    .anchorsMatchLineEndings()

    let priceRegex = Regex {
      "X="
      Capture {
        OneOrMore(.digit)
      }
      /./
      " Y="
      Capture {
        OneOrMore(.digit)
      }
    }
    .anchorsMatchLineEndings()

    let com = data.components(separatedBy: "\n\n")
    var games: [Game] = []
    for c in com {
      let p = c.components(separatedBy: .newlines)
      //print(p)
      var a: Point?
      var b: Point?
      var prize: Point?
      for line in p {
        if line.contains("A: ") {
          if let output = line.firstMatch(of: regex) {
            a = Point(x: Int(output.1)!, y: Int(output.2)!)
          }
        }
        if line.contains("B: ") {
          if let output = line.firstMatch(of: regex) {
            b = Point(x: Int(output.1)!, y: Int(output.2)!)
          }
        }

        if line.contains("Prize: ") {
          if let output = line.firstMatch(of: priceRegex) {
            if isError {
              prize = Point(
                x: Int(output.1)! + 10_000_000_000_000, y: Int(output.2)! + 10_000_000_000_000)
            } else {
              prize = Point(x: Int(output.1)!, y: Int(output.2)!)
            }
          }
        }
      }
      //print(a,b,prize)
      if let a, let b, let prize {
        games.append(Game(a: a, b: b, prize: prize))
      }
    }
    return games
  }

  func part1() -> Any {
    getGames().compactMap { $0.solve1() }.reduce(0, +)
  }

  func part2() -> Any {
    getGames(true).compactMap { $0.solve2() }.reduce(0, +)
  }
}
