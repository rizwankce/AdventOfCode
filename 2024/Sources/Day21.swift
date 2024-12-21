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
      []
    }

    func combineAllPaths(_ paths: [[Any]]) -> [[Character]] {
      // Handle empty or single path case
      guard paths.count > 0 else { return [] }

      // Function to flatten a single path if it contains nested arrays
      func flattenPath(_ path: [Any]) -> [[Character]] {
        var result: [[Character]] = []

        func processElement(_ element: Any) -> [Character] {
          if let char = element as? Character {
            return [char]
          } else if let array = element as? [Character] {
            return array
          } else if let nestedArray = element as? [[Character]] {
            return nestedArray[0]  // Take first path if multiple options
          }
          return []
        }

        if let firstElement = path.first {
          if path.count == 1 && firstElement is [[Character]] {
            // Handle case where element is array of path options
            if let pathOptions = firstElement as? [[Character]] {
              return pathOptions
            }
          } else {
            // Process each element and combine them
            var currentPath: [Character] = []
            for element in path {
              currentPath.append(contentsOf: processElement(element))
            }
            result.append(currentPath)
          }
        }

        return result.isEmpty ? [[]] : result
      }

      // Start with the first path
      var result = flattenPath(paths[0])

      // Combine with each subsequent path
      for i in 1..<paths.count {
        let currentPaths = flattenPath(paths[i])
        var newResult: [[Character]] = []

        // Combine each existing path with each new path option
        for existingPath in result {
          for newPath in currentPaths {
            newResult.append(existingPath + newPath)
          }
        }

        result = newResult
      }

      return result
    }

    func path(_ grid: Grid, _ sequence: [Character]) -> [Character] {

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

      var new: [[State]] = []
      var current = start
      for s in sequence {
        var queue: [State] = [State(point: current, path: [], moves: [])]
        var seen: [Point: Int] = [:]
        seen[current] = 0
        var allStates: [State] = []
        var best = Int.max
        inner: while !queue.isEmpty {
          let state = queue.removeFirst()
          //print(state)
          let point = state.point
          let path = state.path
          let moves = state.moves

          //                    if seen.contains(point) {
          //                        continue inner
          //                    }
          //                    seen.insert(point)

          if s == grid[point] {
            if moves.count <= best {
              best = moves.count
              allStates.append(state)
            }
            continue inner
            //return (point, path)
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
          //print(grid[point]!, all.map { grid[$0.key] })
          for (neighbor, direction) in all {
            if grid.isValid(neighbor) && grid[neighbor] != "." {
              //                            print(moves.count, seen[neighbor])
              if seen[neighbor] == nil || seen[neighbor] == moves.count {
                //print(grid[neighbor])

                seen[neighbor] = moves.count
                queue.append(
                  State(point: neighbor, path: path + [direction], moves: moves + [grid[neighbor]!])
                )
              }
            }
          }
        }

        //                if allStates.count == 1 {
        //                    new.append(allStates.flatMap({ $0.moves}))
        //                }
        //                else {
        //                    var nn: [[Character]] = new
        //
        //                    for state in allStates {
        //                        var op: [Character] = []
        //                        for i in 0 ... nn.count-1 {
        //                            op.append(contentsOf: nn[i] + state.moves + ["A"])
        //                        }
        //                        nn.append(op)
        //                    }
        //                    new = nn
        //                }

        //                for state in allStates {
        //                    new.append(state.moves)
        //                }

        new.append(allStates)

        current = allStates.first!.point
        //print(allStates)
        //print(new)
      }
      print(new.map { $0.map { $0.moves } })

      var chars: [String] = [""]
      for states in new {
        var nns: String = ""
        for (j, state) in states.enumerated() {
          nns += state.moves + "A" + "\n"
        }

        var j = 0
        for c in nns.components(separatedBy: "\n") {
          for i in 0..<chars.count {
            if i + j >= chars.count {
              chars.append(chars[i])
            }
            chars[i + j] = chars[i + j] + c
          }
          j += 1
        }
      }

      print(chars)
      return []
    }

    func complexity() -> Int {
      let path = path(numberPad, "029A".map { $0 })
      //print(path)
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
