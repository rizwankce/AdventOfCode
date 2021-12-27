import Cocoa
import Foundation

var input = """
Step Y must be finished before step A can begin.
Step O must be finished before step C can begin.
Step P must be finished before step A can begin.
Step D must be finished before step N can begin.
Step T must be finished before step G can begin.
Step L must be finished before step M can begin.
Step X must be finished before step V can begin.
Step C must be finished before step R can begin.
Step G must be finished before step E can begin.
Step H must be finished before step N can begin.
Step Q must be finished before step B can begin.
Step S must be finished before step R can begin.
Step M must be finished before step F can begin.
Step N must be finished before step Z can begin.
Step E must be finished before step I can begin.
Step A must be finished before step R can begin.
Step Z must be finished before step F can begin.
Step K must be finished before step V can begin.
Step I must be finished before step J can begin.
Step R must be finished before step W can begin.
Step B must be finished before step J can begin.
Step W must be finished before step V can begin.
Step V must be finished before step F can begin.
Step U must be finished before step F can begin.
Step F must be finished before step J can begin.
Step X must be finished before step C can begin.
Step T must be finished before step Q can begin.
Step B must be finished before step F can begin.
Step Y must be finished before step L can begin.
Step P must be finished before step E can begin.
Step A must be finished before step J can begin.
Step S must be finished before step I can begin.
Step S must be finished before step A can begin.
Step K must be finished before step R can begin.
Step D must be finished before step C can begin.
Step R must be finished before step U can begin.
Step K must be finished before step U can begin.
Step D must be finished before step K can begin.
Step S must be finished before step M can begin.
Step D must be finished before step E can begin.
Step A must be finished before step K can begin.
Step G must be finished before step I can begin.
Step O must be finished before step M can begin.
Step U must be finished before step J can begin.
Step T must be finished before step S can begin.
Step C must be finished before step M can begin.
Step S must be finished before step J can begin.
Step N must be finished before step V can begin.
Step P must be finished before step N can begin.
Step D must be finished before step M can begin.
Step A must be finished before step B can begin.
Step Z must be finished before step R can begin.
Step T must be finished before step N can begin.
Step K must be finished before step J can begin.
Step N must be finished before step A can begin.
Step M must be finished before step R can begin.
Step E must be finished before step A can begin.
Step Y must be finished before step O can begin.
Step O must be finished before step B can begin.
Step O must be finished before step A can begin.
Step I must be finished before step V can begin.
Step M must be finished before step Z can begin.
Step D must be finished before step U can begin.
Step O must be finished before step S can begin.
Step Z must be finished before step W can begin.
Step M must be finished before step A can begin.
Step N must be finished before step E can begin.
Step M must be finished before step U can begin.
Step R must be finished before step J can begin.
Step W must be finished before step F can begin.
Step I must be finished before step U can begin.
Step E must be finished before step U can begin.
Step Y must be finished before step R can begin.
Step Z must be finished before step K can begin.
Step C must be finished before step F can begin.
Step B must be finished before step V can begin.
Step G must be finished before step B can begin.
Step O must be finished before step G can begin.
Step E must be finished before step Z can begin.
Step A must be finished before step V can begin.
Step Y must be finished before step Q can begin.
Step P must be finished before step D can begin.
Step X must be finished before step G can begin.
Step I must be finished before step W can begin.
Step M must be finished before step V can begin.
Step T must be finished before step M can begin.
Step G must be finished before step J can begin.
Step T must be finished before step I can begin.
Step H must be finished before step B can begin.
Step C must be finished before step E can begin.
Step Q must be finished before step V can begin.
Step H must be finished before step U can begin.
Step X must be finished before step K can begin.
Step D must be finished before step T can begin.
Step X must be finished before step W can begin.
Step P must be finished before step Z can begin.
Step C must be finished before step U can begin.
Step Y must be finished before step Z can begin.
Step L must be finished before step F can begin.
Step C must be finished before step J can begin.
Step T must be finished before step W can begin.
""".components(separatedBy: .newlines)

var graph: [String: Set<String>] = [:]
var all: Set<String> = []

for line in input {
    let a = String(line.split(separator: " ")[1])
    let b = String(line.split(separator: " ")[7])

    all.insert(a)
    all.insert(b)

    if graph.filter({ $0.key.contains(a) }).count == 0 {
        graph[a] = []
    }

    var ex = graph[b,default: []]
    ex.insert(a)
    graph[b] = ex
}

//print(graph)

func partOne() -> String {
    func solve(_ completed: inout [String]) {
        let next = graph.filter { $0.value.isSubset(of: completed) && !completed.contains($0.key) }

        for char in next.keys.sorted() {
            if !completed.contains(char) {
                completed.append(char)
                solve(&completed)
            }
        }
    }
    var completed: [String] = []
    solve(&completed)
    return completed.joined()
}

extension String {
    func workTime() -> Int {
        Int(unicodeScalars.first!.value) - 4
    }
}

func partTwo() -> Int {
    let workerCount = 5
    var workers: [(String,Int)] = Array.init(repeating: ("0",0), count: workerCount)

    func nextWork(_ completed: [String]) -> [String] {
        graph.filter { $0.value.isSubset(of: completed) && !completed.contains($0.key) }.keys.map { $0 }.sorted()
    }


    var completed: [String] = []
    var pending: [String] = []
    var result = 0
    for sec in 0... {
        for (index,worker) in workers.enumerated() {
            if worker.0 != "0" { // free
                if worker.1 == sec { // completed
                    completed.append(worker.0)
                    pending.removeAll { $0 == worker.0 }
                    workers[index].0 = "0"
                    workers[index].1 = 0
                }
            }
        }

        let nextWork = nextWork(completed).filter { (pending.contains($0) || completed.contains($0)) == false }
        for work in nextWork {
            if let freeWorkerIndex = workers.firstIndex(where: { $0.0 == "0" }) {
                workers[freeWorkerIndex] = (work, sec + work.workTime())
                pending.append(work)
            }
            else {
                break
            }
        }

        if workers.allSatisfy({ $0.0 == "0" }){
            result = sec
            break
        }
    }


    return result
}


print("Part 1 answer is \(partOne())")
print("Part 2 answer is \(partTwo())")
