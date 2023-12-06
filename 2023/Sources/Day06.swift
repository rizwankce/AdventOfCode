import Algorithms

struct Day06: AdventDay {
    var data: String

    var input: [String] {
        data.lines
    }

    func getdistances(for time: Int) -> [Int] {
        var dists: [Int] = []
        for t in 0 ... time {
            if t == 0 {
                dists.append(t)
            }
            else {
                let d = time - t
                dists.append(t * d)
            }
        }
        return dists
    }

    func part1() -> Any {
        let time = input[0].numbers
        let record = input[1].numbers
        var beats: [Int] = []
        for (i,time) in time.enumerated() {
            beats.append(getdistances(for: time).filter { $0 > record[i] }.count)
        }
        return beats.reduce(1, *)
    }

    func part2() -> Any {
        let time = input[0].replacingOccurrences(of: " ", with: "").numbers.first!
        let dist = input[1].replacingOccurrences(of: " ", with: "").numbers.first!
        return getdistances(for: time).filter { $0 > dist }.count
    }
}
