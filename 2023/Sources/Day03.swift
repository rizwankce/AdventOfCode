import Algorithms

struct Day03: AdventDay {
    typealias Points = [[Point]]
    typealias Grid = Grid2d<Character>

    var data: String

    var input: [String] {
        data.lines
    }

    func parse(_ grid: Grid) -> (Points, [Point]) {
        var numbers: Points = []
        var stars: [Point] = []

        for x in 0...grid.rowCount {
            var numberPoints: [Point] = []
            for y in 0...grid.colCount {
                let cell = grid.grid
                let p = Point(x: x, y: y)
                let v = cell[p, default: "."]
                if v.isWholeNumber {
                    numberPoints.append(p)
                }
                else if !v.isWholeNumber && !numberPoints.isEmpty {
                    numbers.append(numberPoints)
                    numberPoints.removeAll()
                }

                if v == "*" {
                    stars.append(p)
                }
            }
        }

        return (numbers, stars)
    }

    func number(from points: [Point], _ cell: Grid.Cell) -> Int {
        Int(points.map { String(cell[$0]!) }.joined())!
    }

    func part1() -> Any {
        let grid = Grid(input)
        let cell = grid.grid
        let numbers = parse(grid).0
        var valids: Points = []

        for nps in numbers {
            var valid = false
            for p in nps {
                p.neighbours().forEach {
                    let v = cell[$0, default: "."]
                    if !v.isWholeNumber && v != ".".first {
                        valid = true
                    }
                }
            }
            if valid {
                valids.append(nps)
            }
        }

        return valids.map { number(from: $0, cell) }.reduce(0, +)
    }

    func part2() -> Any {
        let grid = Grid(input)
        let cell = grid.grid
        let parsed = parse(grid)
        let numbers = parsed.0
        let stars = parsed.1

        var ratios: [Int] = []
        for star in stars {
            var gears: [[Point]] = []
            star.neighbours().forEach { p in
                for number in numbers {
                    if number.contains(p) && !gears.contains(number) {
                        gears.append(number)
                    }
                }
            }
            if gears.count == 2 {
                let ratio = gears.map { number(from: $0, cell) }.reduce(1, *)
                ratios.append(ratio)
            }
        }
        return ratios.reduce(0, +)
    }
}
