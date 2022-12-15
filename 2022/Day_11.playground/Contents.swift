import Cocoa

let input = load(.input, runFromTerminal:true).trimmingCharacters(in: .newlines).components(separatedBy: "\n\n")

//print(input)

class Monkey: CustomStringConvertible {
    var description: String {
        //"\n" + line + "\n"
        items.map { String($0) }.joined(separator: " ")
    }
    
    let line: String
    var items: [Int] = []
    var operation: [String] = []
    var divideBy: Int
    var trueCase: Int
    var falseCase: Int
    var total: Int = 0
    
    init(_ line: String) {
        self.line = line
        var com = line.components(separatedBy: "\n")
        let itms = com[1].replacingOccurrences(of: "  Starting items: ", with: "").components(separatedBy: ", ")
        self.items = itms.compactMap { Int($0) }
        
        let op = com[2].replacingOccurrences(of: "  Operation: new = ", with: "").components(separatedBy: " ")
        self.operation = op
        self.divideBy = Int(com[3].replacingOccurrences(of: "  Test: divisible by ", with: ""))!
        self.trueCase = Int(com[4].replacingOccurrences(of: "    If true: throw to monkey ", with: ""))!
        self.falseCase = Int(com[5].replacingOccurrences(of: "    If false: throw to monkey ", with: ""))!
    }
    
    func play(_ item: Int, _ worry: Bool, _ d: Int) -> (Int,Int) {
        total += 1
        var result = 0
        if operation[0] == "old" && operation[2] == "old" && operation[1] == "*" {
            result = item * item
        }
        else {
            assert(operation[0] == "old")
            assert(["+", "*"].contains(operation[1]))
            let op = Int(operation[2])!
            switch operation[1] {
            case "+": result = item + op
            case "*": result = item * op
            default: fatalError("unknown operand")
            }
        }
        
        if worry {
            result %= d
        }
        else {
            result /= d
        }
        
        
        if result % divideBy == 0 {
            return (trueCase,result)
        }
        
        return (falseCase,result)
    }
}

func monkeyBusiness(_ round: Int, _ worry: Bool) -> CustomStringConvertible {
    var all: [Monkey] = []

    for line in input {
        all.append(Monkey(line))
    }
    
    let div = all.map { $0.divideBy }.reduce(1,*)

    for _ in 1...round {
        var idx = 0
        while idx < all.count {
            let monkey = all[idx]
            for item in monkey.items {
                let next = monkey.play(item,worry, worry ? div : 3)
                all[idx].items.remove(at: 0)
                all[next.0].items.append(next.1)
            }
            
            idx += 1
        }
    }

    return all.map { $0.total }.sorted(by: >)[0...1].reduce(1, *)
}

func partOne() -> CustomStringConvertible {
    monkeyBusiness(20,false)
}

func partTwo() -> CustomStringConvertible {
    monkeyBusiness(10_000,true)
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
