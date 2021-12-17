import Cocoa

let input = """
target area: x=138..184, y=-125..-71
"""

struct Point: CustomStringConvertible, Equatable, Hashable {
    var x: Int
    var y: Int

    var description: String {
        get {
            return "(X:\(self.x) Y:\(self.y))"
        }
    }

    static let start = Point.init(x: 0, y: 0)
}

let x = input.components(separatedBy: " ")[2]
let y = input.components(separatedBy: " ")[3]

let xrange = x.dropFirst(2).components(separatedBy: "..").map { $0.replacingOccurrences(of: ",", with: "")}.map { Int($0)! }
let xs = xrange.first!
let xe = xrange.last!

let yrange = y.dropFirst(2).components(separatedBy: "..").map { Int($0)! }
let ys = yrange.first!
let ye = yrange.last!

var target: Set<Point> = []
(xs ... xe).forEach { x in
    (ys ... ye).forEach { y in
        target.insert(Point.init(x:x , y: y))
    }
}

func fire(_ prob: Point, _ vel: (Int,Int)) -> (Bool,Int) {
    var prob = prob
    var x = vel.0
    var y = vel.1
    var hit = false
    var maxY = 0

    while prob.x <= xe , prob.y >= ys  {
        prob.x += x
        prob.y += y

        maxY = max(prob.y, maxY)

        if x > 0 {
            x -= 1
        }
        if x < 0 {
            x += 1
        }
        
        y = y - 1

        if target.contains(prob) {
            hit = true
        }

        if hit {
            break
        }

        if prob.x > xe && prob.y < ys {
            break
        }
    }

    return (hit,maxY)
}

var height = 0
var count = 0

for x in 1 ... xe {
    for y in ys ... 1000 {
        let pair = fire(Point.start, (x,y))
        if pair.0 {
            count += 1
            height = pair.1 > height ? pair.1 : height
        }
    }
}

func partOne() -> Int {
    return height
}

func partTwo() -> Int {
    return count
}

print("Part One answer is: \(partOne())")
print("Part Two answer is: \(partTwo())")
