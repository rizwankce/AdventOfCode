import Algorithms
import Collections

struct Day16: AdventDay {
  typealias Grid = Grid2d<Character>

  var data: String

  var grid: Grid {
    Grid(data.lines)
  }

  struct Maze {
    let allDirections: [Direction] = [
      .east,
      .north,
      .south,
      .west,
    ]
    let moveCost = 1
    let turnCost = 1000

    struct State: Hashable, Comparable {
      static func < (lhs: Day16.Maze.State, rhs: Day16.Maze.State) -> Bool {
        lhs.cost < rhs.cost
      }

      let position: Point
      let direction: Direction
      var cost: Int
    }

    struct Cache: Hashable {
      let position: Point
      let direction: Direction
    }
    let grid: Grid
    var start: Point
    var end: Point

    init(grid: Grid) {
      self.grid = grid
      self.start = Point.start
      self.end = Point.start
      for r in (0..<grid.rowCount) {
        for c in (0..<grid.colCount) {
          let p = Point(x: c, y: r)
          if grid[p] == "S" {
            start = p
          }
          if grid[p] == "E" {
            end = p
          }
        }
      }
    }

    func dijkstra() -> (minCost: Int, tiles: Int) {
      var costs: [State: Int] = [:]
      var cameFrom: [State: [State]] = [:]
      var pq: Heap<State> = []

      let initialState = State(position: start, direction: .east, cost: 0)
      costs[initialState] = 0
      pq.insert(initialState)
      var seen: Set<Cache> = []
      var best = Int.max
      var endState: State = State(position: end, direction: .north, cost: 0)

      while !pq.isEmpty {
        guard let cur = pq.popMin() else { break }
        let curCost = costs[cur] ?? Int.max
        let cache = Cache(position: cur.position, direction: cur.direction)

        if seen.contains(cache) { continue }
        seen.insert(cache)

        if cur.position == end {
          best = min(best, curCost)
          if endState.cost < best {
            endState = cur
          }
        }

        for direction in allDirections {
          let newPos = cur.position.moved(1, direction)

          guard grid.isValid(newPos) && grid[newPos] != "#" else { continue }

          var additionalCost = moveCost
          if direction != cur.direction {
            additionalCost += turnCost
          }

          let newCost = curCost + additionalCost

          let newState = State(position: newPos, direction: direction, cost: newCost)

          if newCost < costs[newState] ?? Int.max {
            costs[newState] = newCost
            cameFrom[newState] = [cur]
            pq.insert(newState)
          } else if newCost <= costs[newState] ?? Int.max {
            cameFrom[newState, default: []].append(cur)
          }
        }
      }

      var stack = [endState]
      var good = Set(stack)
      while !stack.isEmpty {
        let cur = stack.removeLast()
        let others = cameFrom[cur] ?? []
        for other in others {
          if !good.contains(other) {
            good.insert(other)
            stack.append(other)
          }
        }
      }

      var ps: Set<Point> = []
      for g in good {
        ps.insert(g.position)
        grid[g.position] = "$"
      }
      //print(grid)
      return (best, ps.count)
    }
  }

  func part1() -> Any {
    Maze(grid: grid).dijkstra().0
  }

  func part2() -> Any {
    Maze(grid: grid).dijkstra().1
  }
}
