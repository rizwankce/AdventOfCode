import Algorithms

struct Day19: AdventDay {
  var data: String

  class TowelArranger {
    let patterns: [String]
    let designs: [String]
    var dp: [String: Bool] = [:]
    var dp2: [String: Int] = [:]

    init(_ data: String) {
      let com = data.components(separatedBy: "\n\n")
      self.patterns = com[0].components(separatedBy: ", ")
      self.designs = com[1].components(separatedBy: "\n").filter { !$0.isEmpty }
    }

    func backtrack(_ design: String) -> Bool {
      if dp[design] != nil {
        return dp[design]!
      }

      if design.isEmpty {
        return true
      }

      var news: Set<String> = []
      for pattern in patterns {
        if design.hasPrefix(pattern) {
          let new = design.dropFirst(pattern.count)
          news.insert(String(new))
        }
      }

      var result = false
      if !news.isEmpty {
        var all: [Bool] = []
        for new in news {
          all.append(backtrack(new))
        }
        result = all.contains(true) ? true : false
      }
      dp[design] = result
      return result
    }

    func count(_ design: String) -> Int {
      if dp2[design] != nil {
        return dp2[design]!
      }

      if design.isEmpty {
        return 1
      }

      var news: Set<String> = []
      for pattern in patterns {
        if design.hasPrefix(pattern) {
          let new = design.dropFirst(pattern.count)
          news.insert(String(new))
        }
      }

      var result = 0
      if !news.isEmpty {
        var all: [Int] = []
        for new in news {
          all.append(count(new))
        }
        result = all.reduce(0, +)
      }
      dp2[design] = result
      return result
    }

    func validDesigns() -> Int {
      designs.filter(backtrack).count
    }

    func allPossibleValidDesigns() -> Int {
      designs.filter(backtrack).map { count($0) }.reduce(0, +)
    }
  }

  func part1() -> Any {
    TowelArranger(data).validDesigns()
  }

  func part2() -> Any {
    TowelArranger(data).allPossibleValidDesigns()
  }
}
