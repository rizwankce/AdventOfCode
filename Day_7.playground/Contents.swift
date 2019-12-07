import Cocoa

extension BinaryInteger {
    var digits: [Int] {
        return String(describing: self).compactMap { Int(String($0)) }
    }
}

class Amplifier {
    var done = false
    var setting: Int = 0
    var output: Int!
    var numbers: [Int] = []
    var index = 0
    var settingUsed = false

    func computeIntCodeWithStatus(_ inputIds: [Int]) -> Int {
        guard done == false else { return output }
        //var numbers = input
        //var output: Int = -1
        func add(_ aPosition: Int, _ bPosistion: Int) -> Int {
            return numbers[aPosition] + numbers[bPosistion]
        }

        func multiply(_ aPosition: Int, _ bPosistion: Int) -> Int {
            return numbers[aPosition] * numbers[bPosistion]
        }

        while true {
            let optcode = numbers[index]
            let instruction = ((optcode.digits.dropLast().last ?? 0) * 10) + optcode.digits.last!
            let numberOfValues = 4
            var parameters: [Int] = []
            if (instruction != 99 && instruction != 4) {
                parameters = Array(numbers[index+1...index+numberOfValues])
            }
            let digits = optcode.digits

            func getValue(_ i: Int) -> Int {
                return digits.dropLast(2 + i).last == 1 ? numbers[index + 1 + i] : numbers[numbers[index + 1 + i]]
            }
            func getValues() -> [Int] {
                var values : [Int] = []
                values.append(getValue(0))
                values.append(getValue(1))
                return values
            }

            if instruction == 01 {
                let values = getValues()
                let result = values[0] + values[1]
                numbers[parameters[2]] = result
                index = index + numberOfValues
            }
            else if instruction == 02 {
                let values = getValues()
                let result = values[0] * values[1]
                numbers[parameters[2]] = result
                index = index + numberOfValues
            }
            else if optcode == 3 || instruction == 03 {
                let parameter = numbers[index + 1]
                let input: Int = settingUsed ? inputIds[1] : inputIds[0];
                settingUsed = true
                numbers[parameter] = input
                index = index + 2
            }
            else if optcode == 4 || instruction == 04 {
                let parameter = numbers[index + 1]
                output = numbers[parameter]
                index = index + 2
                return output
            }
            else if instruction == 5 {
                let values = getValues()
                if values[0] != 0 {
                    index = values[1]
                }
                else {
                    index = index + 3
                }
            }
            else if instruction == 6 {
                let values = getValues()
                if values[0] == 0 {
                    index = values[1]
                }
                else {
                    index = index + 3
                }
            }
            else if instruction == 07 {
                let values = getValues()
                let result = values[0] < values[1] ? 1 : 0
                numbers[parameters[2]] = result
                index = index + 4
            }
            else if instruction == 08 {
                let values = getValues()
                let result = values[0] == values[1] ? 1 : 0
                numbers[parameters[2]] = result
                index = index + 4
            }
            else if optcode == 99 {
                done = true
                return output
            }
            else {
                fatalError("unexpected optcode \(instruction)")
            }
        }
    }
}

var input = """
3,8,1001,8,10,8,105,1,0,0,21,42,67,88,105,114,195,276,357,438,99999,3,9,101,4,9,9,102,3,9,9,1001,9,2,9,102,4,9,9,4,9,99,3,9,1001,9,4,9,102,4,9,9,101,2,9,9,1002,9,5,9,1001,9,2,9,4,9,99,3,9,1001,9,4,9,1002,9,4,9,101,2,9,9,1002,9,2,9,4,9,99,3,9,101,4,9,9,102,3,9,9,1001,9,5,9,4,9,99,3,9,102,5,9,9,4,9,99,3,9,102,2,9,9,4,9,3,9,101,1,9,9,4,9,3,9,101,2,9,9,4,9,3,9,1001,9,2,9,4,9,3,9,102,2,9,9,4,9,3,9,1002,9,2,9,4,9,3,9,1001,9,1,9,4,9,3,9,102,2,9,9,4,9,3,9,102,2,9,9,4,9,3,9,101,2,9,9,4,9,99,3,9,1002,9,2,9,4,9,3,9,1001,9,2,9,4,9,3,9,102,2,9,9,4,9,3,9,102,2,9,9,4,9,3,9,102,2,9,9,4,9,3,9,102,2,9,9,4,9,3,9,1001,9,1,9,4,9,3,9,101,1,9,9,4,9,3,9,101,1,9,9,4,9,3,9,1002,9,2,9,4,9,99,3,9,102,2,9,9,4,9,3,9,101,1,9,9,4,9,3,9,1002,9,2,9,4,9,3,9,1002,9,2,9,4,9,3,9,1002,9,2,9,4,9,3,9,102,2,9,9,4,9,3,9,101,2,9,9,4,9,3,9,102,2,9,9,4,9,3,9,1001,9,2,9,4,9,3,9,1001,9,1,9,4,9,99,3,9,1002,9,2,9,4,9,3,9,1001,9,1,9,4,9,3,9,101,2,9,9,4,9,3,9,1001,9,1,9,4,9,3,9,101,2,9,9,4,9,3,9,1001,9,1,9,4,9,3,9,102,2,9,9,4,9,3,9,1002,9,2,9,4,9,3,9,1002,9,2,9,4,9,3,9,1001,9,2,9,4,9,99,3,9,1002,9,2,9,4,9,3,9,101,1,9,9,4,9,3,9,1002,9,2,9,4,9,3,9,102,2,9,9,4,9,3,9,1001,9,1,9,4,9,3,9,1002,9,2,9,4,9,3,9,1001,9,1,9,4,9,3,9,101,2,9,9,4,9,3,9,1001,9,1,9,4,9,3,9,1002,9,2,9,4,9,99
""".components(separatedBy: ",").compactMap{Int($0)}
extension Array {
    var permutations: [[Element]] {
        guard count > 0 else {
            return [[]]
        }

        return indices
            .flatMap { index -> [[Element]] in
                let first = self[index]
                var rest = self
                rest.remove(at: index)
                return rest.permutations.map { [first] + $0 }
        }
    }
}
func partOne() {
    var outputs: [Int] = []
    for settings in [0,1,2,3,4].permutations {
        var inputSignal = 0
        for setting in settings {
            let amplifier = Amplifier()
            amplifier.setting = setting
            amplifier.numbers = input
            inputSignal = amplifier.computeIntCodeWithStatus([setting,inputSignal])
        }
        outputs.append(inputSignal)
    }
    print("Max thruster signal : \(outputs.max() ?? 0)")
}

func partTwo() {
    var outputs: [Int] = []
    for settings in [5,6,7,8,9].permutations {
        var inputSignal = 0
        var amplifiers: [Amplifier] = []
        for setting in settings {
            let amplifier = Amplifier()
            amplifier.setting = setting
            amplifier.numbers = input
            amplifiers.append(amplifier)
        }
        while !(amplifiers.last?.done ?? false) {
            for amplifier in amplifiers {
                inputSignal = amplifier.computeIntCodeWithStatus([amplifier.setting,inputSignal])
            }
        }
        outputs.append(inputSignal)
    }

    print("Max thruster signal : \(outputs.max() ?? 0)")
}

partOne()
partTwo()

