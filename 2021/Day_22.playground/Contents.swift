import Cocoa

let input = load(.input, runFromTerminal:true).trimmingCharacters(in: .newlines).components(separatedBy: .newlines)
//print(input)

extension String {
    var numbers: [Int] {
        split(whereSeparator: { "-0123456789".contains($0) == false })
            .map { Int($0)! }
    }
}

struct Point: CustomStringConvertible, Equatable, Hashable {
    var x: Int
    var y: Int
    var z: Int

    var description: String {
        get {
            return "X: \(self.x) Y: \(self.y) Z: \(self.z)"
        }
    }
}

func partOne() -> Int {
    var on: Set<Point> = []
    let allowed = -50 ... 50
    for line in input {
        let onStatus = line.components(separatedBy: " ")[0] == "on" ? true : false
        let ranges = line.components(separatedBy: " ")[1]
        let xr = String(ranges.split(separator: ",")[0]).numbers
        let yr = String(ranges.split(separator: ",")[1]).numbers
        let zr = String(ranges.split(separator: ",")[2]).numbers
        let xRange = min(xr[0], xr[1]) ... max(xr[0], xr[1])
        let yRange = min(yr[0], yr[1]) ... max(yr[0], yr[1])
        let zRange = min(zr[0], zr[1]) ... max(zr[0], zr[1])

        if xRange.allSatisfy({ allowed.contains($0)}) &&
            yRange.allSatisfy({ allowed.contains($0)}) &&
            zRange.allSatisfy({ allowed.contains($0)}) {
            for x in xRange {
                for y in yRange {
                    for z in zRange {
                        let p = Point.init(x: x, y: y, z: z)

                        if onStatus {
                            on.insert(p)
                        }
                        else {
                            on.remove(p)
                        }
                    }
                }
            }

        }
    }
    return on.count
}

func partTwo() -> Int {

    func intersection(between r1: ClosedRange<Int>, _ r2: ClosedRange<Int>) -> [Int]? {

        if r1.upperBound <= r2.lowerBound || r1.lowerBound >= r2.upperBound {
            return nil
        }
        let lower = max(r1.lowerBound, r2.lowerBound)
        let upper = min(r1.upperBound, r2.upperBound)
        return [lower,upper]
    }

    struct RebootStep {
        let status: Bool
        let xr: [Int]
        let yr: [Int]
        let zr: [Int]

        func sub(_ step: RebootStep) -> RebootStep? {
            let x = intersection(between: xRange, step.xRange)
            let y = intersection(between: yRange, step.yRange)
            let z = intersection(between: zRange, step.zRange)

            if let x = x, let y = y, let z = z {
                let s = RebootStep.init(status: status, xr: x, yr: y, zr: z)
                return s
            }

            return nil
        }

        var xRange: ClosedRange<Int> {
            min(xr[0], xr[1]) ... max(xr[0], xr[1])
        }
        var yRange: ClosedRange<Int> {
            min(yr[0], yr[1]) ... max(yr[0], yr[1])
        }
        var zRange: ClosedRange<Int> {
            min(zr[0], zr[1]) ... max(zr[0], zr[1])
        }

        var volume: Int {
            xRange.count * yRange.count * zRange.count
        }
    }

    var steps: [RebootStep] = []

    for line in input {
        let onStatus = line.components(separatedBy: " ")[0] == "on" ? true : false
        let ranges = line.components(separatedBy: " ")[1]
        let xr = String(ranges.split(separator: ",")[0]).numbers
        let yr = String(ranges.split(separator: ",")[1]).numbers
        let zr = String(ranges.split(separator: ",")[2]).numbers

        let step = RebootStep.init(status: onStatus, xr: xr, yr: yr, zr: zr)
        steps.append(step)
    }


    func countOnCupid(_ step: RebootStep, _ rest: ArraySlice<RebootStep>) -> Int {
        var count = step.volume
        let intersection: [RebootStep] = rest.compactMap { $0.sub(step) }

        for (i,c) in intersection.enumerated() {
            count -= countOnCupid(c, intersection[i+1 ..< intersection.count])
        }

        return count
    }

    return steps.enumerated().compactMap { (i,step) -> Int? in
        if step.status {
            let rest = steps[i+1 ..< steps.count]
            return countOnCupid(step, rest)
        }
        return nil
    }.reduce(0, +)
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
