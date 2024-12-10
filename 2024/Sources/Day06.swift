import Algorithms

struct Day06: AdventDay {
  typealias Grid = Grid2d<Character>

  var data: String

  var grid: Grid {
    Grid(data.lines)
  }

  func getStartAndPath() -> (Point, Set<Point>) {
    var start = Point(x: 0, y: 0)
    outer: for r in (0..<grid.rowCount) {
      for c in (0..<grid.colCount) {
        let p = Point(x: c, y: r)
        if grid[p] == "^" {
          start = p
          break outer
        }
      }
    }

    var visited: Set<Point> = [start]
    var direction: Direction = .north
    var cur = start
    while true {
      let newP = cur.moved(1, direction)
      guard grid[newP] != nil else {
        break
      }
      if grid[newP] == "#" {
        direction.turn(90, .right)
      } else {
        visited.insert(newP)
        cur = newP
      }
    }
    return (start, visited)
  }

  func part1() -> Any {
    getStartAndPath().1.count
  }

  func isLoop(_ g: Grid, start: Point, block: Point) -> Bool {
    g[block] = "%"
    var visited: [Point] = [start]
    var path: Set<Point> = [start]
    var direction: Direction = .north
    var isLoop = false
    while true {
      let newP = visited.last!.moved(1, direction)
      guard g[newP] != nil else {
        break
      }

      if visited.count / 2 == path.count {
        isLoop = true
        break
      }

      if g[newP] == "#" || g[newP] == "%" {
        direction.turn(90, .right)
      } else {
        visited.append(newP)
        path.insert(newP)
      }
    }
    return isLoop
  }

  func printG(_ points: [Point]) {
    let g = grid
    points.forEach { g[$0] = "X" }
    print(g)
  }

  func part2() -> Any {
    let result = getStartAndPath()
    let start = result.0
    let path = result.1
    return path.filter { isLoop(grid, start: start, block: $0) }.count
  }
}
