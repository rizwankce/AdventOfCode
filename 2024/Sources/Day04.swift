import Algorithms

struct Day04: AdventDay {
  typealias Grid = Grid2d<Character>

  var data: String

  var grid: Grid {
    Grid(data.lines)
  }

  enum Direction: CaseIterable {
    case right, left, up, down
    case diagonalRightUp, diagonalRightDown
    case diagonalLeftUp, diagonalLeftDown

    func getPoints(from start: Point, count: Int) -> [Point] {
      (1...count).map { step in
        switch self {
        case .right:
          Point(x: start.x + step, y: start.y)
        case .left:
          Point(x: start.x - step, y: start.y)
        case .up:
          Point(x: start.x, y: start.y - step)
        case .down:
          Point(x: start.x, y: start.y + step)
        case .diagonalRightUp:
          Point(x: start.x + step, y: start.y - step)
        case .diagonalRightDown:
          Point(x: start.x + step, y: start.y + step)
        case .diagonalLeftUp:
          Point(x: start.x - step, y: start.y - step)
        case .diagonalLeftDown:
          Point(x: start.x - step, y: start.y + step)
        }
      }
    }
  }

  func count(from start: Point) -> Int {
    func isXmas(points: [Point]) -> Bool {
      points
        .compactMap { grid[$0] }
        .map(String.init)
        .joined() == "MAS"
    }

    var count = 0
    let directions: [Direction] = Direction.allCases

    for direction in directions {
      if isXmas(points: direction.getPoints(from: start, count: 3)) {
        count += 1
      }
    }

    return count
  }

  func part1() -> Any {
    var result = 0
    for r in (0..<grid.rowCount) {
      for c in (0..<grid.colCount) {
        let p = Point(x: c, y: r)
        if grid[p] == "X" {
          result += count(from: p)
        }
      }
    }
    return result
  }

  func isValidXmasPattern(from start: Point) -> Bool {
    var valid = false
    let dR = [
      Point(x: start.x - 1, y: start.y - 1),
      Point(x: start.x, y: start.y),
      Point(x: start.x + 1, y: start.y + 1),
    ]
    let dL = [
      Point(x: start.x + 1, y: start.y - 1),
      Point(x: start.x, y: start.y),
      Point(x: start.x - 1, y: start.y + 1),
    ]

    let v1 = dR.compactMap { grid[$0] }.map { String($0) }.joined()
    let v2 = dL.compactMap { grid[$0] }.map { String($0) }.joined()

    if (v1 == "MAS" || v1 == "SAM") && (v2 == "MAS" || v2 == "SAM") {
      valid = true
    }

    return valid
  }

  func part2() -> Any {
    var result = 0
    for r in (0..<grid.rowCount) {
      for c in (0..<grid.colCount) {
        let p = Point(x: c, y: r)
        if grid[p] == "A" {
          result += isValidXmasPattern(from: p) ? 1 : 0
        }
      }
    }
    return result
  }
}
