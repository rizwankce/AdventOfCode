import Algorithms

struct Day25: AdventDay {
  typealias Grid = Grid2d<Character>

  var data: String

  var input: [Grid] {
    data.components(separatedBy: "\n\n").map {
      Grid($0.lines)
    }
  }

  struct Schematics {
    enum SchematicsType {
      case lock
      case key
    }

    let points: Set<Point>
    let type: SchematicsType

    init(_ data: String) {
      let grid = Grid(data.lines)

      self.points = Set(grid.grid.keys.filter { grid[$0] == "#" })
      self.type = data.lines[0].contains { $0 == "#" } ? .lock : .key
    }

    func overlap(_ schematics: Schematics) -> Bool {
      points.intersection(schematics.points).count == 0
    }
  }

  func part1() -> Any {
    let schematics = data.components(separatedBy: "\n\n").map { Schematics($0) }
    let locks = schematics.filter({ $0.type == .lock })
    let keys = schematics.filter({ $0.type == .key })
    var ans = 0
    for (i, lock) in locks.enumerated() {
      for (j, key) in keys.enumerated() {
        if lock.overlap(key) {
          ans += 1
        }
      }
    }
    return ans
  }

  func part2() -> Any {
    return 0
  }
}
