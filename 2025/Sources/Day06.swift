import Algorithms

struct Day06: AdventDay {
  var data: String

  var entities: [String] {
    data
      .trimmingCharacters(in: .newlines)
      .components(separatedBy: .newlines)
  }

  func part1() -> Any {
    let eqs = entities.dropLast().map { $0.numbers }
    let ops = entities.last!.split(whereSeparator: { "+*".contains($0) == false })
    var all = 0

    for i in 0..<ops.count {
      switch ops[i] {
      case "+":
        all += eqs.map { $0[i] }.reduce(0, +)
      case "*":
        all += eqs.map { $0[i] }.reduce(1, *)
      default:
        break
      }
    }

    return all
  }

  func part2() -> Any {
    let mtx = entities.dropLast().map { $0.map { String($0) } }
    let ops = entities.last!.split(whereSeparator: { "+*".contains($0) == false })
    var all = 0
    var cur = 0
    for i in 0..<ops.count {
      var eq: [Int] = []
      inner: while true {
        var left = ""
        for line in mtx {
          for (y, num) in line.enumerated() {
            if y == cur {
              left += num
            }
          }
        }
        left = left.replacingOccurrences(of: " ", with: "")
        cur += 1

        if left.isEmpty {
          break inner
        }
        eq.append(Int(left)!)
      }

      switch ops[i] {
      case "+":
        all += eq.reduce(0, +)
      case "*":
        all += eq.reduce(1, *)
      default:
        break
      }
    }
    return all
  }
}
