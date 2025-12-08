import Algorithms

struct Day02: AdventDay {
  var data: String

  var entities: [(Int, Int)] {
    data.trimmingCharacters(in: .newlines).components(separatedBy: ",").map {
      let c = $0.components(separatedBy: "-").map { Int($0)! }
      return (c.first!, c.last!)
    }
  }

  func part1() -> Any {
    var ans = 0

    func isInValid(_ number: Int) -> Bool {
      let num = String(number)

      if num.count % 2 != 0 { return false }
      let mid = num.index(num.startIndex, offsetBy: num.count / 2)
      let first = num[num.startIndex..<mid]
      let last = num[mid..<num.endIndex]

      return first == last
    }

    entities.forEach { (a, b) in
      for i in a...b {
        if isInValid(i) {
          ans += i
        }
      }
    }

    return ans
  }

  func part2() -> Any {
    var ans = 0
    func isInValid(_ number: Int, _ spilt: Int) -> Bool {
      let num = String(number)
      let chunks = num.chunks(ofCount: spilt)
      return chunks.allSatisfy {
        $0 == chunks.first!
      }
    }

    entities.forEach { (a, b) in
      for i in a...b {
        inner: for j in 1..<String(i).count {
          if isInValid(i, j) {
            ans += i
            break inner
          }
        }
      }
    }

    return ans
  }
}
