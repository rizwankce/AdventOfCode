import Cocoa
import Darwin

let input = load(.input).trimmingCharacters(in: .newlines)

print(input)

extension ArraySlice where Element == Int {
    var intValue: Int {
        var value = 0
        for element in self {
            value *= 2
            value += element
        }
        return value
    }
}

func toBinary(_ hex: String) -> [Int] {
    let result = hex.compactMap { c -> [Int]? in
        guard let value = Int(String(c), radix: 16) else { return nil }
        let string = String(value, radix: 2)
        var intArray = string.map { Int(String($0))! }
        if intArray.count < 4 {
            for _ in 0 ..< 4 - intArray.count {
                intArray.insert(0, at: 0)
            }
        }
        return intArray
    }.joined()

    return Array(result)
}

struct Packet: CustomStringConvertible {
    let version: Int
    let typeId: Int
    var data: [Packet] = []
    var value: Int = 0

    init(version: Int, typeId: Int, data: [Packet] = [], value: Int = 0) {
        self.version = version
        self.typeId = typeId
        self.data = data
        self.value = value
    }

    func totalVersion() -> Int {
        version + data.map { $0.totalVersion() }.reduce(0, +)
    }

    func eval() -> Int {
        value
    }

    var description: String {
        "Version: \(version) TypeID: \(typeId) Value: \(value) Sub: \(data)"
    }
}

class PacketDecoder {
    let hex: String
    var rawBits: [Int] = []
    var index: Int

    init(_ hex: String) {
        self.hex = hex
        self.rawBits = toBinary(hex)
        self.index = rawBits.startIndex
        print(rawBits)
    }

    func getBitInt(_ offset: Int) -> Int {
        let end = rawBits.index(index, offsetBy: offset)
        let value = rawBits[index ..< end].intValue
        index += offset
        return value
    }

    func getBits(_ offset: Int) -> ArraySlice<Int> {
        let end = rawBits.index(index, offsetBy: offset)
        let bits = rawBits[index ..< end]
        index += offset
        return bits
    }

    func decode() -> Packet {
        let version = getBitInt(3)
        let tId = getBitInt(3)
        let data = decodeData(version, tId)
        return data
    }

    func decodeData(_ version: Int, _ typeId: Int) -> Packet {
        if typeId == 4 {
            return decodeLiteral(version, typeId)
        }
        return decodeOperator(version, typeId)
    }

    func decodeLiteral(_ version: Int, _ typeId: Int) -> Packet {
        var value: ArraySlice<Int> = []

        while true {
            let group = getBits(5)
            value.append(contentsOf:group.dropFirst())
            if group.first == 0 {
                break
            }
        }

        return Packet(version: version, typeId: typeId, value: value.intValue)
    }

    func decodeOperator(_ version: Int, _ typeId: Int) -> Packet {
        let lengthId = getBitInt(1)
        let subPackets = lengthId == 0 ? decodePacketsWithSubPackets(length: getBitInt(15)) : decodePacketsWithSubPackets(count: getBitInt(11))
        return Packet(version: version, typeId: typeId, data: subPackets, value: evalOperatorPackets(subPackets, typeId))
    }

    func decodePacketsWithSubPackets(count: Int) -> [Packet] {
        var subPackets: [Packet] = []
        for _ in 0 ..< count {
            subPackets.append(decode())
        }
        return subPackets
    }

    func decodePacketsWithSubPackets(length: Int) -> [Packet] {
        let end = index + length
        var subPackets: [Packet] = []

        while index < end {
            subPackets.append(decode())
        }
        return subPackets
    }

    func evalOperatorPackets(_ packets: [Packet], _ typeId: Int) -> Int {
        eval(packets.map(\.value), typeId)
    }

    func eval(_ values: [Int], _ typeId: Int) -> Int {
        switch typeId {
            case 0: return values.reduce(0, +)
            case 1: return values.reduce(1, *)
            case 2: return values.min()!
            case 3: return values.max()!
            case 5: return values[0] > values[1] ? 1 : 0
            case 6: return values[0] < values[1] ? 1 : 0
            case 7: return values[0] == values[1] ? 1 : 0
            default: fatalError("Type Id not supported")
        }
    }
}

let decoder = PacketDecoder(input)
let packet = decoder.decode()

func partOne() -> Int {
    return packet.totalVersion()
}

func partTwo() -> Int {
    return packet.eval()
}

print("Part One answer is: \(partOne())")
print("Part Two answer is: \(partTwo())")

enum PuzzleInput: String {
    case input = "input"
    case test  = "test_input"
}

func load(_ input: PuzzleInput) -> String {
    switch input {
    case .input:
        return load(file: "input")
    default:
        return load(file: "test_input")
    }
}

func load(file name: String) -> String {
    guard let url = Bundle.main.url(forResource: name, withExtension: "txt") else {
        fatalError("Cannot load file with name :\(name)")
    }

    guard let content = try? String(contentsOf: url, encoding: .utf8) else {
        fatalError("Cannot convert file contents to string for file :\(name)")
    }

    return content
}

