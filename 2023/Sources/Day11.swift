import Algorithms

struct Day11: AdventDay {
    typealias Grid = Grid2d<Character>

    var data: String

    var input: [String] {
        data.lines
    }

    struct ImageGalaxies {
        let grid: Grid

        init(_ input: [String]) {
            self.grid = Grid(input)
        }

        var cells: [Point: Character] {
            grid.grid
        }

        func sumOfLengths(_ expansion: Int) -> Int {
            var emptyRows: [Int] = []
            var emptyCols: [Int] = []
            var galaxies: [Point] = []

            for r in (0..<grid.rowCount) {
                var cols: [Character] = []
                for c in (0..<grid.colCount) {
                    let p = Point(x: c, y: r)
                    cols.append(cells[p]!)
                }
                if cols.allSatisfy({ $0 == "." }) {
                    emptyRows.append(r)
                }
            }
            for c in (0..<grid.colCount) {
                var rows: [Character] = []
                for r in (0..<grid.rowCount) {
                    let p = Point(x: c, y: r)
                    rows.append(cells[p]!)
                }
                if rows.allSatisfy({ $0 == "." }) {
                    emptyCols.append(c)
                }
            }

            for kv in grid.grid {
                if kv.value == "#" {
                    galaxies.append(kv.key)
                }
            }

            func distance(_ start: Point, _ end: Point, _ expansion: Int) -> Int {
                let xSearchRange = min(start.x, end.x)...max(start.x, end.x)
                let ySearchRange = min(start.y, end.y)...max(start.y, end.y)

                var dist = start.distance(end)

                for r in emptyRows {
                    if ySearchRange.contains(r) {
                        dist += expansion - 1
                    }
                }

                for c in emptyCols {
                    if xSearchRange.contains(c) {
                        dist += expansion - 1
                    }
                }
                return dist
            }

            return galaxies.combinations(ofCount: 2).map {
                distance($0[0], $0[1], expansion)
            }.reduce(0, +)
        }
    }

    func part1() -> Any {
        ImageGalaxies(input).sumOfLengths(2)
    }

    func part2() -> Any {
        ImageGalaxies(input).sumOfLengths(1_000_000)
    }
}
