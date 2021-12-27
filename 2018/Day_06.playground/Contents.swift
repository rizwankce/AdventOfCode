import Cocoa

var input = """
158, 163
287, 68
76, 102
84, 244
162, 55
272, 335
345, 358
210, 211
343, 206
219, 323
260, 238
83, 94
137, 340
244, 172
335, 307
52, 135
312, 109
276, 93
288, 274
173, 211
125, 236
200, 217
339, 56
286, 134
310, 192
169, 192
313, 106
331, 186
40, 236
194, 122
244, 76
159, 282
161, 176
262, 279
184, 93
337, 284
346, 342
283, 90
279, 162
112, 244
49, 254
63, 176
268, 145
334, 336
278, 176
353, 135
282, 312
96, 85
90, 105
354, 312
""".components(separatedBy: .newlines)

extension String {
    func integers() -> [Int] {
        return self.split { (char) -> Bool in
            !"-0123456789".contains(char)
        }.map{ Int(String($0))! }
    }
}

struct Point: CustomStringConvertible {
    let x: Int
    let y: Int

    var description: String {
        get {
            return "X:\(x) Y:\(y)"
        }
    }

    func distance(_ point: Point) -> Int {
        return abs(x - point.x) + abs(y - point.y)
    }
}
var points: [Point] = []
for line in input {
    let p = line.integers()
    points.append(Point.init(x: p[0], y: p[1]))
}

var maxX = points.max { (p1, p2) -> Bool in
    p1.x < p2.x
}!.x
var maxY = points.max { (p1, p2) -> Bool in
    p1.y < p2.y
}!.y

func grid(_ length: Int) -> [Int: Int] {
    var board: [Int: Int] = [:]
    for i in 0 ... length {
        for j in 0 ... length {
            let currentP = Point.init(x: i - length/2, y: j - length/2)
            var distances: [(Int,Int)] = []
            distances = points.enumerated().map { ($0,$1.distance(currentP))}
            let closest = distances.min { (d1, d2) -> Bool in
                d1.1 < d2.1
            }
            let count = distances.filter { (dist) -> Bool in
                dist.1 == closest!.1
            }.count

            if count == 1 {
                let id = closest!.0
                board[id] = board[id, default:0] + 1
            }
        }
    }
    print(board.sorted(by: { (d1, d2) -> Bool in
        d1.key < d2.key
    }))
    return board
}

func partOne() -> String {
    let gridA = grid(1000)
    let gridB = grid(1200)
    var finite: [Int] = []
    gridA.values.forEach { (k1) in
        gridB.values.forEach { (k2) in
            if k1 == k2 {
                finite.append(k1)
            }
        }
    }

    print(finite)
    return finite.max()?.description ?? ""
}

func partTwo() -> String {
    var result: [Int] = []
    let length = 1200
    for i in 0 ... length {
        for j in 0 ... length {
            let currentP = Point.init(x: i - length/2, y: j - length/2)
            let distances = points.map { $0.distance(currentP) }
            let total = distances.reduce(0,+)
            if total < 10000 {
                result.append(total)
            }
        }
    }
    print(result.count)
    return result.count.description
}


print("Part 1 answer is \(partOne())")
print("Part 2 answer is \(partTwo())")
