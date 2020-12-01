import Cocoa

var input = """
deal with increment 2
cut 3310
deal with increment 13
cut -9214
deal with increment 14
deal into new stack
deal with increment 26
deal into new stack
deal with increment 62
cut -1574
deal with increment 74
cut -7102
deal with increment 41
cut 7618
deal with increment 70
cut 7943
deal into new stack
deal with increment 52
cut -3134
deal with increment 21
deal into new stack
deal with increment 20
deal into new stack
deal with increment 61
cut -2810
deal with increment 60
cut 3355
deal with increment 13
cut 3562
deal with increment 55
cut 2600
deal with increment 47
deal into new stack
cut -7010
deal with increment 34
cut 1726
deal with increment 61
cut 2805
deal with increment 39
cut 1907
deal into new stack
cut 3915
deal with increment 14
cut -6590
deal into new stack
deal with increment 73
deal into new stack
deal with increment 31
cut 1000
deal with increment 3
cut 8355
deal with increment 2
cut -5283
deal with increment 50
cut -7150
deal with increment 71
cut 6728
deal with increment 58
cut -814
deal with increment 14
cut -8392
deal with increment 71
cut 7674
deal with increment 46
deal into new stack
deal with increment 55
cut 7026
deal with increment 17
cut 1178
deal with increment 10
cut -8205
deal with increment 27
cut -55
deal with increment 44
cut -2392
deal into new stack
cut 7385
deal with increment 36
cut -399
deal with increment 74
cut 6895
deal with increment 20
cut 4346
deal with increment 15
cut -4088
deal with increment 3
cut 1229
deal with increment 59
cut 4708
deal with increment 62
cut 2426
deal with increment 30
cut 7642
deal with increment 73
cut 9049
deal into new stack
cut -3866
deal with increment 68
deal into new stack
cut 1407
""".components(separatedBy: "\n")

print(input)

enum Type {
    case increment(number: Int)
    case new
    case cut(number: Int)

    init?(_ type: String) {
        if type.contains("deal with increment") {
            self = .increment(number: Int(type.components(separatedBy: " ").last!)!)
        }
        else if type.contains("deal into new stack") {
            self = .new
        }
        else if type.contains("cut") {
            self = .cut(number: Int(type.components(separatedBy: " ").last!)!)
        }
        else {
            return  nil
        }
    }
}

let types = input.compactMap { Type.init($0) }
let deck: [Int] = (0...10006).map{$0}
var result: [Int] = deck

func dealWithIncrement(_ n: Int, _ input: [Int]) -> [Int] {
    var result: [Int] = Array.init(repeating: -1, count: input.count)
    var newIndex = 0
    for (index, value) in input.enumerated() {
//        print("index: \(index) value:\(value)")
        if index == 0 {
            result[0] = value
        }
        else {
            newIndex += n
            if newIndex >= input.count {
                newIndex -= input.count
            }
            result[newIndex] = value
        }
//        print(newIndex)
//        print(result)
    }

    return result
}

func cut(_ n: Int, _ input: [Int]) -> [Int] {
    if n >= 0 {
        var top = Array(input[n...])
        let bottom = Array(input[...(n - 1)])
        top.append(contentsOf: bottom)
        return top
    }
    else {
        let count = n * -1
        var top = Array(input[(input.count - count)...])
        let bottom = Array(input[...(input.count - count - 1)])
        top.append(contentsOf: bottom)
        return top
    }
}

func partOne() {
    for type in types {
        switch type {
        case .new:
            result = result.reversed()
        case .cut(let number):
            result = cut(number, result)
            break
        case .increment(let number):
            result = dealWithIncrement(number, result)
            break
        }
        print(result)
    }
    print(result.firstIndex(of: 2019)!)
}

func powMod(_ num: Float , _ power: Float , _ mod : Float) -> Float {
    let power = pow(num, power)
    return power.truncatingRemainder(dividingBy: mod)
}

func partTwo() {
    let ld: Float = 119315717514047
    let card: Float = 2020
    let times: Float = 101741582076661
    var a: Float = 1
    var b: Float = 0
    for type in types {
        switch type {
        case .new:
            b += 1
            a *= -1
            b += -1
        case .cut(let number):
            b = b + Float(number)

        case .increment(let number):
            let p = powMod(Float(number),ld - 2,ld)
            a *= p
            b *= p
        }
        a = a.truncatingRemainder(dividingBy: ld)
        b = b.truncatingRemainder(dividingBy: ld)
    }
    print(a)
    print(b)
    let x = powMod(a, times, ld)
    let y = b * (powMod(a, times, ld) + (ld - 1))
    let z = powMod(Float(a - 1), ld - 2, ld)
    print(x  * card + y * z)
}

partOne()
partTwo()
