import Algorithms

struct Day13: AdventDay {
    typealias Grid = Grid2d<Character>
    var data: String

    var input: [String] {
        data.trimmingCharacters(in: .newlines).components(separatedBy: "\n\n")
    }

    class MirrorGrid {
        var grid: Grid
        let smudge: Bool

        init(_ input: String, _ smudge: Bool = false) {
            self.grid = Grid(input.components(separatedBy: "\n"))
            self.smudge = smudge
        }

        var cell: Grid.Cell {
            grid.grid
        }

        func summarise() -> Int {
            var ans = 0
            for c in 0..<grid.colCount - 1 {
                var ok = true
                var count = 0
                for dc in 0..<grid.colCount {
                    let left = c - dc
                    let right = c + 1 + dc
                    if 0 <= left && left < right && right < grid.colCount {
                        for r in 0..<grid.rowCount {
                            let lp = Point(x: left, y: r)
                            let rp = Point(x: right, y: r)
                            if cell[lp] != cell[rp] {
                                ok = false
                                count += 1
                            }
                        }
                    }
                }

                if smudge {
                    if count == 1 {
                        ans += c + 1
                    }
                }
                else if ok {
                    ans += c + 1
                }
            }

            for r in 0..<grid.rowCount - 1 {
                var ok = true
                var count = 0
                for dr in 0..<grid.rowCount {
                    let left = r - dr
                    let right = r + 1 + dr

                    if 0 <= left && left < right && right < grid.rowCount {
                        for c in 0..<grid.colCount {
                            let lp = Point(x: c, y: left)
                            let rp = Point(x: c, y: right)
                            if cell[lp] != cell[rp] {
                                ok = false
                                count += 1
                            }
                        }
                    }
                }

                if smudge {
                    if count == 1 {
                        ans += (r + 1) * 100
                    }
                }
                else if ok {
                    ans += (r + 1) * 100
                }
            }

            return ans
        }
    }

    func part1() -> Any {
        input.map { MirrorGrid($0) }.map { $0.summarise() }.reduce(0, +)
    }

    func part2() -> Any {
        input.map { MirrorGrid($0, true) }.map { $0.summarise() }.reduce(0, +)
    }
}
