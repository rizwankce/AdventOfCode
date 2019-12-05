import Cocoa

//--- Day 5: Sunny with a Chance of Asteroids ---


extension BinaryInteger {
    var digits: [Int] {
        return String(describing: self).compactMap { Int(String($0)) }
    }
}

func computeIntCode(_ input: [Int], _ inputId: Int = 1) -> Int {
    var numbers = input
    var output: Int = -1
    func add(_ aPosition: Int, _ bPosistion: Int) -> Int {
        return numbers[aPosition] + numbers[bPosistion]
    }

    func multiply(_ aPosition: Int, _ bPosistion: Int) -> Int {
        return numbers[aPosition] * numbers[bPosistion]
    }

    var index = 0
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
            print("v: \(values)")

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
            let input: Int = inputId;
            numbers[parameter] = input
            index = index + 2
        }
        else if optcode == 4 || instruction == 04 {
//            let value = getValue(0)
//            print(value)
            let parameter = numbers[index + 1]
            output = numbers[parameter]
            index = index + 2
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
            return output
        }
        else {
            fatalError("unexpected optcode \(instruction)")
        }
    }
    print(numbers)
    return numbers[0]
}

let input = """
3,225,1,225,6,6,1100,1,238,225,104,0,1102,40,93,224,1001,224,-3720,224,4,224,102,8,223,223,101,3,224,224,1,224,223,223,1101,56,23,225,1102,64,78,225,1102,14,11,225,1101,84,27,225,1101,7,82,224,1001,224,-89,224,4,224,1002,223,8,223,1001,224,1,224,1,224,223,223,1,35,47,224,1001,224,-140,224,4,224,1002,223,8,223,101,5,224,224,1,224,223,223,1101,75,90,225,101,9,122,224,101,-72,224,224,4,224,1002,223,8,223,101,6,224,224,1,224,223,223,1102,36,63,225,1002,192,29,224,1001,224,-1218,224,4,224,1002,223,8,223,1001,224,7,224,1,223,224,223,102,31,218,224,101,-2046,224,224,4,224,102,8,223,223,101,4,224,224,1,224,223,223,1001,43,38,224,101,-52,224,224,4,224,1002,223,8,223,101,5,224,224,1,223,224,223,1102,33,42,225,2,95,40,224,101,-5850,224,224,4,224,1002,223,8,223,1001,224,7,224,1,224,223,223,1102,37,66,225,4,223,99,0,0,0,677,0,0,0,0,0,0,0,0,0,0,0,1105,0,99999,1105,227,247,1105,1,99999,1005,227,99999,1005,0,256,1105,1,99999,1106,227,99999,1106,0,265,1105,1,99999,1006,0,99999,1006,227,274,1105,1,99999,1105,1,280,1105,1,99999,1,225,225,225,1101,294,0,0,105,1,0,1105,1,99999,1106,0,300,1105,1,99999,1,225,225,225,1101,314,0,0,106,0,0,1105,1,99999,1007,226,677,224,1002,223,2,223,1005,224,329,1001,223,1,223,1007,226,226,224,1002,223,2,223,1006,224,344,101,1,223,223,1107,677,226,224,102,2,223,223,1006,224,359,1001,223,1,223,108,677,677,224,1002,223,2,223,1006,224,374,1001,223,1,223,107,677,677,224,1002,223,2,223,1005,224,389,101,1,223,223,8,677,677,224,1002,223,2,223,1005,224,404,1001,223,1,223,108,226,226,224,1002,223,2,223,1005,224,419,101,1,223,223,1008,677,677,224,1002,223,2,223,1005,224,434,101,1,223,223,1008,226,226,224,1002,223,2,223,1005,224,449,101,1,223,223,7,677,226,224,1002,223,2,223,1006,224,464,1001,223,1,223,7,226,226,224,1002,223,2,223,1005,224,479,1001,223,1,223,1007,677,677,224,102,2,223,223,1005,224,494,101,1,223,223,1108,677,226,224,102,2,223,223,1006,224,509,1001,223,1,223,8,677,226,224,102,2,223,223,1005,224,524,1001,223,1,223,1107,226,226,224,102,2,223,223,1006,224,539,1001,223,1,223,1008,226,677,224,1002,223,2,223,1006,224,554,1001,223,1,223,1107,226,677,224,1002,223,2,223,1006,224,569,1001,223,1,223,1108,677,677,224,102,2,223,223,1005,224,584,101,1,223,223,7,226,677,224,102,2,223,223,1006,224,599,1001,223,1,223,1108,226,677,224,102,2,223,223,1006,224,614,101,1,223,223,107,226,677,224,1002,223,2,223,1005,224,629,101,1,223,223,108,226,677,224,1002,223,2,223,1005,224,644,101,1,223,223,8,226,677,224,1002,223,2,223,1005,224,659,1001,223,1,223,107,226,226,224,1002,223,2,223,1006,224,674,101,1,223,223,4,223,99,226
""".components(separatedBy: ",").compactMap{Int($0)}

func partOne() {
    dump(computeIntCode(input,1))
}

func partTwo() {
    dump(computeIntCode(input,5))
}

//partOne()
partTwo()
//computeIntCode([3,21,1008,21,8,20,1005,20,22,107,8,21,20,1006,20,31,1106,0,36,98,0,0,1002,21,125,20,4,20,1105,1,46,104,999,1105,1,46,1101,1000,1,20,4,20,1105,1,46,98,99],10)
//computeIntCode([3,3,1105,-1,9,1101,0,0,12,4,12,99,1],0)
