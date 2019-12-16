import Cocoa

var input = """
59750530221324194853012320069589312027523989854830232144164799228029162830477472078089790749906142587998642764059439173975199276254972017316624772614925079238407309384923979338502430726930592959991878698412537971672558832588540600963437409230550897544434635267172603132396722812334366528344715912756154006039512272491073906389218927420387151599044435060075148142946789007756800733869891008058075303490106699737554949348715600795187032293436328810969288892220127730287766004467730818489269295982526297430971411865028098708555709525646237713045259603175397623654950719275982134690893685598734136409536436003548128411943963263336042840301380655801969822
""".compactMap{Int(String($0))}

extension Collection where Index: Comparable {
    subscript(back i: Int) -> Iterator.Element {
        let backBy = i + 1
        return self[self.index(self.endIndex, offsetBy: -backBy)]
    }
}

extension Array {
  init(repeating: [Element], count: Int) {
    self.init([[Element]](repeating: repeating, count: count).flatMap{$0})
  }

  func repeated(count: Int) -> [Element] {
    return [Element](repeating: self, count: count)
  }
}

extension BinaryInteger {
    var digits: [Int] {
        return String(describing: self).compactMap { Int(String($0)) }
    }
}

func fft(_ input: [Int]) -> [Int] {
    var next:[Int] = Array.init(repeating: 0, count: input.count)
    var list: [Int] = input
    list.insert(0, at: 0)
    let pattern:[Int:Int] = [0:0, 1:1,2:0,3:-1]
    for i in (0 ..< input.count) {
        for j in (0 ..< list.count) {
            let value = (j / (i + 1)) % 4
            let y = pattern[value]!
            let x = list[j]
            next[i] += x * y
        }
    }
    next = next.map{ $0.digits.last! }
//    print(next)
    return next
}

func fft2(_ input: [Int]) -> [Int] {
    var next:[Int] = Array.init(repeating: 0, count: input.count)
    var ans = 0

    for i in (1 ... input.count/2) {
        ans += input[back: i]
        let index = next.index(next.endIndex, offsetBy: -(i+1))
        next[index] = ans
    }

    next = next.map{ abs($0)%10 }
    return next
}

func partOne() {
    var output: [Int] = input
    for a in (1 ... 100) {
        print("Processing \(a)")
        output = fft(output)
        print("ouput \(output[0...7])")
    }
    print("Part 1 answer is : \(output[0 ... 7])")
}



func partTwo() {
    var output: Array<Int> = Array.init(repeating: input, count: 10000)
    var offString = ""
    let array = output[0...6]
    _ = array.map{ a in offString = offString + "\(a)" }
    let offset = Int(offString)!
    for a in (1...100) {
        print("Processing \(a)")
        output = fft2(output)
        print("ouput \(output[0...7])")
    }
    print("Part 2 answer is : \(output[offset ... offset+7])")
}

partOne()
partTwo()
