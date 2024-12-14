import Algorithms

struct Day14: AdventDay {
  var data: String

  var input: [String] {
    data.lines
  }

  class Robot: CustomStringConvertible {
    var position: Point
    let velocity: Point
    let rowCount: Int
    let colCount: Int

    init(_ line: String, _ rowCount: Int, _ colCount: Int) {
      // p=0,4 v=3,-3
      let com = line.numbers
      self.position = Point(x: com[0], y: com[1])
      self.velocity = Point(x: com[2], y: com[3])
      self.rowCount = rowCount
      self.colCount = colCount
    }

    var description: String {
      "P: \(position), v: \(velocity)"
    }

    func tick() {
      let x = (position.x + velocity.x)
      let y = (position.y + velocity.y)

      if 0 <= x && x < colCount {
        position.x = x
      } else {
        if x > 0 {
          position.x = x % colCount
        } else {
          position.x = colCount - abs(x)
        }
      }

      if 0 <= y && y < rowCount {
        position.y = y
      } else {
        if y > 0 {
          position.y = y % rowCount
        } else {
          position.y = rowCount - abs(y)
        }
      }
    }
  }

  func printGrid(_ rs: [Robot], _ rowCount: Int, _ colCount: Int) {
    var str = ""
    str += "\n\n"
    for r in (0..<rowCount) {
      for c in (0..<colCount) {
        let p = Point(x: c, y: r)
        let c = rs.filter { $0.position == p }.count
        if c > 0 {
          str += "" + "\(c)"
        } else {
          str += "" + "."
        }
      }
      str += "\n"
    }
    print(str)
  }

  func safetyFactor(_ rs: [Robot], _ rowCount: Int, _ colCount: Int) -> [Int] {
    let midRow = rowCount / 2
    let midCol = colCount / 2

    var left: [Point] = []
    var right: [Point] = []
    var bLeft: [Point] = []
    var bRight: [Point] = []

    for r in rs {
      let p = r.position

      if p.x < midCol && p.y < midRow {
        left.append(p)
      }
      if p.x > midCol && p.y < midRow {
        right.append(p)
      }
      if p.x < midCol && p.y > midRow {
        bLeft.append(p)
      }
      if p.x > midCol && p.y > midRow {
        bRight.append(p)
      }
    }
    return [left.count, right.count, bLeft.count, bRight.count]
  }

  func safetyFactor(_ rowCount: Int, _ colCount: Int) -> Int {
    let robots = input.map { Robot($0, rowCount, colCount) }
    for _ in 1...100 {
      robots.forEach({ $0.tick() })
    }
    return safetyFactor(robots, rowCount, colCount).reduce(1, *)
  }

  func easterEgg(_ rowCount: Int, _ colCount: Int, _ max: Int) -> Int {
    let robots = input.map { Robot($0, rowCount, colCount) }
    var ans = 0
    outer: for i in 1... {
      robots.forEach { $0.tick() }
      for s in safetyFactor(robots, rowCount, colCount) {
        if s > max {
          ans = i
          break outer
        }
      }
    }
    return ans
  }

  func part1() -> Any {
    safetyFactor(103, 101)
  }

  func part2() -> Any {
    easterEgg(103, 101, 300)
  }
}
