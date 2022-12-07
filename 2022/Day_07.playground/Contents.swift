import Cocoa

let input = load(.input, runFromTerminal:false).trimmingCharacters(in: .newlines).components(separatedBy: .newlines)

public class Directory<T> {
    public var value: T
    
    public weak var parent: Directory?
    public var children = [Directory<T>]()
    public var files: [String: Int] = [:]
    
    public init(value: T) {
        self.value = value
    }
    
    public func addChild(_ node: Directory<T>) {
        children.append(node)
        node.parent = self
    }
}

extension Directory {
    public func sizes() -> [Int] {
        [totalSize()] + children.flatMap { $0.sizes() }
    }
    
    public func totalSize() -> Int {
        return files.values.reduce(0, +) + children.map { $0.totalSize() }.reduce(0, +)
    }
}

extension Directory where T: Equatable {
    func search(_ value: T) -> Directory? {
        if value == self.value {
            return self
        }
        for child in children {
            if let found = child.search(value) {
                return found
            }
        }
        return nil
    }
}

extension Directory: CustomStringConvertible {
    public var description: String {
        var s = "\(value)"
        if !children.isEmpty {
            s += " {" + children.map { $0.description }.joined(separator: ", ") + "}"
        }
        return s
    }
}

let root: Directory<String> = Directory.init(value: "/")
var cur = root

var curDir: [String] = ["/"]
var allDir: [String] = ["/"]
var allFiles: [String] = []

for line in input {
    let words = line.components(separatedBy: " ")
    
    if words[0] == "$" {
        if words[1] == "ls" {
            continue
        }
        else if words[2] == ".." {
            cur = cur.parent!
            curDir.removeLast()
        }
        else {
            let dir = words[2]
            curDir.append(dir)
            assert([0,1].contains(cur.children.filter  { $0.value == curDir.joined(separator: "/") + dir } .count))
            if let ex = cur.children.first(where: { $0.value == curDir.joined(separator: "/") + dir }) {
                cur = ex
            }
            else {
                let new = Directory.init(value: curDir.joined(separator: "/") + dir)
                cur.addChild(new)
                cur = new
            }
            allDir.append(curDir.joined(separator: "/") + dir)
        }
    }
    else if words[0] == "dir" {
        continue
    }
    else  {
        let name = line.components(separatedBy: " ")[1]
        let size = Int(line.components(separatedBy: " ")[0])!
        cur.files[curDir.joined(separator: "/") + name] = size
        allFiles.append(name)
    }
}
assert(allDir.count == Set(allDir).count)

func partOne() -> Int {
    return root.sizes().filter { $0 <= 100_000 }.reduce(0, +)
}

func partTwo() -> Int {
    let unused = 70_000_000 - root.totalSize()
    let need = 30_000_000 - unused
    
    return root.sizes().filter { $0 >= need }.min()!
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
