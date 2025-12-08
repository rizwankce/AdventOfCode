import Algorithms

struct Day07: AdventDay {
  var data: String

  var grid: Grid2d<Character> {
    Grid2d(data.components(separatedBy: .newlines))
  }

  func part1() -> Any {
    let grid = grid
    var start = Point(x: 0, y: 0)

    for p in grid.grid.keys {
      if grid[p] == "S" {
        start = p
        break
      }
    }

    var queue: [[Point]] = []
    var visited: Set<Point> = []
    var s2: Set<Point> = []
    var ss: [Point: Set<Point>] = [:]
    var cur = start
    while grid[cur] == "S" || grid[cur] == "." {
      visited.insert(cur)
      cur.move(1, .south)
    }
    queue.append([cur])

    while !queue.isEmpty {
      let ps = queue.removeFirst()
      var nexts: Set<Point> = []

      inner1: for point in ps {

        if s2.contains(point) {
          continue inner1
        }
        s2.insert(point)

        let sides = [
          point.moved(1, .east),
          point.moved(1, .west),
        ]

        inner: for n in sides {
          if visited.contains(n) {
            continue inner
          }
          cur = n
          while grid[cur] == "S" || grid[cur] == "." {
            visited.insert(cur)
            cur.move(1, .south)
          }

          if grid.grid.keys.contains(cur) {
            nexts.insert(cur)
          }
        }
        ss[point] = nexts
      }
      if !nexts.isEmpty {
        queue.append(Array(nexts))
      }
    }

    return ss.keys.count
  }

  func part2() -> Any {
    let grid = grid

    var start = Point(x: 0, y: 0)

    for p in grid.grid.keys {
      if grid[p] == "S" {
        start = p
        break
      }
    }

    var cache: [Point: Int] = [:]

    func timelines(_ point: Point) -> Int {
      if cache.keys.contains(point) {
        return cache[point]!
      }

      if !grid.isValid(point) {
        cache[point] = 1
        return 1
      }

      if grid[point] == "^" {
        let p1 = point.moved(1, .east)
        let p2 = point.moved(1, .west)
        cache[point] = timelines(p1) + timelines(p2)
        return cache[point]!
      } else {
        let next = point.moved(1, .south)
        cache[point] = timelines(next)
        return cache[point]!
      }
    }

    return timelines(start)
  }
}
