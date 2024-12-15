import Algorithms

struct Day15: AdventDay {
  typealias Grid = Grid2d<Character>

  var data: String

  func moved(_ p: Point, _ move: String.Element, _ step: Int) -> Point {
    switch move {
    case "^": return Point(x: p.x, y: p.y - step)
    case "v": return Point(x: p.x, y: p.y + step)
    case "<": return Point(x: p.x - step, y: p.y)
    case ">": return Point(x: p.x + step, y: p.y)
    default: fatalError()
    }
  }

  func part1() -> Any {
    let com = data.components(separatedBy: "\n\n")
    let grid = Grid(com[0].lines)
    let moves = com[1].lines.joined().map { $0 }

    var robot: Point = .init(x: 0, y: 0)
    var walls: [Point] = []
    var packages: [Point] = []
    for r in (0..<grid.rowCount) {
      for c in (0..<grid.colCount) {
        let p = Point(x: c, y: r)
        if grid[p] == "@" {
          robot = p
        } else if grid[p] == "#" {
          walls.append(p)
        } else if grid[p] == "O" {
          packages.append(p)
        }
      }
    }

    func printG(_ robot: Point, _ walls: [Point], _ packages: [Point]) {
      var str = ""
      for r in (0..<grid.rowCount) {
        for c in (0..<grid.colCount) {
          let p = Point(x: c, y: r)
          if robot == p {
            str += "@"
          } else if walls.contains(p) {
            str += "#"
          } else if packages.contains(p) {
            str += "O"
          } else {
            str += "."
          }
        }
        str += "\n"
      }
      print(str)
    }

    for move in moves {
      let newP = moved(robot, move, 1)

      if walls.contains(newP) {
        continue
      } else if packages.contains(newP) {
        var shifted = false
        var q: [Point] = [newP]
        var ps: [Point] = [newP]
        while !q.isEmpty {
          let cur = q.removeFirst()
          let np = moved(cur, move, 1)
          if walls.contains(cur) {
            continue
          } else if packages.contains(cur) {
            q.append(np)
            ps.append(np)
          } else {
            shifted = true
            ps = ps.filter { $0 != cur }
          }
        }
        if shifted {
          var newPackags = packages.filter { !ps.contains($0) }
          for pac in ps {
            newPackags.append(moved(pac, move, 1))
          }
          packages = newPackags
          robot = moved(robot, move, 1)
        }
      } else {
        robot = newP
      }
      //printG(robot, walls, packags)
    }

    return packages.map { 100 * $0.y + $0.x }.reduce(0, +)
  }

  struct Pacakage: Equatable, Hashable {
    let left: Point
    let right: Point

    init(_ left: Point, _ right: Point) {
      self.left = left
      self.right = right
    }

    func contains(_ point: Point) -> Bool {
      left == point || right == point
    }

    func move(_ direction: String.Element, _ step: Int = 1) -> Pacakage {
      let newLeft = moved(left, direction, step)
      let newRight = moved(right, direction, step)
      return Pacakage(newLeft, newRight)
    }

    func moved(_ p: Point, _ move: String.Element, _ step: Int = 1) -> Point {
      switch move {
      case "^": return Point(x: p.x, y: p.y - step)
      case "v": return Point(x: p.x, y: p.y + step)
      case "<": return Point(x: p.x - step, y: p.y)
      case ">": return Point(x: p.x + step, y: p.y)
      default: fatalError()
      }
    }
  }

  func part2() -> Any {
    let com = data.components(separatedBy: "\n\n")
    let moves = com[1].lines.joined().map { $0 }
    let input = com[0].lines
    var lines: [String] = []
    for line in input {
      var newLine = line
      newLine = newLine.replacingOccurrences(of: "#", with: "##")
      newLine = newLine.replacingOccurrences(of: ".", with: "..")
      newLine = newLine.replacingOccurrences(of: "@", with: "@.")
      newLine = newLine.replacingOccurrences(of: "O", with: "[]")
      lines.append(newLine)
    }

    let grid = Grid(lines)

    var robot: Point = .init(x: 0, y: 0)
    var walls: Set<Point> = []
    var packags: Set<Pacakage> = []
    for r in (0..<grid.rowCount) {
      for c in (0..<grid.colCount) {
        let p = Point(x: c, y: r)
        if grid[p] == "@" {
          robot = p
        } else if grid[p] == "#" {
          walls.insert(p)
        } else if grid[p] == "[" {
          packags.insert(Pacakage(p, Point(x: p.x + 1, y: p.y)))
        } else if grid[p] == "]" {

        }
      }
    }

    func printG(_ robot: Point, _ walls: Set<Point>, _ packages: Set<Pacakage>) {
      var str = ""
      for r in (0..<grid.rowCount) {
        for c in (0..<grid.colCount) {
          let p = Point(x: c, y: r)
          if robot == p {
            str += " " + "@"
          } else if walls.contains(p) {
            str += " " + "#"
          } else if packages.contains(where: { pac in
            pac.left == p
          }) {
            str += " " + "["
          } else if packages.contains(where: { pac in
            pac.right == p
          }) {
            str += " " + "]"
          } else {
            str += " " + "."
          }
        }
        str += "\n"
      }
      print(str)
    }

    for move in moves {
      let newP = moved(robot, move, 1)
      if walls.contains(newP) {
        continue
      } else if packags.contains(where: { $0.contains(newP) }) {
        let found = packags.first(where: ({ $0.contains(newP) }))!
        assert(packags.filter({ $0.contains(newP) }).count == 1)
        var shifted = false
        var q: Set<Point> = [found.left, found.right]
        var seen: Set<Point> = []
        var ps: Set<Pacakage> = [found]
        inner: while !q.isEmpty {
          let cur = q.removeFirst()

          if seen.contains(cur) {
            continue inner
          }
          seen.insert(cur)

          if walls.contains(cur) {
            shifted = false
            break inner
          } else if packags.contains(where: { pac in
            pac.contains(cur)
          }) {
            let f2 = packags.filter { pac in
              pac.contains(cur)
            }
            for f in f2 {
              let np = f.move(move, 1)
              q.insert(np.left)
              q.insert(np.right)
              ps.insert(f)
            }
          } else {
            shifted = true
            ps = ps.filter({ pac in
              !pac.contains(cur)
            })
          }
        }

        if shifted {
          var newPackags = packags.filter { pac in
            !ps.contains { $0 == pac }
          }
          let oldPackags = packags.filter { pac in
            ps.contains { $0 == pac }
          }
          assert(oldPackags.count == ps.count)
          for pac in oldPackags {
            let nxt = pac.move(move, 1)
            newPackags.insert(nxt)
          }
          packags = newPackags
          robot = moved(robot, move, 1)
        }
      } else {
        robot = newP
      }
      //printG(robot, walls, packags)
    }

    return packags.map { 100 * $0.left.y + $0.left.x }.reduce(0, +)
  }
}
