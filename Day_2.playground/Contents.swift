import Cocoa

/// --- Day 2: 1202 Program Alarm ---

func computeIntCode(_ input: [Int]) -> Int {
    var numbers = input

    func add(_ aPosition: Int, _ bPosistion: Int) -> Int {
        return numbers[aPosition] + numbers[bPosistion]
    }

    func multiply(_ aPosition: Int, _ bPosistion: Int) -> Int {
        return numbers[aPosition] * numbers[bPosistion]
    }

    func compute(integers:[Int]) {
        let opcode = integers[0]
           switch opcode {
           case 1:
               let result = add(integers[1], integers[2])
               numbers[integers[3]] = result
               //print(numbers)
               break
           case 2:
               let result = multiply(integers[1], integers[2])
               numbers[integers[3]] = result
               //print(numbers)
               break
           case 99:
               break
           default:
               break
           }
    }

    var index = 0
    while true {
        let number = numbers[index]
        if number == 1 || number == 2 {
            compute(integers: Array(numbers[index...index+4]))
            index = index + 4
        }
        else if number == 99 {
            break
        }
    }
    //print(numbers)
    return numbers[0]
}

func computeIntCode(_ input:[Int], _ noun: Int, _ verb: Int) -> Int {
    var input = input
    input[1] = noun
    input[2] = verb
    return computeIntCode(input)
}

computeIntCode([1,9,10,3,2,3,11,0,99,30,40,50])
computeIntCode([1,0,0,0,99])
computeIntCode([2,3,0,3,99])
computeIntCode([2,4,4,5,99,0])
computeIntCode([1,1,1,4,99,5,6,0,99])


let input = """
    1,0,0,3,1,1,2,3,1,3,4,3,1,5,0,3,2,1,10,19,2,9,19,23,1,9,23,27,2,27,9,31,1,31,5,35,2,35,9,39,1,39,10,43,2,43,13,47,1,47,6,51,2,51,10,55,1,9,55,59,2,6,59,63,1,63,6,67,1,67,10,71,1,71,10,75,2,9,75,79,1,5,79,83,2,9,83,87,1,87,9,91,2,91,13,95,1,95,9,99,1,99,6,103,2,103,6,107,1,107,5,111,1,13,111,115,2,115,6,119,1,119,5,123,1,2,123,127,1,6,127,0,99,2,14,0,0
    """
let numbers = input.components(separatedBy: ",").compactMap{Int($0)}

func partOne() {
    dump(computeIntCode(numbers,12,2))
}

func partTwo() {
    for i in 0..<99 {
        for j in 0..<99 {
            if computeIntCode(numbers,i,j) == 19690720 {
                print("noun: \(i) \n verb: \(j)")
                dump(100 * i + j)
                return
            }
        }
    }
}

partOne()
partTwo()
