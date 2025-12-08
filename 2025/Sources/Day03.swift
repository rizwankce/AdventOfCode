import Algorithms

struct Day03: AdventDay {
  var data: String

  var entities: [[Int]] {
    data.trimmingCharacters(in: .newlines)
      .components(separatedBy: .newlines)
      .map { $0.map { Int(String($0))! } }
  }

  func largestJoltage(_ bank: [Int], _ limit: Int) -> Int {
    struct State: Hashable {
      var cur: [Int]
      var nxt: [Int]

      init(_ cur: [Int], _ nxt: [Int]) {
        self.cur = cur
        self.nxt = nxt
      }

      func number() -> Int {
        if cur.isEmpty {
          return 0
        }
        return Int(cur.map { String($0) }.joined())!
      }

      func nxtNumber() -> Double {
        if nxt.isEmpty {
          return 0
        }
        return Double(nxt.map { String($0) }.joined())!
      }
    }

    var q: [State] = []
    q.append(State([], bank))
    var max = 0
    while !q.isEmpty {
      let state = q.removeFirst()

      // condition
      if state.number() < max {
        continue
      }

      // find nexts
      let rem = state.nxt

      for i in 0..<rem.count {
        let nxt = rem.dropFirst(i)
        let nState = State(state.cur + [rem[i]], Array(nxt.dropFirst()))
        if nState.cur.count + nState.nxt.count >= limit && nState.cur.count <= limit
          && nState.number() > max
        {
          max = nState.number()
          q.append(nState)
        }
      }
    }
    return max
  }

  func part1() -> Any {
    entities.map { largestJoltage($0, 2) }.reduce(0, +)
  }

  func part2() -> Any {
    entities.map { largestJoltage($0, 12) }.reduce(0, +)
  }
}
