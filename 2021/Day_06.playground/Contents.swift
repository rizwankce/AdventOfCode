import Cocoa

let input = load(.input).trimmingCharacters(in: .newlines).components(separatedBy: ",").map { Int($0)! }

func solve(_ fishes: [Int], _ days: Int) -> Int {
    var fish: [Int: Int] = [:]

    for f in fishes {
        fish[f,default: 0] += 1
    }

    for _ in 0 ..< days {
        var next: [Int: Int] = [:]
        for (i, n) in fish {
            if i == 0 {
                next[6, default: 0] += n
                next[8, default: 0] += n
            }
            else {
                next[i-1,default: 0] += n
            }
        }
        fish = next
    }
    return fish.values.reduce(0, +)
}

func partOneOld() -> Int {
    var fishes: [Int] = input

    for _ in (0 ..< 256) {
        var new = fishes
        fishes.enumerated().forEach { i,fish in
            if fish == 0 {
                new[i] = 6
                new.append(8)
            }
            else {
                new[i] = fish - 1
            }
        }
        fishes = new
    }
    return fishes.count
}

func partOne() -> Int {
    return solve(input, 80)
}

func partTwo() -> Int {
    return solve(input, 256)
}

print("Part One answer is: \(partOne())")
print("Part Two answer is: \(partTwo())")

enum PuzzleInput: String {
    case input = "input"
    case test  = "test_input"
}

func load(_ input: PuzzleInput) -> String {
    switch input {
    case .input:
        return load(file: "input")
    default:
        return load(file: "test_input")
    }
}

func load(file name: String) -> String {
    guard let url = Bundle.main.url(forResource: name, withExtension: "txt") else {
        fatalError("Cannot load file with name :\(name)")
    }

    guard let content = try? String(contentsOf: url, encoding: .utf8) else {
        fatalError("Cannot convert file contents to string for file :\(name)")
    }

    return content
}

