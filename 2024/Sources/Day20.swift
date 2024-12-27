import Algorithms

struct Day20: AdventDay {
  typealias Grid = Grid2d<Character>

  var data: String

  func shortestPath(_ grid: Grid, _ start: Point, _ end: Point) -> Int {
    let grid = grid
    var queue: [(Point, Int)] = [(start, 0)]
    var visited: Set<Point> = []
    while !queue.isEmpty {
      let current = queue.removeFirst()

      if visited.contains(current.0) {
        continue
      }
      visited.insert(current.0)

      if current.0 == end {
        return current.1
      }

      for neighbor in current.0.adjacent() {
        if grid.isValid(neighbor) && grid[neighbor] != "#" {
          queue.append((neighbor, current.1 + 1))
        }
      }
    }

    fatalError()
  }

  func part1() -> Any {
    return 0
    let grid = Grid(data.lines)
    var start = Point(x: 0, y: 0)
    var end = Point(x: 0, y: 0)
    var cheatWalls: Set<Point> = []
    //print(grid)
    for r in (0..<grid.rowCount) {
      for c in (0..<grid.colCount) {
        let p = Point(x: c, y: r)
        if grid[p] == "S" {
          start = p
        }
        if grid[p] == "E" {
          end = p
        }

        if grid[p] == "#" {
          if p.adjacent().filter({ grid.isValid($0) }).count == 4 {
            let cheats = p.adjacent().filter {
              (grid[$0] == "." || grid[$0] == "E" || grid[$0] == "S") && grid.isValid($0)
            }

            if !cheats.isEmpty && cheats.count >= 2 {
              cheatWalls.insert(p)
            }
          }
        }
      }
    }
    print(start, end)

    let best = shortestPath(grid, start, end)
    //        for c in cheatWalls {
    //            grid[c] = "$"
    //        }
    //        print(grid)

    print(best)
    print(cheatWalls.count)
    var possible: [Int: [Point]] = [:]
    for (i, cheat) in cheatWalls.enumerated() {
      print(i)
      var newGrid = Grid(data.lines)
      newGrid[cheat] = "."
      let pathCount = shortestPath(newGrid, start, end)
      //print(cheat , pathCount)
      possible[best - pathCount, default: []].append(cheat)
    }
    var ans = 0
    for p in possible {
      //            print("\(p.value.count) cheats with \(p.key) saves")
      //            print("\n")
      if p.key >= 100 {
        ans += p.value.count
      }
    }
    return ans
  }

  func part2() -> Any {
    let grid = Grid(data.lines)
    var start = Point(x: 0, y: 0)
    var end = Point(x: 0, y: 0)
    var distances: [Point: Int] = [:]

    for r in (0..<grid.rowCount) {
      for c in (0..<grid.colCount) {
        let p = Point(x: c, y: r)
        if grid[p] == "S" {
          start = p
        }
        if grid[p] == "E" {
          end = p
        }
        distances[p] = -1
      }
    }

    distances[start] = 0
    var current = start
    while current != end {
      for neighbor in current.adjacent() {
        if grid.isValid(neighbor) && grid[neighbor] != "#" {
          if distances[neighbor]! == -1 {
            distances[neighbor] = distances[current]! + 1
            current = neighbor
          }
        }
      }
    }

    //        for row in distances {
    //            if row.value == -1 {
    //                grid[row.key] = "#"
    //            }
    //            else {
    //                grid[row.key] = "\(row.value)".first!
    //            }
    //        }
    //
    //        print(grid)

    var ans = 0
    struct Pair: Hashable {
      let start: Point
      let end: Point
    }
    var all: [Int: Set<Pair>] = [:]
    //        for r in (0..<grid.rowCount) {
    //            for c in (0..<grid.colCount) {
    for p in distances.keys {
      let r = p.y
      let c = p.x
      for nr in r - 20...r + 20 {
        for nc in c - 20...c + 20 {
          let newP = Point(x: nc, y: nr)
          if grid.isValid(newP) && grid[newP] != "#" {
            //print(p, newP, distances[p]! - distances[newP]!, nr + nc)

            if distances[p]! - distances[newP]! >= 76 {
              ans += 1
            }
          }
        }
      }
    }

    //                for dr in -20...20 {
    //                    for dc in -20...20 {
    //                        let newP = Point(x: c + dc, y: r + dr)
    //                        if grid.isValid(newP) && grid[newP] != "#" {
    //                            if distances[p]! - distances[newP]! >= 76 {
    //                                print(p, newP, distances[p]! - distances[newP]!, dr + dc)
    //                                ans += 1
    //                                all[distances[p]! - distances[newP]!, default: []].insert(Pair(start: p, end: newP))
    //                            }
    //                        }
    //                    }
    //                }
    for radi in (2...20) {
      //var radi = 2
      for dr in (0...radi) {
        //                        for newP in [
        //                            p.moved(radi, .east),
        //                            p.moved(radi, .west),
        //                            p.moved(radi, .north),
        //                            p.moved(radi, .south)]  {
        //                            if grid.isValid(newP) && grid[newP] != "#" {
        //                                if distances[p]! - distances[newP]! >= 50 + radi {
        //                                    print(p, newP, distances[p]! - distances[newP]!, radi)
        //                                    ans += 1
        //                                    all[distances[p]! - distances[newP]!, default: []].insert(Pair(start: p, end: newP))
        //                                }
        //                            }
        //                        }
        //                        let dc = radi - dr
        //                        for (nr,nc) in [(r+dr,c+dc),(r+dr,c-dc), (r-dr,c+dc), (r-dr,c-dc)] {
        //                            let newP = Point(x: nc, y: nr)
        //                            if grid.isValid(newP) && grid[newP] != "#" {
        //                                if distances[p]! - distances[newP]! >= 70 + radi {
        //                                    print(distances[p]! - distances[newP]!, radi)
        //                                    ans += 1
        //                                }
        //                            }
        //                        }
      }
    }
    //            }
    //        }

    print(all.values.map { $0.count }.reduce(0, +))

    return ans
  }
}
