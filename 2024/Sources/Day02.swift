import Algorithms

struct Day02: AdventDay {
  var data: String

  var input: [[Int]] {
    data.lines.map { line in
      line.components(separatedBy: " ").compactMap { Int($0) }
    }
  }

  enum LevelDirection {
    case increase
    case decrease
    case none
  }

  func isSafe(_ level: [Int]) -> Bool {
    var direction: LevelDirection = .none

    for (cur, next) in zip(level, level.dropFirst()) {
      guard [1, 2, 3].contains(abs(cur - next)) else {
        return false
      }

      if cur > next {
        if direction == .increase {
          return false
        }
        direction = .decrease
      } else if cur < next {
        if direction == .decrease {
          return false
        }
        direction = .increase
      }
    }
    return true
  }

  func part1() -> Any {
    input.filter { isSafe($0) }.count
  }

  func part2() -> Any {
    var result = 0

    for levels in input {
      if isSafe(levels) {
        result += 1
      } else {
        for index in 0..<levels.count {
          var cur = levels
          cur.remove(at: index)
          if isSafe(cur) {
            result += 1
            break
          }
        }
      }
    }
    return result
  }
}
