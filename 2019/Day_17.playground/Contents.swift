import Cocoa

var input = """
1,330,331,332,109,3470,1101,1182,0,15,1101,1481,0,24,1002,0,1,570,1006,570,36,1001,571,0,0,1001,570,-1,570,1001,24,1,24,1105,1,18,1008,571,0,571,1001,15,1,15,1008,15,1481,570,1006,570,14,21102,1,58,0,1106,0,786,1006,332,62,99,21101,0,333,1,21102,73,1,0,1105,1,579,1102,0,1,572,1101,0,0,573,3,574,101,1,573,573,1007,574,65,570,1005,570,151,107,67,574,570,1005,570,151,1001,574,-64,574,1002,574,-1,574,1001,572,1,572,1007,572,11,570,1006,570,165,101,1182,572,127,102,1,574,0,3,574,101,1,573,573,1008,574,10,570,1005,570,189,1008,574,44,570,1006,570,158,1105,1,81,21101,0,340,1,1105,1,177,21102,477,1,1,1106,0,177,21101,514,0,1,21101,176,0,0,1106,0,579,99,21102,1,184,0,1106,0,579,4,574,104,10,99,1007,573,22,570,1006,570,165,1002,572,1,1182,21101,375,0,1,21101,0,211,0,1106,0,579,21101,1182,11,1,21102,222,1,0,1105,1,979,21102,388,1,1,21101,233,0,0,1105,1,579,21101,1182,22,1,21102,1,244,0,1105,1,979,21102,401,1,1,21101,255,0,0,1105,1,579,21101,1182,33,1,21101,266,0,0,1106,0,979,21101,414,0,1,21102,1,277,0,1105,1,579,3,575,1008,575,89,570,1008,575,121,575,1,575,570,575,3,574,1008,574,10,570,1006,570,291,104,10,21102,1,1182,1,21102,1,313,0,1105,1,622,1005,575,327,1102,1,1,575,21102,327,1,0,1106,0,786,4,438,99,0,1,1,6,77,97,105,110,58,10,33,10,69,120,112,101,99,116,101,100,32,102,117,110,99,116,105,111,110,32,110,97,109,101,32,98,117,116,32,103,111,116,58,32,0,12,70,117,110,99,116,105,111,110,32,65,58,10,12,70,117,110,99,116,105,111,110,32,66,58,10,12,70,117,110,99,116,105,111,110,32,67,58,10,23,67,111,110,116,105,110,117,111,117,115,32,118,105,100,101,111,32,102,101,101,100,63,10,0,37,10,69,120,112,101,99,116,101,100,32,82,44,32,76,44,32,111,114,32,100,105,115,116,97,110,99,101,32,98,117,116,32,103,111,116,58,32,36,10,69,120,112,101,99,116,101,100,32,99,111,109,109,97,32,111,114,32,110,101,119,108,105,110,101,32,98,117,116,32,103,111,116,58,32,43,10,68,101,102,105,110,105,116,105,111,110,115,32,109,97,121,32,98,101,32,97,116,32,109,111,115,116,32,50,48,32,99,104,97,114,97,99,116,101,114,115,33,10,94,62,118,60,0,1,0,-1,-1,0,1,0,0,0,0,0,0,1,32,18,0,109,4,1202,-3,1,587,20102,1,0,-1,22101,1,-3,-3,21102,1,0,-2,2208,-2,-1,570,1005,570,617,2201,-3,-2,609,4,0,21201,-2,1,-2,1105,1,597,109,-4,2106,0,0,109,5,1202,-4,1,630,20102,1,0,-2,22101,1,-4,-4,21101,0,0,-3,2208,-3,-2,570,1005,570,781,2201,-4,-3,652,21002,0,1,-1,1208,-1,-4,570,1005,570,709,1208,-1,-5,570,1005,570,734,1207,-1,0,570,1005,570,759,1206,-1,774,1001,578,562,684,1,0,576,576,1001,578,566,692,1,0,577,577,21102,1,702,0,1106,0,786,21201,-1,-1,-1,1105,1,676,1001,578,1,578,1008,578,4,570,1006,570,724,1001,578,-4,578,21102,731,1,0,1106,0,786,1106,0,774,1001,578,-1,578,1008,578,-1,570,1006,570,749,1001,578,4,578,21101,0,756,0,1105,1,786,1106,0,774,21202,-1,-11,1,22101,1182,1,1,21101,0,774,0,1105,1,622,21201,-3,1,-3,1105,1,640,109,-5,2105,1,0,109,7,1005,575,802,21002,576,1,-6,20102,1,577,-5,1106,0,814,21101,0,0,-1,21101,0,0,-5,21101,0,0,-6,20208,-6,576,-2,208,-5,577,570,22002,570,-2,-2,21202,-5,39,-3,22201,-6,-3,-3,22101,1481,-3,-3,1202,-3,1,843,1005,0,863,21202,-2,42,-4,22101,46,-4,-4,1206,-2,924,21101,1,0,-1,1105,1,924,1205,-2,873,21102,1,35,-4,1106,0,924,1201,-3,0,878,1008,0,1,570,1006,570,916,1001,374,1,374,1201,-3,0,895,1101,0,2,0,2101,0,-3,902,1001,438,0,438,2202,-6,-5,570,1,570,374,570,1,570,438,438,1001,578,558,922,20101,0,0,-4,1006,575,959,204,-4,22101,1,-6,-6,1208,-6,39,570,1006,570,814,104,10,22101,1,-5,-5,1208,-5,51,570,1006,570,810,104,10,1206,-1,974,99,1206,-1,974,1101,0,1,575,21101,0,973,0,1105,1,786,99,109,-7,2105,1,0,109,6,21101,0,0,-4,21101,0,0,-3,203,-2,22101,1,-3,-3,21208,-2,82,-1,1205,-1,1030,21208,-2,76,-1,1205,-1,1037,21207,-2,48,-1,1205,-1,1124,22107,57,-2,-1,1205,-1,1124,21201,-2,-48,-2,1106,0,1041,21101,0,-4,-2,1106,0,1041,21102,-5,1,-2,21201,-4,1,-4,21207,-4,11,-1,1206,-1,1138,2201,-5,-4,1059,1201,-2,0,0,203,-2,22101,1,-3,-3,21207,-2,48,-1,1205,-1,1107,22107,57,-2,-1,1205,-1,1107,21201,-2,-48,-2,2201,-5,-4,1090,20102,10,0,-1,22201,-2,-1,-2,2201,-5,-4,1103,2101,0,-2,0,1105,1,1060,21208,-2,10,-1,1205,-1,1162,21208,-2,44,-1,1206,-1,1131,1105,1,989,21101,439,0,1,1106,0,1150,21102,477,1,1,1106,0,1150,21102,1,514,1,21102,1149,1,0,1106,0,579,99,21101,0,1157,0,1105,1,579,204,-2,104,10,99,21207,-3,22,-1,1206,-1,1138,2101,0,-5,1176,2101,0,-4,0,109,-6,2106,0,0,16,13,26,1,11,1,26,1,11,1,26,1,11,1,26,1,11,1,26,1,11,1,26,1,11,1,26,1,11,1,14,13,11,1,3,7,4,1,23,1,3,1,5,1,4,1,23,1,3,1,5,1,4,1,23,1,3,1,5,1,4,1,23,9,1,1,4,1,27,1,3,1,1,10,17,14,3,1,3,1,17,1,5,1,3,1,2,1,3,1,3,1,17,1,5,1,3,1,2,1,3,1,3,1,17,1,9,1,2,1,3,1,3,1,17,1,1,5,3,1,2,1,3,1,3,1,17,1,1,1,7,1,2,1,3,5,17,1,1,1,7,1,2,1,25,1,1,1,7,1,2,1,25,1,1,1,7,1,2,1,25,1,1,1,7,1,2,1,25,1,1,9,2,1,25,1,12,9,5,13,20,1,5,1,30,7,1,1,30,1,1,1,3,1,1,1,30,1,1,1,3,1,1,1,30,1,1,1,3,1,1,1,30,1,1,1,3,1,1,1,30,1,1,1,3,1,1,1,30,9,32,1,3,1,34,1,3,1,34,1,3,1,34,13,30,1,7,1,30,13,34,1,3,1,34,1,3,1,34,1,3,1,32,9,30,1,1,1,3,1,1,1,30,1,1,1,3,1,1,1,30,1,1,1,3,1,1,1,30,7,1,1,32,1,5,1,32,7,12
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

public class Opcode {
    var numbers: [Int]
    public var inputIds: [Int] = []
    var inputId: Int
    public var done = false
    var index = 0
    var relativeBase = 0
    var output: Int!
    var outputs: [Int] = []

    public init(_ input: [Int], _ inputId: Int = 0) {
        self.numbers = input
        numbers.append(contentsOf: Array.init(repeating: 0, count:99999999))
        self.inputId = inputId
        self.inputIds.append(inputId)
    }

    public func run() -> Int {
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
                //outputs.append(output)
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


func partOne() {
    let computer = Opcode.init(input)
    var result: String = ""
    var outputs: [Int] = []
    while !computer.done {
        outputs.append(computer.run())
    }
    outputs.map { result.append(Character(UnicodeScalar($0)!))}

    let grid = result.split(separator: "\n").map{ $0.map{$0}}
    var sum = 0
    for row in 1 ..< (grid.count - 1) {
        for column in 1 ..< (grid[row].count - 1) {
            if grid[row][column] == "#" {
                if grid[row][column - 1] == "#" &&
                    grid[row][column + 1] == "#" &&
                    grid[row - 1][column] == "#" &&
                    grid[row + 1][column] == "#" {
                    sum += row * column
                }
            }
        }
    }
    print(grid)
    print("Part 1 answer is :\(sum)")
}

func partTwo() {
    var scanLine = ""
    let rules = """
    A,B,B,A,B,C,A,C,B,C
    L,4,L,6,L,8,L,12
    L,8,R,12,L,12
    R,12,L,6,L,6,L,8
    y\n
    """.map { Int($0.asciiValue!) }
    var rulesIndex = -1

    var dustCollected = 0
    input[0] = 2
    let computer = Opcode.init(input)
    while !computer.done {
        rulesIndex += 1
        computer.inputIds.append(rules[rulesIndex])
        let value = computer.run()
        dustCollected = value
//        if value >= 127 {
//            dustCollected = value
//            break
//        }
//        else if value != 10 {
//            scanLine.append(Character(UnicodeScalar(value)!))
//        }
//        if scanLine == "" {
//            print("\u{001b}[H") // send the cursor home
//        } else {
//            print(scanLine)
//            scanLine = ""
//        }
    }

    print("Part 2 answer is :\(dustCollected)")
}

partOne()
partTwo()
