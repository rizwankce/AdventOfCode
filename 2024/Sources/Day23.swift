import Algorithms

struct Day23: AdventDay {
  var data: String

  struct LanParty {
    var map: [String: [String]] = [:]

    init(_ data: String) {
      for line in data.lines {
        let com = line.components(separatedBy: "-")
        self.map[com[0], default: []].append(com[1])
        self.map[com[1], default: []].append(com[0])
      }
    }

    func interconnected(_ computer: String, _ count: Int) -> [[String]] {
      var queue: [(String, [String], Int)] = [(computer, [], 0)]
      var result: [[String]] = []
      while !queue.isEmpty {
        let current = queue.removeFirst()
        let com = current.0
        let visited = current.1
        let depth = current.2

        if depth == count && com == computer {
          result.append(visited)
        }

        if let next = map[com] {
          if depth < count {
            for n in next {
              queue.append((n, visited + [com], depth + 1))
            }
          }
        }
      }

      return result
    }

    func countInterconnected(_ count: Int, _ start: String) -> Int {
      var ans = 0
      var all: Set<[String]> = []
      for computer in map.keys {
        let res = interconnected(computer, count)
        //print(res.map {$0.joined(separator: ",")})
        for visited in res {
          var visited = visited.sorted(by: <)
          assert(visited.count == count)
          var canAdd = false
          for visit in visited {
            if visit.starts(with: start) {
              canAdd = true
            }
          }
          if canAdd {
            all.insert(visited)
          }
        }
      }
      return all.count
    }

    func password2() -> String {
      var best = 0
      var pwd: [String] = []
      for i in 2...map.keys.count {
        print(i)
        for computer in map.keys {
          let current = interconnected(computer, i)

          for lan in current {
            if lan.count > best {
              pwd = lan
              print(pwd)
            }
          }
        }
      }

      return pwd.joined(separator: ",")
    }

    func password() -> String {
      var result: Set<[String]> = []

      for computer in map.keys {
        var queue: [(String, [String], Int)] = [(computer, [], 0)]
        var seen: Set<String> = []
        var best: Int = 0
        //print("Checking \(computer)")
        while !queue.isEmpty {
          let current = queue.removeLast()

          let com = current.0
          var visited = current.1
          let depth = current.2

          //                    if seen.contains(com) {
          //                        continue
          //                    }
          //                    seen.insert(com)

          if let next = map[com] {
            //print(next)
            //if depth >= best {
            for n in next {
              if n == computer && best < depth {
                print(current)

                best = depth
                visited = visited.sorted(by: <)
                result.insert(visited)
              }
              if n != computer && !visited.contains(n) {
                queue.append((n, visited + [com], depth + 1))
              }
            }
            //}
          }
        }
      }

      print(result)
      var best = 0
      var pwd: [String] = []
      for r in result {
        if r.count > best {
          best = r.count
          pwd = r
        }
      }

      return pwd.joined(separator: ",")
    }
  }

  func part1() -> Any {
    0
    //LanParty(data).countInterconnected(3,"t")
  }

  func part2() -> Any {
    LanParty(data).password2()
  }
}
