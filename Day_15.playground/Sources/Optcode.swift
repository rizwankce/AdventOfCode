import Foundation

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
        numbers.append(contentsOf: Array.init(repeating: 0, count:1000))
        self.inputId = inputId
        self.inputIds.append(inputId)
    }

    public func clone() -> Opcode {
        let opcode = Opcode.init(self.numbers)
        opcode.inputIds = []
        opcode.outputs = []
        opcode.done = self.done
        opcode.index = self.index
        opcode.relativeBase = self.relativeBase
        opcode.output = self.output
        return opcode
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
