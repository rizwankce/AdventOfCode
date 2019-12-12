import Cocoa

let input = """
3,8,1005,8,336,1106,0,11,0,0,0,104,1,104,0,3,8,102,-1,8,10,1001,10,1,10,4,10,108,1,8,10,4,10,101,0,8,28,1006,0,36,1,2,5,10,1006,0,57,1006,0,68,3,8,102,-1,8,10,1001,10,1,10,4,10,108,0,8,10,4,10,1002,8,1,63,2,6,20,10,1,106,7,10,2,9,0,10,3,8,102,-1,8,10,101,1,10,10,4,10,108,1,8,10,4,10,102,1,8,97,1006,0,71,3,8,1002,8,-1,10,101,1,10,10,4,10,108,1,8,10,4,10,1002,8,1,122,2,105,20,10,3,8,1002,8,-1,10,1001,10,1,10,4,10,108,0,8,10,4,10,101,0,8,148,2,1101,12,10,1006,0,65,2,1001,19,10,3,8,102,-1,8,10,1001,10,1,10,4,10,108,0,8,10,4,10,101,0,8,181,3,8,1002,8,-1,10,1001,10,1,10,4,10,1008,8,0,10,4,10,1002,8,1,204,2,7,14,10,2,1005,20,10,1006,0,19,3,8,102,-1,8,10,101,1,10,10,4,10,108,1,8,10,4,10,102,1,8,236,1006,0,76,1006,0,28,1,1003,10,10,1006,0,72,3,8,1002,8,-1,10,101,1,10,10,4,10,108,0,8,10,4,10,102,1,8,271,1006,0,70,2,107,20,10,1006,0,81,3,8,1002,8,-1,10,1001,10,1,10,4,10,108,1,8,10,4,10,1002,8,1,303,2,3,11,10,2,9,1,10,2,1107,1,10,101,1,9,9,1007,9,913,10,1005,10,15,99,109,658,104,0,104,1,21101,0,387508441896,1,21102,1,353,0,1106,0,457,21101,0,937151013780,1,21101,0,364,0,1105,1,457,3,10,104,0,104,1,3,10,104,0,104,0,3,10,104,0,104,1,3,10,104,0,104,1,3,10,104,0,104,0,3,10,104,0,104,1,21102,179490040923,1,1,21102,411,1,0,1105,1,457,21101,46211964123,0,1,21102,422,1,0,1106,0,457,3,10,104,0,104,0,3,10,104,0,104,0,21101,838324716308,0,1,21101,0,445,0,1106,0,457,21102,1,868410610452,1,21102,1,456,0,1106,0,457,99,109,2,22101,0,-1,1,21101,40,0,2,21101,0,488,3,21101,478,0,0,1106,0,521,109,-2,2105,1,0,0,1,0,0,1,109,2,3,10,204,-1,1001,483,484,499,4,0,1001,483,1,483,108,4,483,10,1006,10,515,1101,0,0,483,109,-2,2105,1,0,0,109,4,2101,0,-1,520,1207,-3,0,10,1006,10,538,21101,0,0,-3,22102,1,-3,1,21202,-2,1,2,21101,0,1,3,21101,557,0,0,1105,1,562,109,-4,2105,1,0,109,5,1207,-3,1,10,1006,10,585,2207,-4,-2,10,1006,10,585,22101,0,-4,-4,1106,0,653,21201,-4,0,1,21201,-3,-1,2,21202,-2,2,3,21102,604,1,0,1106,0,562,21202,1,1,-4,21101,0,1,-1,2207,-4,-2,10,1006,10,623,21102,0,1,-1,22202,-2,-1,-2,2107,0,-3,10,1006,10,645,21202,-1,1,1,21101,0,645,0,106,0,520,21202,-2,-1,-2,22201,-4,-2,-4,109,-5,2105,1,0
""".components(separatedBy: ",").compactMap{ Int($0) }

extension BinaryInteger {
    var digits: [Int] {
        return String(describing: self).compactMap { Int(String($0)) }
    }
}

extension Array {
    subscript (safe index: Int) -> Element? {
        return indices ~= index ? self[index] : nil
    }
}

class Opcode {
    var numbers: [Int]
    var inputIds: [Int] = []
    var inputId: Int
    var done = false
    var index = 0
    var relativeBase = 0
    var output: Int!
    var outputs: [Int] = []

    init(_ input: [Int], _ inputId: Int = 0) {
        self.numbers = input
        numbers.append(contentsOf: Array.init(repeating: 0, count:1000))
        self.inputId = inputId
        self.inputIds.append(inputId)
    }

