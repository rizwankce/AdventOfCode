import Cocoa

let input = load(.input, runFromTerminal:true).trimmingCharacters(in: .newlines).components(separatedBy: .newlines).compactMap(Int.init)

//print(input)

func findCord(_ queue: [(Int,Int)]) -> [(Int,Int)] {
    var queue = queue
    for i in 0 ..< queue.count {
        while queue[0].0 != i {
            queue.append(queue.removeFirst())
        }
        let cur = queue.removeFirst()
        var removed = cur.1
        if removed == 0 {
            queue.append(cur)
            continue
        }
        
        if removed < 0 {
            removed += 10_000_000_000*queue.count
//            while removed < 0 {
//                removed += (queue.count)
//            }
        }
        let range = removed % queue.count
        (0 ..< range).forEach { _ in
            queue.append(queue.removeFirst())
        }
        queue.append(cur)
    }
    return queue
}

func sum(_ queue: [(Int,Int)]) -> Int {
    var result = 0
    for i in queue.indices {
        let c = queue[i]
        if c.1 == 0 {
            let idx1 = (i + 1000) % queue.count
            let idx2 = (i + 2000) % queue.count
            let idx3 = (i + 3000) % queue.count
            result = queue[idx1].1 + queue[idx2].1 + queue[idx3].1
            break
        }
    }
    return result
}

func partOne() -> CustomStringConvertible {
    var queue: [(Int,Int)] = []
    for (i,v) in input.enumerated() {
        queue.append((i,v))
    }
    queue = findCord(queue)
    return sum(queue)
}

func partTwo() -> CustomStringConvertible {
    var queue: [(Int,Int)] = []
    for (i,v) in input.enumerated() {
        queue.append((i,v*811589153))
    }
    for _ in 1...10 {
        queue = findCord(queue)
    }
    return sum(queue)
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
