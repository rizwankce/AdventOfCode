//
//  Grid.swift
//  
//
//  Created by Rizwan on 01/12/23.
//

import Foundation

struct Grid {
    typealias Cell = [Point: Int]
    
    var grid: Cell = [:]
    let rowCount: Int
    let colCount: Int
    
    init(_ input: [String]) {
        self.rowCount = input[0].count
        self.colCount = input.count
        
        input.enumerated().forEach { (i,line) in
            line.enumerated().forEach { (j,char) in
                let p = Point.init(x: i, y: j)
                grid[p] = Int(String(char))!
            }
        }
    }
    
    func debugPrint() {
        print("grid start")
        print("rc", separator: "", terminator: " ")
        (0 ..< rowCount).forEach {
            print($0, separator: " ", terminator: " ")
        }
        print("\n\n")
        for r in (0 ..< rowCount) {
            print(r, separator: " ", terminator: "  ")
            for c in (0 ..< colCount) {
                let p = Point(x: r, y: c)
                print(grid[p]!, separator: " ", terminator: " ")
            }
            print("\n")
        }
        print("grid end")
    }
    
    func adjacentValues(_ p: Point) -> [Int] {
        p.adjacent().compactMap { grid[$0] }
    }
    
    func neighbourValues(_ p: Point) -> [Int] {
        p.neighbours().compactMap { grid[$0] }
    }
}

