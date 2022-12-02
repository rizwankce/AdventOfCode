import Cocoa

let input = """
4    10    4    1    8    4    9    14    5    1    14    15    0    15    3    5
""".components(separatedBy: "    ").compactMap { Int(String($0))}
print(input)
func partOne() -> Int {
    var input = input
    var result = 0
    var seen: Set<[Int]> = []
    while true {
        let max = input.max()!
        let i = input.firstIndex(of: max)!
        input[i] = 0
        for n in 1 ... max {
            var ni = i + n
            if ni >= input.count {
                ni = ni % input.count
            }
            input[ni] += 1
        }
        
        print(input)
        
        result += 1
        if !seen.insert(input).inserted {
            break
        }
    }
   
    return result
}

func partTwo() -> Int {
    var input = input
    var result = 0
    var seen: Set<[Int]> = []
    var first = false
    var sv: [Int] = []
    while true {
        let max = input.max()!
        let i = input.firstIndex(of: max)!
        input[i] = 0
        for n in 1 ... max {
            var ni = i + n
            if ni >= input.count {
                ni = ni % input.count
            }
            input[ni] += 1
        }
        
        print(input)
        
        result += 1
        if !seen.insert(input).inserted {
            if first == false {
                first = true
                result = 0
                sv = input
            }
            else if sv == input {
                break
            }
        }
    }
   
    return result
}

print("Part One answer is: \(partOne())")
print("Part Two answer is: \(partTwo())")
