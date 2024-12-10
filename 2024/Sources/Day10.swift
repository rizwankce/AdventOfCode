import Algorithms

struct Day10: AdventDay {
  typealias Grid = Grid2d<Character>

  var data: String

  var grid: Grid {
    Grid(data.lines)
  }

  struct Map {
    let grid: Grid

    func startPoints() -> [Point] {
      var all: [Point] = []
      for r in (0..<grid.rowCount) {
        for c in (0..<grid.colCount) {
          let p = Point(x: c, y: r)
          if grid[p] == "0" {
            all.append(p)
          }
        }
      }
      return all
    }

    func score(from start: Point) -> Int {
      var queue: Set<Point> = [start]
      var tails: Set<Point> = []
      var score = 0

      while !queue.isEmpty {
        let cur = queue.removeFirst()
        let val = grid[cur]?.intValue()

        if val == 9 && !tails.contains(cur) {
          score += 1
          tails.insert(cur)
        }

        let next = cur.adjacent()
          .filter { !queue.contains($0) }
          .filter {
            if let v = grid[$0] {
              return v.intValue()! - 1 == val
            }
            return false
          }

        for n in next {
          queue.insert(n)
        }
      }
      return score
    }

    func score() -> Int {
      startPoints().map { score(from: $0) }.reduce(0, +)
    }

    func ratings(from start: Point) -> Int {
      var queue: [Point] = [start]
      var ratings = 0

      while !queue.isEmpty {
        let cur = queue.removeFirst()
        let val = grid[cur]?.intValue()

        if val == 9 {
          ratings += 1
        }

        let next = cur.adjacent()
          .filter {
            if let v = grid[$0], let n = v.intValue() {
              return n - 1 == val
            }
            return false
          }

        for n in next {
          queue.append(n)
        }
      }

      return ratings
    }

    func ratings() -> Int {
      startPoints().map { ratings(from: $0) }.reduce(0, +)
    }
  }

  func part1() -> Any {
    Map(grid: grid).score()
  }

  func part2() -> Any {
    Map(grid: grid).ratings()
  }
}
