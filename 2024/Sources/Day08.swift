import Algorithms
import Foundation

struct Day08: AdventDay {
  typealias Grid = Grid2d<Character>

  var data: String

  var grid: Grid {
    Grid(data.lines)
  }

  var antennas: [Character: [Point]] {
    var all: [Character: [Point]] = [:]
    for r in (0..<grid.rowCount) {
      for c in (0..<grid.colCount) {
        let p = Point(x: c, y: r)
        if grid[p] != "." {
          all[grid[p]!, default: []].append(p)
        }
      }
    }
    return all
  }

  func getAntitodesCount(_ extendes: Bool = false) -> Int {
    let grid = grid
    func dPoints(_ a: Point, _ b: Point, _ step: Int) -> Point {
      let dx = max(a.x, b.x) - min(a.x, b.x)
      let dy = max(a.y, b.y) - min(a.y, b.y)
      return Point(
        x: a.x + (a.x > b.x ? dx : -dx) * step,
        y: a.y + (a.y > b.y ? dy : -dy) * step
      )
    }

    var antiodes: [Point] = []
    for v in antennas.values {
      for pair in v.combinations(ofCount: 2) {
        let a = pair.first!
        let b = pair.last!
        if extendes {
          antiodes.append(contentsOf: pair)
          inner: for s in 1... {
            var found = false
            let nx = dPoints(a, b, s)
            let ny = dPoints(b, a, s)
            if grid.isValid(nx) {
              antiodes.append(nx)
              found = true
            }
            if grid.isValid(ny) {
              antiodes.append(ny)
              found = true
            }

            if !found {
              break inner
            }
          }
        } else {
          let nx = dPoints(a, b, 1)
          let ny = dPoints(b, a, 1)
          if grid.isValid(nx) {
            antiodes.append(nx)

          }
          if grid.isValid(ny) {
            antiodes.append(ny)
          }
        }
      }
    }
    return antiodes.uniques.count
  }

  func part1() -> Any {
    getAntitodesCount()
  }

  func part2() -> Any {
    getAntitodesCount(true)
  }

  func printG(_ ps: [Point]) {
    let copy = grid
    ps.forEach({ copy[$0] = "#" })
    print(copy)
  }
}
