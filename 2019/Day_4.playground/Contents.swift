import Cocoa

let start: Int = 134792
let end: Int = 675810

//print(end - start)
extension BinaryInteger {
    var digits: [Int] {
        return String(describing: self).compactMap { Int(String($0)) }
    }
}

func partOne() {
    var count = 0
    for number in (start ... end) {
        let array = number.digits
        if array.sorted() == array {
            for pair in zip(array, array.dropFirst()) {
                if pair.0 == pair.1 {
                    count = count + 1
                    break;
                }
            }
        }
    }
    print(count)
}

func partTwo() {
    var total = 0
    for number in (start ... end) {
        let array = number.digits
        if array.sorted() == array {
            if (hasAtLeast2Pair(array)) {
                total += 1
            }
        }
    }
    print(total)
}

func hasAtLeast2Pair(_ array: Array<Int>) -> Bool {
    //print(zip(array, array.dropFirst()))
    var count = 0
    var dict: [Int:Int] = [:]
    var dupe = false
    for pair in zip(array, array.dropFirst()) {
//        print("\(pair.0) \(pair.1)")
        if pair.0 == pair.1 {
            count += 1
            dict[pair.0] = count
        }
        else {
            if count == 1 {
                dupe = true
                break
            }
            count = 0
        }
    }
    if count == 1 {
        dupe = true
    }
    return dupe
}

partOne()
partTwo()
