import Algorithms
import Foundation

struct Day21: AdventDay {
  typealias Grid = Grid2d<Character>
  var data: String

  struct Solver {
    let input: [String]

    init(_ data: String) {
      self.input = data.lines
    }

    let numberPad: Grid = Grid(
      """
      789
      456
      123
      .0A
      """.lines
    )

    let directionalPad: Grid = Grid(
      """
      .^A
      <v>
      """.lines
    )

    struct State {
      let point: Point
      let path: [Character]
      let moves: [Character]
    }

    func path(_ grid: Grid, _ start: Point, _ end: Character) -> [State] {
      var queue: [State] = [State(point: start, path: [], moves: [])]
      var seen: [Point: Int] = [:]
      seen[start] = 0
      var allStates: [State] = []
      var best = Int.max
      inner: while !queue.isEmpty {
        let state = queue.removeFirst()
        //print(state)
        let point = state.point
        let path = state.path
        let moves = state.moves

        if end == grid[point] {
          if moves.count <= best {
            best = moves.count
            allStates.append(state)
          }
          continue inner
        }

        if moves.count > best {
          continue inner
        }

        let all: [Point: Character] = [
          point.moved(1, .east): ">",
          point.moved(1, .west): "<",
          point.moved(1, .north): "^",
          point.moved(1, .south): "v",
        ]

        for (neighbor, direction) in all {
          if grid.isValid(neighbor) && grid[neighbor] != "." {
            if seen[neighbor] == nil || seen[neighbor] == moves.count {
              seen[neighbor] = moves.count
              queue.append(
                State(point: neighbor, path: path + [direction], moves: moves + [grid[neighbor]!])
              )
            }
          }
        }
      }

      return allStates
    }

    func path(_ grid: Grid, _ sequence: [Character]) -> [[Character]] {
      var start = Point.start
      for r in (0..<grid.rowCount) {
        for c in (0..<grid.colCount) {
          let p = Point(x: c, y: r)
          if grid[p] == "A" {
            start = p
            break
          }
        }
      }

      var new: [[Character]] = [[]]
      var current = start
      for s in sequence {
        let allStates = path(grid, current, s)
        current = allStates.first!.point
        let mvs = allStates.map { $0.path }

        if mvs.count == 1 {
          for i in 0..<new.count {
            new[i] += mvs[0] + "A"
          }
        } else {
          var n2: [[Character]] = []
          for n in new {
            for i in 0..<mvs.count {
              n2.append(n + mvs[i] + "A")
            }
          }
          new = n2
        }

      }
      //print(new)

      return new
    }

    func complexity() -> Int {
      let paths = path(numberPad, "029A".map { $0 })
      var best = Int.max
      var next: [[Character]] = []
      for p in paths {
        if p.count <= best {
          best = p.count
          next.append(p)
        }
      }
      print(next.map { $0.count }.min()!)
      var p2: [[Character]] = []
      for n in next {
        let r = path(directionalPad, n)
        r.forEach {
          p2.append($0)
        }
      }

      best = Int.max
      next = []
      for p in p2 {
        if p.count <= best {
          best = p.count
          next.append(p)
        }
      }
      print(next.map { $0.count })
      var p3: [[Character]] = []
      for n in next {
        let r = path(directionalPad, n)
        r.forEach {
          p3.append($0)
        }
      }
      best = Int.max
      for p in p3 {
        if p.count <= best {
          best = p.count
          next.append(p)
        }
      }
      print(next.map { $0.count }.min()!)

      return 0
    }
  }

  func part1() -> Any {
    _ = Solver(data).complexity()
    return 0
  }

  func part2() -> Any {
    return 0
  }
}
