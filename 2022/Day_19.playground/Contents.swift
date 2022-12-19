import Cocoa

let input = load(.input, runFromTerminal:true).trimmingCharacters(in: .newlines).components(separatedBy: .newlines)

//print(input)

struct State: Hashable {
    
    var ore: Int
    var clay: Int
    var obsidian: Int
    var geodoes: Int
    var oreCount: Int
    var clayCount: Int
    var obsidianCount: Int
    var geodoesCount: Int
    var time: Int
    
    func nextEmptyState() -> State {
        var copy = self
        copy.ore = ore + oreCount
        copy.clay = clay + clayCount
        copy.obsidian = obsidian + obsidianCount
        copy.geodoes = geodoes + geodoesCount
        copy.time = time - 1
        return copy
    }
    
    func buyOre(_ cost: Int) -> State {
        var copy = self
        copy.ore = ore - cost + oreCount
        copy.clay = clay + clayCount
        copy.obsidian = obsidian + obsidianCount
        copy.geodoes = geodoes + geodoesCount
        copy.oreCount = oreCount + 1
        copy.time = time - 1
        return copy
    }
    
    func buyClay(_ cost: Int) -> State {
        var copy = self
        copy.ore = ore - cost + oreCount
        copy.clay = clay + clayCount
        copy.obsidian = obsidian + obsidianCount
        copy.geodoes = geodoes + geodoesCount
        copy.clayCount = clayCount + 1
        copy.time = time - 1
        return copy
    }
    
    func buyObsidian(_ oCost: Int, _ cCost: Int) -> State {
        var copy = self
        copy.ore = ore - oCost + oreCount
        copy.clay = clay - cCost + clayCount
        copy.obsidian = obsidian + obsidianCount
        copy.geodoes = geodoes + geodoesCount
        copy.obsidianCount = obsidianCount + 1
        copy.time = time - 1
        return copy
    }
    
    func buyGeodo(_ oCost: Int, _ obCost: Int) -> State {
        var copy = self
        copy.ore = ore - oCost + oreCount
        copy.clay = clay + clayCount
        copy.obsidian = obsidian - obCost + obsidianCount
        copy.geodoes = geodoes + geodoesCount
        copy.geodoesCount = geodoesCount + 1
        copy.time = time - 1
        return copy
    }
    
}

var cache: [State: Int] = [:]

class BluePrint: CustomStringConvertible {
    var description: String {
        "\(id) : \(costs)"
    }
    
    let id: Int
    let costs: [Int]
    
    init(_ line: String) {
        let com = line.components(separatedBy: " ")
        let cost = com.compactMap(Int.init)
        self.costs = cost
        self.id = Int(com[1].replacingOccurrences(of: ":", with: ""))!
    }
    
    func bfs(_ timeLimit: Int) -> Int {
        var best = 0
        
        let start = State(ore: 0, clay: 0, obsidian: 0, geodoes: 0, oreCount: 1, clayCount: 0, obsidianCount: 0, geodoesCount: 0, time: timeLimit)
        
        var queue: [State] = [start]
        var visited: Set<State> = []
        
        while !queue.isEmpty {
            var state = queue.removeFirst()
            best = max(best,state.geodoes)
            
            if cache.keys.contains(state) {
                best = max(best, cache[state]!)
                continue
            }
            
            if state.time == 0 {
                continue
            }
            
            if state.geodoesCount >= costs[5] {
                state.clayCount = 0
            }
            
            let check = max(costs[0], max(costs[1], max(costs[2], costs[4])))
            state.oreCount = min(check, state.oreCount)
            state.clayCount = min(state.clayCount, costs[3])
            state.obsidianCount = min(state.obsidianCount, costs[5])
            state.ore = min(state.ore, (state.time * check - state.oreCount * (state.time - 1)))
            state.clay = min(state.clay, (state.time * costs[3] - state.clayCount * (state.time - 1)))
            state.obsidian = min(state.obsidian, (state.time * costs[5] - state.obsidianCount * (state.time - 1)))
            
            if visited.contains(state) {
                continue
            }
            visited.insert(state)
        
            queue.append(state.nextEmptyState())
        
            if state.ore >= costs[0] {
                queue.append(state.buyOre(costs[0]))
            }
            
            if state.ore >= costs[1] {
                queue.append(state.buyClay(costs[1]))
            }
            
            if state.ore >= costs[2] && state.clay >= costs[3] {
                queue.append(state.buyObsidian(costs[2], costs[3]))
            }
            
            if state.ore >= costs[4] && state.obsidian >= costs[5] {
                queue.append(state.buyGeodo(costs[4], costs[5]))
            }
         
        }
        return best
    }
    
