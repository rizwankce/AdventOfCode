import Cocoa

let input = """
<x=17, y=5, z=1>
<x=-2, y=-8, z=8>
<x=7, y=-6, z=14>
<x=1, y=-10, z=4>
""".components(separatedBy: "\n")

let pattern = "<x=(.+), y=(.+), z=(.+)>"
let regex = try? NSRegularExpression(pattern: pattern, options: [])

var vectors = input.map { line -> [Int] in
    if let match = regex?.firstMatch(in: line, options: [], range: NSRange.init(location: 0, length: line.utf8.count)) {
        if let x = Range(match.range(at: 1), in: line),
            let y = Range(match.range(at: 2), in: line),
            let z = Range(match.range(at: 3), in: line) {
            return [Int(line[x])!, Int(line[y])!, Int(line[z])!]
        }
    }
    return []
}

print(vectors)

func gcd(_ num1: Int, _ num2: Int) -> Int {
    
    let remainder = num1 % num2
    if remainder != 0 {
        return gcd(num2, remainder)
    } else {
        return num2
    }
}

func lcm(_ x: Int, _ y: Int, z: Int) -> Int {
    let xy = x * y / gcd(x, y)
    return xy * z / gcd(xy, z)
}
func compare(_ arr1: [Int], _ arr2: [Int]) -> Bool {
    return arr1.elementsEqual(arr2)
}

class Simulator {
    var mPositions: [[Int]] = []
    var vectors: [[Int]] = []
    var vel: [[Int]] = [[0,0,0],[0,0,0],[0,0,0],[0,0,0]]
    var total = 0
    
    init(_ v: [[Int]]) {
        self.vectors = v
        self.mPositions = v
    }
    
    func step(count: Int) {
        for _ in 0 ... count - 1 {
            step()
        }
    }
    
    func getTotalEnergy() -> Int {
        var p1 = 0
        for i in 0 ... vectors.count - 1  {
            var pot = 0
            var kin = 0
            for k in 0 ... vectors[i].count - 1 {
                pot += abs(vectors[i][k])
                kin += abs(vel[i][k])
            }
            p1 += pot*kin
        }
        
        print(vel)
        print(p1)
        total += 1
        return p1
    }
    
    func step() {
        for i in 0 ... vectors.count - 1 {
            for j in 0 ... vectors.count - 1  {
                for k in 0 ... vectors[i].count - 1 {
                    //print("\(i) \(j) \(k)")
                    if vectors[i][k] < vectors[j][k] {
                        vel[i][k] += 1
                    }
                    else if vectors[i][k] > vectors[j][k] {
                        vel[i][k] -= 1
                    }
                }
            }
        }
        for i in 0 ... vectors.count - 1 {
            for k in 0 ... vectors[i].count - 1 {
                vectors[i][k] += vel[i][k]
            }
        }
    }

    func check(_ ps: [Int], _ vs: [Int], _ cps: [Int], _ cvs: [Int], _ r: Int) -> Int {
        if compare(ps, cps) && compare(vs, cvs) {
            return r
        }
        return -1
    }

    func getSteps() -> Int {
        var done = false
        var r = 0

        let xps = mPositions.map{ pos in return pos[0] }
        let yps = mPositions.map{ pos in return pos[1] }
        let zps = mPositions.map{ pos in return pos[2] }
        let xvs = [0,0,0,0]
        let yvs = [0,0,0,0]
        let zvs = [0,0,0,0]
        
        var xf = -1
        var yf = -1
        var zf = -1
        
        while !done {
            r += 1
            step()
            if xf == -1 {
                xf = check(xps,xvs,vectors.map{ p in return p[0]},vel.map{ p in p[0] }, r)
            }
            if yf == -1 {
                yf = check(yps,yvs,vectors.map{ p in return p[1]},vel.map{ p in p[1] }, r)
            }
            if zf == -1 {
                zf = check(zps,zvs,vectors.map{ p in return p[2]},vel.map{ p in p[2] }, r)
            }

            if xf != -1 && yf != -1 && zf != -1 {
                done = true
            }
            print("\(xf) \(yf) \(zf)")
        }

        return lcm(xf, yf, z: zf)
    }
}



func partOne() {
    let sim = Simulator(vectors)
    sim.step(count: 1000)
    print("Part 1 answer is :\(sim.getTotalEnergy())")
}

func partTwo() {
    let sim = Simulator(vectors)
    print("Part 2 answer is :\(sim.getSteps())")
}

//partOne()
partTwo()
