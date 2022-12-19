import Cocoa

let input = load(.input, runFromTerminal:false).trimmingCharacters(in: .newlines).components(separatedBy: .newlines)

//print(input)

struct Point: CustomStringConvertible, Equatable, Hashable {
    var x: Int
    var y: Int

    var description: String {
        get {
            return "(X:\(self.x) Y:\(self.y))"
        }
    }
}

extension Point {
    func distance(_ point: Point) -> Int {
        abs(x - point.x) + abs(y - point.y)
    }
}

func parseX(_ line: String) -> Int {
    Int(line.replacingOccurrences(of: "x=", with: "")
        .replacingOccurrences(of: ",", with: ""))!
}

func parseY(_ line: String) -> Int {
    Int(line.replacingOccurrences(of: "y=", with: "")
        .replacingOccurrences(of: ":", with: ""))!
}

var sb: [Point: Int] = [:]
var becans: [Point] = []
for line in input {
    let com = line.components(separatedBy: " ")
    let sx = parseX(com[2])
    let sy = parseY(com[3])
    let bx = parseX(com[8])
    let by = parseY(com[9])
    let s = Point(x: sx, y: sy)
    let b = Point(x: bx, y: by)
    sb[s] = s.distance(b)
    becans.append(b)
}

func partOne() -> CustomStringConvertible {
    let yLimit = 2_000_000
    var validRanges: [ClosedRange<Int>] = []
    for pair in sb {
        let s = pair.key
        let d = pair.value
        let range = d - abs(s.y - yLimit)
        if range > 0 {
            let r = s.x - range ... s.x + range
            validRanges.append(r)
        }
    }

    let mx = validRanges.min { r1, r2 in
        r1.lowerBound < r2.lowerBound
    }!.lowerBound
    let my = validRanges.max { r1, r2 in
        r1.upperBound < r2.upperBound
    }!.upperBound
    
    var ans = 0
    for x in mx ... my {
        var valid = false
        for r in validRanges {
            let p = Point.init(x: x, y: yLimit)
            if r.contains(x) && !becans.contains(p) {
                valid = true
            }
        }
        if valid {
            ans += 1
        }
    }
    
    return ans
}

func partTwo() -> CustomStringConvertible {
    let limit = 0 ... 4000000

    func validRanges(for yLimit: Int) -> [ClosedRange<Int>] {
        var validRanges: [ClosedRange<Int>] = []
        for pair in sb {
            let s = pair.key
            let d = pair.value
            let range = d - abs(s.y - yLimit)
            if range > 0 {
                let r = s.x - range ... s.x + range
                validRanges.append(r)
            }
        }
        validRanges = validRanges.compactMap { $0.clamped(to: limit) }

        return validRanges
    }
    
    var result = 0
    for y in 0 ... 4000000 {
        let ranges = validRanges(for: y)
        let intervals = combinedIntervals(intervals: ranges)
        if intervals.first?.count != 4000001 {
            let r = intervals.map(\.upperBound).sorted().first
            result = (r!+1)*4000000 + y
            break
        }
    }
    
    return result
}


func combinedIntervals(intervals: [CountableClosedRange<Int>]) -> [CountableClosedRange<Int>] {
    
    var combined = [CountableClosedRange<Int>]()
    var accumulator = (0...0) // empty range
    
    for interval in intervals.sorted(by: { $0.lowerBound  < $1.lowerBound  } ) {
        
        if accumulator == (0...0) {
            accumulator = interval
        }
        
        if accumulator.upperBound >= interval.upperBound {
            // interval is already inside accumulator
        }
            
        else if accumulator.upperBound >= interval.lowerBound  {
            // interval hangs off the back end of accumulator
            accumulator = (accumulator.lowerBound...interval.upperBound)
        }
            
        else if accumulator.upperBound <= interval.lowerBound  {
            // interval does not overlap
            combined.append(accumulator)
            accumulator = interval
        }
    }
    
    if accumulator != (0...0) {
        combined.append(accumulator)
    }
    
    return combined
}



print("Part One answer is: \(partOne())")
print("Part Two answer is: \(partTwo())")

enum PuzzleInput: String {
    case input = "input"
    case test  = "test_input"
}

func load(_ input: PuzzleInput, runFromTerminal: Bool = false) -> String {
    switch input {
    case .input:
        return load(file: "input", runFromTerminal)
    default:
        return load(file: "test_input", runFromTerminal)
    }
}

func load(file name: String, _ runFromTerminal: Bool = false) -> String {

    if runFromTerminal {
        let projectURL = URL(fileURLWithPath: #file)
                .deletingLastPathComponent()
                .appendingPathComponent("Resources")
        let fileURL = projectURL.appendingPathComponent(name+".txt")
        guard let content = try? String(contentsOf: fileURL, encoding: .utf8) else {
            fatalError("Cannot convert file contents to string for file :\(name)")
        }

        return content
    }

    guard let url = Bundle.main.url(forResource: name, withExtension: "txt") else {
        fatalError("Cannot load file with name :\(name)")
    }

    guard let content = try? String(contentsOf: url, encoding: .utf8) else {
        fatalError("Cannot convert file contents to string for file :\(name)")
    }

    return content
}
