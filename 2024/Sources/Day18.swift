import Algorithms

struct Day18: AdventDay {
  var data: String

  var input: [Point] {
    data.lines.map { line in
      let com = line.components(separatedBy: ",")
      return Point(x: Int(com[0])!, y: Int(com[1])!)
    }
  }

  func simulate(_ count: Int, _ rowCount: Int, _ colCount: Int) -> [Point] {
    let points = input[0...count - 1]

    func printGrid(_ seen: Set<Point> = []) {
      var str = ""
      for r in (0..<rowCount) {
        for c in (0..<colCount) {
          let p = Point(x: c, y: r)
          if points.contains(p) {
            str += "#"
          } else if seen.contains(p) {
            str += "O"
          } else {
            str += "."
          }
        }
        str += "\n"
      }
      print(str)
    }

    func isValid(_ point: Point) -> Bool {
      0 <= point.x && point.x < colCount && 0 <= point.y && point.y < rowCount
    }

    struct State: Hashable {
      let point: Point
      let path: [Point]
    }

    let start = State(point: Point.start, path: [])
    let end = Point(x: rowCount - 1, y: colCount - 1)
    var queue: [State] = [start]
    var visited: Set<Point> = []
    var path: [Point] = []
    while !queue.isEmpty {
      let current = queue.removeFirst()
      if visited.contains(current.point) {
        continue
      }
      visited.insert(current.point)

      if current.point == end {
        path = current.path
        break
      }

      for neighbor in current.point.adjacent() {
        if !points.contains(neighbor) && isValid(neighbor) {
          queue.append(State(point: neighbor, path: current.path + [neighbor]))
        }
      }
    }
    return path
  }

  func simulate(_ gridLength: Int) -> String {
    var ans = Point.start
    for i in (1...input.count - 1) {
      let path = simulate(i, gridLength, gridLength)
      if path.count == 0 {
        let points = input[0...i - 1]
        ans = points.last!
        break
      }
    }

    return "\(ans.x),\(ans.y)"
  }

  func part1() -> Any {
    simulate(1024, 71, 71).count
  }

  func part2() -> Any {
    simulate(71)
  }
}
