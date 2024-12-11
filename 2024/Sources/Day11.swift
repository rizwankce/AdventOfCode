import Algorithms
import Foundation

struct Day11: AdventDay {
  var data: String

  var input: [Int] {
    data.numbers
  }

  func part1() -> Any {
    var dict: [Int: Int] = [:]
    for (i, v) in input.enumerated() {
      dict[i] = v
    }

    func printDict() {
      var str = ""
      for i in 0..<dict.keys.count {
        str += " " + String(dict[i]!)
      }
    }

    for _ in 0...24 {
      var nextDict: [Int: Int] = [:]
      var z = 0
      for j in 0..<dict.keys.count {
        let cur = dict[j]
        let curString = String(cur!)

        if curString == "0" {
          nextDict[z] = 1
        } else if curString.count % 2 == 0 {
          let pair = split(cur!)
          nextDict[z] = pair.0
          nextDict[z + 1] = pair.1
          z += 1
        } else {
          nextDict[z] = cur! * 2024
        }
        z += 1
      }
      dict = nextDict
    }

    return dict.keys.count
  }

  func split(_ number: Int) -> (Int, Int) {
    let curString = String(number)
    let left = curString[
      curString.startIndex..<curString.index(curString.startIndex, offsetBy: curString.count / 2)]
    let right = curString[
      curString.index(curString.startIndex, offsetBy: curString.count / 2)..<curString.endIndex]
    let leftInt = Int(String(left))!
    let rightInt = Int(String(right))!
    return (leftInt, rightInt)
  }

  func part2() -> Any {
    struct StoneMap: Hashable {
      let rock: Int
      let step: Int

      init(_ rock: Int, _ step: Int) {
        self.rock = rock
        self.step = step
      }
    }

    var dict: [StoneMap: Int] = [:]

    func blink(_ stone: StoneMap) -> Int {
      if dict[stone] != nil {
        return dict[stone]!
      }

      var result = 0
      let number = stone.rock
      let step = stone.step

      if step == 0 {
        result = 1
      } else if number == 0 {
        result = blink(StoneMap(1, step - 1))
      } else if String(number).count % 2 == 0 {
        let pair = split(number)
        result = blink(StoneMap(pair.0, step - 1)) + blink(StoneMap(pair.1, step - 1))
      } else {
        result = blink(StoneMap(number * 2024, step - 1))
      }

      dict[stone] = result
      return result
    }

    return input.map { blink(StoneMap($0, 75)) }.reduce(0, +)
  }
}
