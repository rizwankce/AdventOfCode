import Cocoa

let input = load(.test).trimmingCharacters(in: .newlines).components(separatedBy: .newlines)

//print(input)
var graph: [String: [String]] = [:]

for line in input {
    let pair = line.split(separator: "-")
    let a = String(pair[0])
    let b = String(pair[1])

    var prev = graph[a, default: []]
    prev.append(b)
    graph[a] = prev
}

//print(graph)

func isSmall(_ node: String) -> Bool {
    return node.unicodeScalars.first!.value == node.lowercased().unicodeScalars.first!.value
}

func partOne() -> Int {
    func canProceed(_ node: String, visited: [String]) -> Bool {
        if ["start","end"].contains(node) {
            return true
        }

        if isSmall(node) && visited.filter({ $0 == node }).count == 1 {
            return false
        }
        return true
    }

    func path(_ node: String, _ visited: [String]) -> [[String]] {
        if !canProceed(node, visited: visited) {
            return []
        }

        if node == "start" && visited.contains("start") {
            return []
        }

        var visited = visited
        visited.append(node)

        if node == "end" {
            return [visited]
        }

        var next: [String] = []

        if graph[node] != nil {
            next.append(contentsOf: graph[node]!)
        }

        let val = graph.filter { $0.value.contains(node) }
        if val.count > 0 {
            next.append(contentsOf: val.keys)
        }

        var result: [[String]] = []

        for n in next {
            result.append(contentsOf: path(n, visited))
        }

        return result
    }

    let validPath = path("start", [])

    return validPath.count
}

func partTwo() -> Int {
    func canProceed(_ node: String, visited: [String]) -> Bool {
        let start = visited.filter { $0 == "start" }.count
        let end = visited.filter { $0 == "end" }.count

        if start > 1 {
            return false
        }

        if end > 1 {
            return false
        }


        if isSmall(node) {
            let times = visited.filter { $0 == node }.count
            var others: [Int] = []

            for v in visited {
                if isSmall(v) {
                    others.append(visited.filter { $0 == v }.count)
                }
            }

            if times == 0 {
                return true
            }
            else if others.contains(2) {
                return false
            }
            else {
                return true
            }
        }

        return true
    }

    func path(_ node: String, _ visited: [String]) -> [[String]] {
        if !canProceed(node, visited: visited) {
            return []
        }

        if node == "start" && visited.contains("start") {
            return []
        }

        var visited = visited
        visited.append(node)

        if node == "end" {
            return [visited]
        }

        var next: [String] = []

        if graph[node] != nil {
            next.append(contentsOf: graph[node]!)
        }

        let val = graph.filter { $0.value.contains(node) }
        if val.count > 0 {
            next.append(contentsOf: val.keys)
        }

        var result: [[String]] = []

        for n in next {
            result.append(contentsOf: path(n, visited))
        }

        return result
    }

    let validPath = path("start", [])
    return validPath.count
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

