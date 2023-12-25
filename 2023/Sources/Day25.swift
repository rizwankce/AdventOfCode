import Algorithms

struct Day25: AdventDay {
    var data: String

    var input: [String] {
        data.lines
    }

    class Graph {
        struct Edge: Hashable {
            let node1: String
            let node2: String
        }

        var adjacencyList: [String: Set<String>] = [:]

        func addEdge(_ node1: String, _ node2: String) {
            adjacencyList[node1, default: []].insert(node2)
            adjacencyList[node2, default: []].insert(node1)
        }

        func removeEdge(_ node1: String, _ node2: String) {
            adjacencyList[node1]?.remove(node2)
            adjacencyList[node2]?.remove(node1)
        }

        func minimumEdgeCut() -> [Int] {
            var minCutSizes: [Int] = []
            let allEdges = adjacencyList.flatMap { node, neighbors in
                neighbors.map { neighbor in Edge(node1: node, node2: neighbor) }
            }
            print(allEdges.combinations(ofCount: 3).count)
            outer: for (i, pairs) in allEdges.combinations(ofCount: 3).enumerated() {
                if i % 1_000_000 == 0 {
                    print(i)
                }
                pairs.forEach({
                    removeEdge($0.node1, $0.node2)
                })

                let components = connectedComponents()
                if components.count == 2 {
                    components.forEach({ minCutSizes.append($0.count) })
                    break outer
                }
                pairs.forEach({
                    addEdge($0.node1, $0.node2)
                })
            }
            return minCutSizes
        }

        func connectedComponents() -> [[String]] {
            var visited: Set<String> = []
            var components: [[String]] = []

            for node in adjacencyList.keys {
                if !visited.contains(node) {
                    var component: [String] = []
                    dfs(node, visited: &visited, component: &component)
                    components.append(component)
                }
            }

            return components
        }

        private func dfs(_ node: String, visited: inout Set<String>, component: inout [String]) {
            visited.insert(node)
            component.append(node)

            if let neighbors = adjacencyList[node] {
                for neighbor in neighbors {
                    if !visited.contains(neighbor) {
                        dfs(neighbor, visited: &visited, component: &component)
                    }
                }
            }
        }
    }

    func parse() -> Graph {
        // jqt: rhn xhk nvd
        var graph = Graph()
        var all: [String] = []
        var map: [String: String] = [:]
        for line in input {
            let com = line.components(separatedBy: ": ")
            let left = com[0]
            let right = com[1].components(separatedBy: " ")
            print(left, right)
            all.append(left)
            all.append(contentsOf: right)

            right.forEach({
                graph.addEdge(left, $0)
                map[left] = $0
            })
            right.forEach({
                map[$0] = left
                graph.addEdge($0, left)
            })
        }
        return graph
    }

    func part1() -> Any {
        return parse().minimumEdgeCut().reduce(1, *)
    }

    func part2() -> Any {
        return ""
    }
}
