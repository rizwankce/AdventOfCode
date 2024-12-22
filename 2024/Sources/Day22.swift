import Algorithms
import Foundation

struct Day22: AdventDay {
  var data: String

  var input: [Int] {
    data.lines.compactMap { Int($0) }
  }

  func evovles(_ number: Int) -> Int {
    var number = number
    var result = number * 64
    number = number ^ result
    number = number % 16_777_216
    //print(number)
    let dresult = Double(number) / Double(32)
    result = Int(dresult.rounded(.down))
    number = number ^ result
    number = number % 16_777_216
    //print(number)

    result = number * 2048
    number = number ^ result
    number = number % 16_777_216
    //print(number)

    return number
  }

  func evolve(_ number: Int, _ steps: Int) -> Int {
    var number = number
    for _ in 1...steps {
      number = evovles(number)
    }
    return number
  }

  func evolve2(_ number: Int, _ steps: Int) -> [Int] {
    var number = number
    var result: [Int] = [number % 10]
    for _ in 1...steps {
      number = evovles(number)
      result.append(number % 10)
    }
    return result
  }

  func part1() -> Any {
    input.map { evolve($0, 2000) }.reduce(0, +)
  }

  func part2() -> Any {
    struct State: Hashable, CustomStringConvertible {
      var description: String {
        "\(a),\(b),\(c),\(d)"
      }
      let a: Int
      let b: Int
      let c: Int
      let d: Int

      init(_ diff: [Int]) {
        assert(diff.count == 4)
        a = diff[0]
        b = diff[1]
        c = diff[2]
        d = diff[3]
      }
    }

    var score: [State: Int] = [:]
    for number in input {
      let result = evolve2(number, 2000)
      var diffs: [Int] = []

      for (i, j) in result.adjacentPairs() {
        diffs.append(j - i)
      }
      var search: [State: Int] = [:]
      for i in 0..<diffs.count - 3 {
        let state = State(Array(diffs[i...i + 3]))
        if !search.keys.contains(state) {
          search[state] = result[i + 4]
        }
      }

      for (k, v) in search {
        score[k, default: 0] += v
      }

    }

    return score.values.max()!
  }
}