    func fastBfs(_ timeLimit: Int) -> Int {
//        print(self)

        var best = 0
        
        /*
         ore = 0
         clay = 1
         ob = 2
         geo = 3
         oreC = 4
         clayC = 5
         obC = 6
         geoC = 7
         t = 8
         */
        
        let start = [0,0,0,0,1,0,0,0,timeLimit]
        
        var queue: [[Int]] = [start]
        var visited: Set<[Int]> = []
        var maxG: Int = 0
        
        while !queue.isEmpty {
            var state = queue.removeFirst()
            best = max(best,state[3])
            maxG = max(state[3]+state[7]+state[7]*(timeLimit-1-state[8]), maxG)
            
            if state[8] == 0 {
                continue
            }
                    
            let check = max(costs[0], max(costs[1], max(costs[2], costs[4])))
            
            state[4] = min(state[4],check)
            state[5] = min(state[5],costs[3])
            state[6] = min(state[6],costs[5])
            state[0] = min(state[0], (state[8] * check - state[4] * (state[8] - 1)))
            state[1] = min(state[1], (state[8] * costs[3] - state[5] * (state[8] - 1)))
            state[2] = min(state[2], (state[8] * costs[5] - state[6] * (state[8] - 1)))
            
            if visited.contains(state) {
                continue
            }
            visited.insert(state)
        
            if state[3]+state[7]*2*(timeLimit-1-state[8]) < maxG {
                continue
            }
                        
            queue.append([
                state[0]+state[4],
                state[1]+state[5],
                state[2]+state[6],
                state[3]+state[7],
                state[4],state[5],state[6],state[7],
                state[8]-1
            ])
        
            if queue.count % 10_000 == 0 {
//                print(state[8], best, queue.count)
            }
            
            if state[0] >= costs[0] {
                queue.append([
                    state[0]-costs[0]+state[4],
                    state[1]+state[5],
                    state[2]+state[6],
                    state[3]+state[7],
                    state[4]+1,state[5],state[6],state[7],
                    state[8]-1
                ])
            }
            
            if state[0] >= costs[1] {
                queue.append([
                    state[0]-costs[1]+state[4],
                    state[1]+state[5],
                    state[2]+state[6],
                    state[3]+state[7],
                    state[4],state[5]+1,state[6],state[7],state[8]-1
                ])
            }
            
            if state[0] >= costs[2] && state[1] >= costs[3] {
                queue.append([
                    state[0]-costs[2]+state[4],
                    state[1]-costs[3]+state[5],
                    state[2]+state[6],
                    state[3]+state[7],
                    state[4],state[5],state[6]+1,state[7],
                    state[8]-1
                ])
            }
            
            if state[0] >= costs[4] && state[2] >= costs[5] {
                queue.append([
                    state[0]-costs[4]+state[4],
                    state[1]+state[5],
                    state[2]-costs[5]+state[6],
                    state[3]+state[7],
                    state[4],state[5],state[6],state[7]+1,
                    state[8]-1
                ])
            }
        }
        return best
    }
    
    func simulate(_ time: Int) -> Int {
//        bfs(time)
        fastBfs(time)
    }

}

var blueprints: [BluePrint] = []
for line in input {
    let bp = BluePrint(line)
    blueprints.append(bp)
}

func partOne() -> CustomStringConvertible {
    blueprints.map { $0.id * $0.simulate(24) }.reduce(0, +)
}

func partTwo() -> CustomStringConvertible {
    blueprints.dropLast(blueprints.count - 3).map { $0.simulate(32) }.reduce(1, *)
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
    
