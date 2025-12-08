import Algorithms

struct Day04: AdventDay {
  var data: String

  var entities: Grid2d<Character> {
    Grid2d(data.components(separatedBy: .newlines))
  }

  func remove(_ grid: Grid2d<Character>) -> Set<Point> {
    var all: Set<Point> = []
    for point in grid.grid.keys {
      if grid[point] == "@" {
        let neighbors = grid.neighbours(point).filter { grid.isValid($0) }

        if neighbors.map({ grid[$0] })
          .filter({ $0 == "@" }).count < 4
        {
          all.insert(point)
        }
      }
    }
    return all
  }

  func part1() -> Any {
    remove(entities).count
  }

  func part2() -> Any {
    let grid = entities
    var ans = 0
    while true {
      let points = remove(grid)
      ans += points.count
      points.forEach { grid[$0] = "x" }

      if points.isEmpty {
        break
      }
    }
    return ans
  }
}