    func run() -> Int {
        guard done == false else { return output }
        while true {
            let digits = numbers[index]
            let opCode = ((digits.digits.dropLast().last ?? 0) * 10) + digits.digits.last!
            var instruction = digits.digits
            //print("Numbers \(numbers)")
            //print("Running opcode \(instruction)")

            func getValue(_ aIndex: Int, _ mode: Int = 0) -> Int {
                switch mode {
                case 0:
                    return numbers[numbers[index + 1 + aIndex]];
                case 1:
                    return numbers[index + 1 + aIndex];
                case 2:
                    return numbers[safe: relativeBase + numbers[index + 1 + aIndex]] ?? 0;
                default:
                    fatalError("unexpected mode \(mode)")
                }
            }

            func setValue(_ index: Int, _ value: Int, _ mode: Int = 0) {
                //print("set index is : \(index) value s \(value) mode is \(mode)")
                switch mode {
                case 0:
                    numbers[index] = value
                //print("set index is : \(index)")
                case 2:
                    //print(relativeBase + index)
                    numbers[relativeBase + index] = value
                default:
                    break
                }
            }

            func getParam(_ aIndex: Int) -> Int {
                if let mode = instruction.dropLast(2 + aIndex).last {
                    //print("mode is : \(mode)")
                    //print("value is : \(getValue(aIndex,mode))")
                    return getValue(aIndex,mode)
                }
                return getValue(aIndex)
            }

            func setParam(_ aIndex: Int, _ value: Int) {
                //print("set value is : \(value)")
                //print("setting apram \(aIndex))")
                if let mode = instruction.dropLast(2 + aIndex).last {
                    setValue(aIndex, value, mode)
                    return
                }
                setValue(aIndex, value)
            }

            func getMode(_ aIndex: Int) -> Int {
                //print(instruction)
                if let mode = instruction.dropLast(2 + aIndex).last {
                    return mode
                }
                return 0
            }

            switch opCode {
            case 1:
                let p1 = getParam(0)
                let p2 = getParam(1)
                let p3 = numbers[index + 3]
                setValue(p3, p1 + p2,getMode(2))
                index += 4

            case 2:
                let p1 = getParam(0)
                let p2 = getParam(1)
                let p3 = numbers[index + 3]
                setValue(p3, p1 * p2,getMode(2))
                index += 4

            case 3:
                let p1 = numbers[index + 1]
                setValue(p1, inputIds.last!,getMode(2))
                //                setParam(p1, inputIds.last!)
                index += 2
            case 4:
                let p1 = getParam(0)
                output = p1
                //print("output is :\(p1)")
                index += 2
                return output

            case 5:
                let p1 = getParam(0)
                let p2 = getParam(1)
                if p1 != 0 {
                    index = p2
                }
                else {
                    index += 3
                }

            case 6:
                let p1 = getParam(0)
                let p2 = getParam(1)
                if p1 == 0 {
                    index = p2
                }
                else {
                    index += 3
                }

            case 7:
                let p1 = getParam(0)
                let p2 = getParam(1)
                let p3 = numbers[index + 3]
                setValue(p3, p1 < p2 ? 1 : 0,getMode(2))
                index += 4

            case 8:
                let p1 = getParam(0)
                let p2 = getParam(1)
                let p3 = numbers[index + 3]
                setValue(p3, p1 == p2 ? 1 : 0,getMode(2))
                index += 4

            case 9:
                let p1 = getParam(0)
                relativeBase += p1
                index += 2
                //            print("New R Base \(relativeBase)")

            case 99:
                done = true
                return output

            default:
                fatalError("Unknown opcode \(opCode)")
            }
        }
    }
}

enum Direction: Int {
    case up = 0
    case left = 1
    case right = 2
    case down = 3

    mutating func turn(_ direction: Int) {
        if direction == 0 {
            switch self {
            case .up:
                self = Direction.left
            case .down:
                self = Direction.right
            case .left:
                self = Direction.down
            case .right:
                self = Direction.up
            }
        }
        else if direction == 1 {
            switch self {
            case .up:
                self = Direction.right
            case .down:
                self = Direction.left
            case .left:
                self = Direction.up
            case .right:
                self = Direction.down
            }
        }

    }
}

struct Point: CustomStringConvertible, Equatable, Hashable {
    var x: Int
    var y: Int

    var description: String {
        get {
            return "X: \(self.x) Y: \(self.y)"
        }
    }

    mutating func move(in direction: Direction) {
        switch direction {
        case .up: self.y += 1
        case .right: self.x += 1
        case .down: self.y -= 1
        case .left: self.x -= 1
        }
    }
}

extension Array where Element : Hashable {
    var unique: [Element] {
        return Array(Set(self))
    }
}
enum Color: Int {
    case black = 0
    case white = 1
}

class Robot {
    let startColor: Color
    var paint: [Point: Int] = [:]

    init(_ startColor: Color) {
        self.startColor = startColor
    }

    @discardableResult func run() -> Int {
        let computer = Opcode(input,startColor.rawValue)
        var direction: Direction = .up
        var currentPosition = Point(x: 0, y: 0)
        paint = [currentPosition:0]
        while !computer.done {
            let color = computer.run()
            let turn = computer.run()

            paint[currentPosition] = color
            direction.turn(turn)
            currentPosition.move(in: direction)
            computer.inputIds.append(paint[currentPosition] ?? 0)
        }
        return Set(paint.keys).count
    }

    func paintHull() {
        let minX = paint.keys.min{ a,b in a.x < b.x }!.x
        let minY = paint.keys.min{ a,b in a.y < b.y }!.y

        let maxX = paint.keys.min{ a,b in a.x > b.x }!.x
        let maxY = paint.keys.min{ a,b in a.y > b.y }!.y

        var line: [[String]] = []
        for y in (minY ..< maxY+1) {
            var row: [String] = []
            for x in (minX ..< maxX+1) {
                let point = Point.init(x: x, y: y)
                let char = paint[point]
                row.append(char == Color.white.rawValue ? "#" : " ")
            }
            line.insert(row, at: 0)
        }
        for aLine in line {
            print(aLine, separator:"")
        }
    }
}



func partOne() {
    let result = Robot(.black).run()
    print("Part 1 answer is :\(result)")
}

func partTwo() {
    let robot = Robot(.white)
    robot.run()
    robot.paintHull()
}

partOne()
partTwo()
