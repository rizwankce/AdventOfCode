import Algorithms

struct Day13: AdventDay {
    typealias Grid = Grid2d<Character>
    var data: String

    var input: [String] {
        data.trimmingCharacters(in: .newlines).components(separatedBy: "\n\n")
    }

    struct MirrorGrid {
        var grid: Grid
        let smudge: Bool

        init(_ input: String, _ smudge: Bool = false) {
            self.grid = Grid(input.components(separatedBy: "\n"))
            self.smudge = smudge
        }

        var cell: Grid.Cell {
            grid.grid
        }

        func getRanges(_ i: Int, _ end: Int) -> (ClosedRange<Int>, ClosedRange<Int>) {
            var left = 0...i
            var right = i + 1...end - 1
            if left.count < right.count {
                right = i + 1...i + left.count
            }
            else if left.count > right.count {
                left = i + 1 - right.count...i
            }
            return (left, right)
        }

        func getCol(_ c: Int) -> [Character] {
            (0..<grid.rowCount).map { Point(x: c, y: $0) }.map { cell[$0]! }
        }

        func getRow(_ r: Int) -> [Character] {
            (0..<grid.colCount).map { Point(x: $0, y: r) }.map { cell[$0]! }
        }

        func summarise() -> Int {
            var ans = 0
            for c in 0..<grid.colCount - 1 {
                var bad = 0
                let rr = getRanges(c, grid.colCount)

                for pair in zip(rr.0.reversed(), rr.1) {
                    for p in zip(getCol(pair.0), getCol(pair.1)) {
                        if p.0 != p.1 {
                            bad += 1
                        }
                    }
                }

                if smudge {
                    if bad == 1 {
                        ans += c + 1
                    }
                }
                else if bad == 0 {
                    ans += c + 1
                }
            }

            for r in 0..<grid.rowCount - 1 {
                var bad = 0
                let rr = getRanges(r, grid.rowCount)

                for pair in zip(rr.0.reversed(), rr.1) {
                    for p in zip(getRow(pair.0), getRow(pair.1)) {
                        if p.0 != p.1 {
                            bad += 1
                        }
                    }
                }

                if smudge {
                    if bad == 1 {
                        ans += (r + 1) * 100
                    }
                }
                else if bad == 0 {
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
