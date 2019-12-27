import Cocoa

var input = """
109,424,203,1,21102,1,11,0,1106,0,282,21101,18,0,0,1105,1,259,2101,0,1,221,203,1,21101,0,31,0,1105,1,282,21101,38,0,0,1105,1,259,21001,23,0,2,22101,0,1,3,21102,1,1,1,21101,57,0,0,1106,0,303,2102,1,1,222,20102,1,221,3,20102,1,221,2,21101,0,259,1,21102,80,1,0,1105,1,225,21102,1,130,2,21102,1,91,0,1106,0,303,2101,0,1,223,21002,222,1,4,21102,259,1,3,21102,1,225,2,21101,0,225,1,21102,1,118,0,1106,0,225,21002,222,1,3,21101,0,106,2,21102,1,133,0,1106,0,303,21202,1,-1,1,22001,223,1,1,21101,148,0,0,1105,1,259,2102,1,1,223,20101,0,221,4,20102,1,222,3,21102,1,19,2,1001,132,-2,224,1002,224,2,224,1001,224,3,224,1002,132,-1,132,1,224,132,224,21001,224,1,1,21101,195,0,0,106,0,109,20207,1,223,2,20101,0,23,1,21102,-1,1,3,21101,0,214,0,1105,1,303,22101,1,1,1,204,1,99,0,0,0,0,109,5,1201,-4,0,249,21201,-3,0,1,21202,-2,1,2,21201,-1,0,3,21102,1,250,0,1105,1,225,22102,1,1,-4,109,-5,2106,0,0,109,3,22107,0,-2,-1,21202,-1,2,-1,21201,-1,-1,-1,22202,-1,-2,-2,109,-3,2106,0,0,109,3,21207,-2,0,-1,1206,-1,294,104,0,99,21201,-2,0,-2,109,-3,2105,1,0,109,5,22207,-3,-4,-1,1206,-1,346,22201,-4,-3,-4,21202,-3,-1,-1,22201,-4,-1,2,21202,2,-1,-1,22201,-4,-1,1,22102,1,-2,3,21102,343,1,0,1105,1,303,1105,1,415,22207,-2,-3,-1,1206,-1,387,22201,-3,-2,-3,21202,-2,-1,-1,22201,-3,-1,3,21202,3,-1,-1,22201,-3,-1,2,21201,-4,0,1,21101,384,0,0,1106,0,303,1106,0,415,21202,-4,-1,-4,22201,-4,-3,-4,22202,-3,-2,-2,22202,-2,-4,-4,22202,-3,-2,-3,21202,-4,-1,-2,22201,-3,-2,1,21201,1,0,-4,109,-5,2106,0,0
"""

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

struct Point: CustomStringConvertible, Equatable, Hashable {
    var x: Int
    var y: Int

    var description: String {
        get {
            return "X: \(self.x) Y: \(self.y)"
        }
    }
}
extension Int {
    var decimalComponents: [Int] {
        String(self).map { $0.wholeNumberValue! }
    }
}

struct Intcode {

    enum Operation { case read, write }

    var numbers: [Int: Int]

    init(numbers: [Int: Int]) {
        self.numbers = numbers
    }

    private(set) var hasFinished = false

    private var currentPosition = 0
    private var relativeBase = 0

    public var inputs: [Int] = []
    public var output: Int!

    mutating func execute() -> Int {

        guard hasFinished == false else { return output }

        while true {
            let opCodeComponents = numbers[currentPosition]!.decimalComponents
            let opCode = ((opCodeComponents.dropLast().last ?? 0) * 10) + opCodeComponents.last!

            func parameter(atIndex index: Int, operation: Operation = .read) -> Int {
                let explicitMode = opCodeComponents.dropLast(2 + index).last
                let rawPosition = currentPosition + 1 + index

                switch operation {
                case .read:
                    switch explicitMode {
                    case 0: return numbers[numbers[rawPosition]!, default: 0]
                    case 1: return numbers[rawPosition, default: 0]
                    case 2: return numbers[relativeBase + numbers[rawPosition]!, default: 0]
                    default: return numbers[numbers[rawPosition]!, default: 0]
                    }

                case .write:
                    switch explicitMode {
                    case 0: return numbers[rawPosition]!
                    case 2: return relativeBase + numbers[rawPosition]!
                    default: return numbers[rawPosition]!
                    }
                }
            }

            switch opCode {
            case 1:
                let pZero = parameter(atIndex: 0)
                let pOne = parameter(atIndex: 1)
                let pTwo = parameter(atIndex: 2, operation: .write)
                numbers[pTwo] = pZero + pOne
                currentPosition += 4

            case 2:
                let pZero = parameter(atIndex: 0)
                let pOne = parameter(atIndex: 1)
                let pTwo = parameter(atIndex: 2, operation: .write)
                numbers[pTwo] = pZero * pOne
                currentPosition += 4

            case 3:
                let pZero = parameter(atIndex: 0, operation: .write)
                numbers[pZero] = inputs.popLast()!
                currentPosition += 2

            case 4:
                let pZero = parameter(atIndex: 0)
                //output(pZero)
                output = pZero
                currentPosition += 2

            case 5:
                let pZero = parameter(atIndex: 0)
                let pOne = parameter(atIndex: 1)

                if pZero != 0 {
                    currentPosition = pOne
                } else {
                    currentPosition += 3
                }

            case 6:
                let pZero = parameter(atIndex: 0)
                let pOne = parameter(atIndex: 1)

                if pZero == 0 {
                    currentPosition = pOne
                } else {
                    currentPosition += 3
                }

            case 7:
                let pZero = parameter(atIndex: 0)
                let pOne = parameter(atIndex: 1)
                let pTwo = parameter(atIndex: 2, operation: .write)
                numbers[pTwo] = pZero < pOne ? 1 : 0
                currentPosition += 4

            case 8:
                let pZero = parameter(atIndex: 0)
                let pOne = parameter(atIndex: 1)
                let pTwo = parameter(atIndex: 2, operation: .write)
                numbers[pTwo] = pZero == pOne ? 1 : 0
                currentPosition += 4

            case 9:
                let pZero = parameter(atIndex: 0)
                relativeBase += pZero
                currentPosition += 2

            case 99: hasFinished = true; return output
            default: fatalError("Unexpected opCode")
            }
        }
    }
}


let point = Point.init(x: 0, y: 0)
var grid: [Point: Int] = [:]
let initialNumbers = input.split(separator: ",").map { Int($0)! }
.enumerated()
.reduce(into: [Int: Int]()) { dict, indexElementPair in
    dict[indexElementPair.offset] = indexElementPair.element
}

func beam(_ x: Int, _ y: Int) -> Int {
    var intcode = Intcode.init(numbers: initialNumbers)
    intcode.inputs.append(y)
    intcode.inputs.append(x)
    return intcode.execute()
}

let count = 50
for i in 0..<count {
    for j in 0..<count {
        let output = beam(i,j)
        grid[Point.init(x: i, y:j)] = output
    }
}
func partOne() {
    var total = 0
    for tile in grid {
        if tile.value == 1 {
            total += 1
        }
    }

    print(total)
}

func partTwo() {
    var x = 0
    var y = 99

    while true {
//        print("trying :\(x),\(y)")
        if beam(x, y) == 1 {
            if beam(x+99, y-99) == 1 {
                print(x*10000 + (y-99))
                break
            }
            else {
                y += 1
            }
        }
        else {
            x += 1
        }
    }
}

partOne()
partTwo()
