//
//  Grid2d.swift
//
//
//  Created by Rizwan on 01/12/23.
//

import Foundation

struct Grid2d<T> {
    typealias Cell = [Point: T]

    var grid: Cell = [:]
    let rowCount: Int
    let colCount: Int

    init(_ input: [String]) {
        self.rowCount = input.count
        self.colCount = input[0].count

        input.enumerated().forEach { (i, line) in
            line.enumerated().forEach { (j, char) in
                let p = Point.init(x: j, y: i)
                grid[p] = char as? T
            }
        }
    }

    init(_ grid: [Point: T]) {
        self.grid = grid
        self.rowCount = grid.keys.map { $0.y }.max()! + 1
        self.colCount = grid.keys.map { $0.x }.max()! + 1
        print(self.rowCount)
        print(self.colCount)
    }

    func debugPrint() {
        print("grid start")
        print("rc", separator: "", terminator: " ")
        (0..<colCount).forEach {
            print($0, separator: " ", terminator: " ")
        }
        print("\n\n")
        for r in (0..<rowCount) {
            print(r, separator: " ", terminator: "  ")
            for c in (0..<colCount) {
                let p = Point(x: c, y: r)
                print(grid[p] ?? "&", separator: " ", terminator: " ")
            }
            print("\n")
        }
        print("grid end")
    }

    func adjacentValues(_ p: Point) -> [T] {
        p.adjacent().compactMap { grid[$0] }
    }

    func neighbourValues(_ p: Point) -> [T] {
        p.neighbours().compactMap { grid[$0] }
    }
}
