import Algorithms

struct Day05: AdventDay {
  var data: String

  var input: ([ClosedRange<Int>], [Int]) {
    let com = data.components(separatedBy: "\n\n")
    let ranges: [ClosedRange<Int>] = com[0]
      .components(separatedBy: .newlines)
      .map {
        let c = $0.components(separatedBy: "-").map { Int($0)! }
        return c[0]...c[1]
      }
    return (
      ranges,
      com[1].trimmingCharacters(in: .newlines)
        .components(separatedBy: .newlines).map { Int($0)! }
    )
  }

  func part1() -> Any {
    var ans = 0
    for ing in input.1 {
      inner: for range in input.0 {
        if range.contains(ing) {
          ans += 1
          break inner
        }
      }
    }
    return ans
  }

  func mergeAll(_ ranges: [ClosedRange<Int>]) -> [ClosedRange<Int>] {
    let sorted = ranges.sorted { $0.lowerBound < $1.lowerBound }
    var result: [ClosedRange<Int>] = []
    var current = sorted.first!

    for range in sorted.dropFirst() {
      if current.upperBound >= range.lowerBound - 1 {
        current = current.lowerBound...max(current.upperBound, range.upperBound)
      } else {
        result.append(current)
        current = range
      }
    }
    result.append(current)
    return result
  }

  func part2() -> Any {
    mergeAll(input.0).map { $0.upperBound - $0.lowerBound + 1 }.reduce(0, +)
  }
}
