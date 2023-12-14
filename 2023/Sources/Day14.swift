import Algorithms

struct Day14: AdventDay {
    typealias Grid = Grid2d<Character>

    var data: String

    var input: [String] {
        data.lines
    }

    func tilt(_ grid: Grid, _ direction: Direction = .north) -> Grid {
        func getCol(_ c: Int) -> [Point] {
            (0..<grid.rowCount).map { Point(x: c, y: $0) }
        }

        func getRow(_ r: Int) -> [Point] {
            (0..<grid.colCount).map { Point(x: $0, y: r) }
        }

        switch direction {
        case .east:
            for r in 0..<grid.rowCount {
                for p in getRow(r).reversed() {
                    let cur = grid.grid[p]
                    if cur == "O" {
                        var nextP = p
                        while true {
                            nextP = nextP.moved(1, direction)
                            let nxtV = grid.grid[nextP]
                            if nxtV == "." {
                                continue
                            }
                            else {
                                nextP = nextP.moved(1, .west)
                                break
                            }
                        }
                        grid.grid[p] = "."
                        grid.grid[nextP] = cur
                    }
                }
            }
            break
        case .west:
            for r in 0..<grid.rowCount {
                for p in getRow(r) {
                    let cur = grid.grid[p]
                    if cur == "O" {
                        var nextP = p
                        while true {
                            nextP = nextP.moved(1, direction)
                            let nxtV = grid.grid[nextP]
                            if nxtV == "." {
                                continue
                            }
                            else {
                                nextP = nextP.moved(1, .east)
                                break
                            }
                        }
                        grid.grid[p] = "."
                        grid.grid[nextP] = cur
                    }
                }
            }
            break
        case .south:
            for c in 0..<grid.colCount {
                for p in getCol(c).reversed() {
                    let cur = grid.grid[p]
                    if cur == "O" {
                        var nextP = p
                        while true {
                            nextP = nextP.moved(1, direction)
                            let nxtV = grid.grid[nextP]
                            if nxtV == "." {
                                continue
                            }
                            else {
                                nextP = nextP.moved(1, .north)
                                break
                            }
                        }
                        grid.grid[p] = "."
                        grid.grid[nextP] = cur
                    }
                }
            }
            break
        case .north:
            for c in 0..<grid.colCount {
                for p in getCol(c) {
                    let cur = grid.grid[p]
                    if cur == "O" {
                        var nextP = p
                        // move north by 1 step untill it reaches out of grid or # or another O
                        while true {
                            nextP = nextP.moved(1, direction)
                            let nxtV = grid.grid[nextP]
                            if nxtV == "." {
                                continue
                            }
                            else {
                                nextP = nextP.moved(1, .south)
                                break
                            }
                        }
                        grid.grid[p] = "."
                        grid.grid[nextP] = cur
                    }
                }
            }
            break
        default: break

        }

        return grid
    }

    func cycle(_ grid: Grid) -> Grid {
        var grid = grid
        let directions: [Direction] = [.north, .west, .south, .east]

        for direction in directions {
            grid = tilt(grid, direction)
        }

        return grid
    }

    func load(_ grid: Grid) -> Int {
        var ans = 0
        for r in 0..<grid.rowCount {
            var count = 0
            for c in 0..<grid.colCount {
                let p = Point(x: c, y: r)
                if grid.grid[p]! == "O" {
                    count += grid.rowCount - r
                }
            }
            ans += count
        }
        return ans
    }

    func part1() -> Any {
        load(tilt(Grid(input)))
    }

    func part2() -> Any {
        func findRepeatingSequence(in array: [Int]) -> [Int]? {
            for windowSize in 2...array.count / 2 {
                for start in 0...(array.count - windowSize * 2) {
                    let window1 = Array(array[start..<start + windowSize])
                    let window2 = Array(array[start + windowSize..<start + windowSize * 2])
                    if window1 == window2 {
                        return window1
                    }
                }
            }
            return nil
        }

        /*
         Part 2 search scope is very big. So instead of going through all the cycles.
         Just go through first 1000 cycles. In that after 200 cycles try to find a repeating pattern
         Once the repeating pattern is found, try to find the pattern start point
         Once pattern start point is found, we can use % of 1_000_000_000 to figure out which cycle it will probably land and consider that as answer
         */

        var grid = Grid(input)
        var uni: [Int] = []
        var ans = 0
        var sequence: [Int] = []
        var fixed: [Int] = []
        for i in 0..<1000 {
            grid = cycle(grid)
            let s = load(grid)
            uni.append(s)
            if i + 1 >= 200 {
                if sequence.count == 0 {
                    if let seq = findRepeatingSequence(in: uni) {
                        sequence = seq
                    }
                }
                else {
                    fixed.append(s)
                    if fixed.count > sequence.count {
                        fixed.removeFirst()
                    }
                    if fixed == sequence {
                        let mod = (1_000_000_000 - (i + 1 + 1)) % sequence.count
                        ans = sequence[mod]
                        break
                    }
                }

            }
        }

        return ans
    }
}
